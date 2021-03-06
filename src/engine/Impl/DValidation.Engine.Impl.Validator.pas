{ ******************************************************************************
  Copyright 2017 Marcos Santos

  Contact: marcos.santos@outlook.com

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  *****************************************************************************}

unit DValidation.Engine.Impl.Validator;

interface
uses
  System.Rtti,
  DValidation.Exceptions,
  DValidation.Engine.Validator,
  System.Generics.Collections,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.ValidationContext,
  DValidation.Engine.MetaData.ObjectMetaDataManager,
  DValidation.Engine.MetaData.ObjectMetaData,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.Engine.ValueContext,
  DValidation.Engine.Impl.ValueContext,
  DValidation.Engine.Impl.ValidationContext,
  DValidation.Engine.MetaData.Impl.ObjectMetaDataManager,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Engine.ConstraintValidatorManager,
  DValidation.Engine.MessageInterpolator,
  DValidation.Engine.Impl.MessageInterpolator,
  DValidation.Constraints.Constraint,
  DValidation.I18n.Impl.Locale;

type

  TValidator = class(TInterfacedObject)
  private
    FObjectMetaDataManager : IObjectMetaDataManager;
    FConstraintValidatorManager : IConstraintValidatorManager;
    FMessageInterpolator : IMessageInterpolator;

    function GetValidationContext<T>(Obj : T) : IValidationContext<T>;
    function DetermineGroupValidationOrder(Groups : TGroupSet) : TGroupSet;
    procedure ValidateConstraintsForCurrentGroup<T>(ValidationContext : IValidationContext<T>; ValueContext : IValueContext<T>);
    procedure ValidateMetaConstraints<T>(ValidationContext : IValidationContext<T>; ValueContext : IValueContext<T>; Constraints : TArray<IMetaConstraint>);
    procedure ValidateMetaConstraint<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; MetaConstraint : IMetaConstraint);
    function ShouldFailFast<T>(Context : IValidationContext<T>) : Boolean;
    function IsValidationRequired<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; Constraint : IMetaConstraint) : Boolean;
    function DoValidateMetaConstraint<T>(ValueContext : IValueContext<T>; Constraint : IMetaConstraint) : Boolean;
    function DoValidate<T, V>(MetaConstraint : IMetaConstraint; Value : V) : Boolean;
  public
    constructor Create(aConstraintValidatorManager : IConstraintValidatorManager);
    function Validate<T : class>(Obj : T) : TList<IConstraintViolation<T>>; overload;
    function Validate<T : class>(Obj : T; Groups : TGroupSet) : TList<IConstraintViolation<T>>; overload;
  end;

implementation

{ TValidator }

constructor TValidator.Create(aConstraintValidatorManager : IConstraintValidatorManager);
begin
  FObjectMetaDataManager := TObjectMetaDataManager.Create;
  FConstraintValidatorManager := aConstraintValidatorManager;
  FMessageInterpolator := TMessageInterpolator.Create(TLocale.Create);
end;

function TValidator.DetermineGroupValidationOrder(Groups: TGroupSet): TGroupSet;
begin
  Result := Groups;
end;

function TValidator.DoValidate<T, V>(MetaConstraint : IMetaConstraint; Value : V): Boolean;
var
  ConstraintValidator : IConstraintValidator<V>;
begin

  ConstraintValidator := IConstraintValidator<V>(FConstraintValidatorManager.GetInitializedValidator(MetaConstraint.GetConstraintType(), TypeInfo(V)));

  try

    ConstraintValidator.Initialize(MetaConstraint.GetConstraint);

    Result := ConstraintValidator.IsValid(Value)

  except
    raise ValidationException.Create('Unexpected exception during isValid call');
  end;

end;

function TValidator.DoValidateMetaConstraint<T>(ValueContext: IValueContext<T>;
  Constraint: IMetaConstraint): Boolean;
var
  Value : TValue;
begin

  Value := ValueContext.GetCurrentValidatedValue();

  case Value.Kind of

    tkInteger, tkInt64:
      Result := DoValidate<T, Int64>(Constraint, Value.AsInt64);
    tkFloat:
      Result := DoValidate<T, Extended>(Constraint, Value.AsExtended);
    tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
      Result := DoValidate<T, string>(Constraint, Value.AsString);
    tkEnumeration:
    begin
      if Value.TypeInfo.Name = 'Boolean' then
        Result := DoValidate<T, Boolean>(Constraint, Value.AsBoolean)
      else
        raise ValidationException.Create('Type not supported');

    end;
 //   tkSet: ;
    tkClass:
     Result := DoValidate<T, TObject>(Constraint, Value.AsObject);
  //  tkMethod: ;
   // tkVariant,
    tkArray, tkDynArray:
      Result := DoValidate<T, TValue>(Constraint, Value);
    //tkRecord: ;
   // tkInterface:
   //   Result := Constraint.IsValid(Value.AsInterface);
 //   tkClassRef: ;
 //   tkPointer: ;
 //   tkProcedure: ;
  else
    raise ValidationException.Create('Type not supported');
  end;

end;

function TValidator.GetValidationContext<T>(Obj: T): IValidationContext<T>;
begin
  Result := TValidationContext<T>.Create(FObjectMetaDataManager, FMessageInterpolator, Obj);
end;

function TValidator.IsValidationRequired<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; Constraint : IMetaConstraint): Boolean;
begin

  Result := ValueContext.GetCurrentGroup in Constraint.GetGroupList;

  //Result := Constraint.getGroupList().contains(ValueContext.getCurrentGroup());

end;

function TValidator.ShouldFailFast<T>(Context: IValidationContext<T>): Boolean;
begin
  Result := Context.IsFailFastModeEnabled() and not Context.HasFailingConstraints();
end;

function TValidator.Validate<T>(Obj: T; Groups: TGroupSet): TList<IConstraintViolation<T>>;
var
  ValidationContext : IValidationContext<T>;
  ValueContext : IValueContext<T>;
  ValidationOrder : TGroupSet;
  Group : Byte;
begin

  ValidationContext := GetValidationContext<T>(Obj);

  if not ValidationContext.GetRootObjectMetaData().HasConstraints() then
	begin
    Result := TList<IConstraintViolation<T>>.Create;
    Exit;
  end;

  ValueContext := TValueContext<T>.Create(Obj, ValidationContext.GetRootObjectMetaData());

  ValidationOrder := DetermineGroupValidationOrder(Groups);

  for Group in ValidationOrder do
  begin

    ValueContext.SetCurrentGroup(Group);

    ValidateConstraintsForCurrentGroup<T>(ValidationContext, ValueContext);

    if ShouldFailFast<T>(ValidationContext) then
    begin
				Result := ValidationContext.GetFailingConstraints();
        Exit;
    end;

  end;

  Result := ValidationContext.GetFailingConstraints();

end;

function TValidator.Validate<T>(Obj: T): TList<IConstraintViolation<T>>;
begin

  Result := Validate<T>(Obj, [0]);

end;

procedure TValidator.ValidateConstraintsForCurrentGroup<T>(ValidationContext : IValidationContext<T>; ValueContext : IValueContext<T>);
var
  ObjectMetaData : IObjectMetaData;
begin

  ObjectMetaData := FObjectMetaDataManager.GetObjectMetaData(ValueContext.GetCurrentObjectType());

  ValidateMetaConstraints<T>(ValidationContext, ValueContext, ObjectMetaData.GetMetaConstraints);

  ValidationContext.MarkCurrentBeanAsProcessed(ValueContext);

end;

procedure TValidator.ValidateMetaConstraint<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; MetaConstraint : IMetaConstraint);
var
  IsValid : Boolean;
begin

  ValueContext.SetMember(MetaConstraint.GetMember);

  if not IsValidationRequired<T>(Context, ValueContext, MetaConstraint) then
    Exit;

  IsValid := DoValidateMetaConstraint<T>(ValueContext, MetaConstraint);

  if not IsValid then
    Context.AddConstraintViolation(ValueContext, MetaConstraint);

 // Context.MarkConstraintProcessed<T>(ValueContext);

end;

procedure TValidator.ValidateMetaConstraints<T>(
  ValidationContext: IValidationContext<T>; ValueContext : IValueContext<T>; Constraints: TArray<IMetaConstraint>);
var
  Constraint : IMetaConstraint;
begin

  for Constraint in Constraints do
  begin

    ValidateMetaConstraint<T>(ValidationContext, ValueContext, Constraint);

    if ShouldFailFast<T>(ValidationContext) then
      Exit;

  end;

end;

end.
