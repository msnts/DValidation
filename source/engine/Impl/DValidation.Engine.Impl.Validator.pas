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
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Engine.ConstraintValidatorManager,
  DValidation.Engine.MessageInterpolator,
  DValidation.Engine.Impl.MessageInterpolator,
  DValidation.I18n.Impl.Locale;

type

  TValidator = class(TInterfacedObject)
  private
    FObjectMetaDataManager : IObjectMetaDataManager;
    FConstraintValidatorManager : IConstraintValidatorManager;
    FMessageInterpolator : IMessageInterpolator;

    function GetValidationContext<T>(Obj : T) : IValidationContext<T>;
    function DetermineGroupValidationOrder(Groups : TArray<string>) : TArray<string>;
    procedure ValidateConstraintsForCurrentGroup<T>(ValidationContext : IValidationContext<T>; ValueContext : IValueContext<T>);
    procedure ValidateMetaConstraints<T>(ValidationContext : IValidationContext<T>; ValueContext : IValueContext<T>; Constraints : TArray<IMetaConstraint>);
    procedure ValidateMetaConstraint<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; MetaConstraint : IMetaConstraint);
    function ShouldFailFast<T>(Context : IValidationContext<T>) : Boolean;
    function IsValidationRequired<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; Constraint : IMetaConstraint) : Boolean;
  public
    constructor Create(aConstraintValidatorManager : IConstraintValidatorManager);
    function Validate<T : class>(Obj : T) : TList<IConstraintViolation<T>>; overload;
    function Validate<T : class>(Obj : T; Groups : TArray<string>) : TList<IConstraintViolation<T>>; overload;
  end;

implementation

{ TValidator }

constructor TValidator.Create(aConstraintValidatorManager : IConstraintValidatorManager);
begin
  FObjectMetaDataManager := TObjectMetaDataManager.Create;
  FConstraintValidatorManager := aConstraintValidatorManager;
  FMessageInterpolator := TMessageInterpolator.Create(TLocale.Create);
end;

function TValidator.DetermineGroupValidationOrder(
  Groups: TArray<string>): TArray<string>;
begin
  Result := Groups;
end;

function TValidator.GetValidationContext<T>(
  Obj: T): IValidationContext<T>;
begin
  Result := TValidationContext<T>.Create(FObjectMetaDataManager, FMessageInterpolator, Obj);
end;

function TValidator.IsValidationRequired<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; Constraint : IMetaConstraint): Boolean;
begin

  Result := Constraint.getGroupList().contains(ValueContext.getCurrentGroup());

end;

function TValidator.ShouldFailFast<T>(Context: IValidationContext<T>): Boolean;
begin
  Result := Context.IsFailFastModeEnabled() and not Context.HasFailingConstraints();
end;

function TValidator.Validate<T>(Obj: T; Groups : TArray<string>): TList<IConstraintViolation<T>>;
var
  ValidationContext : IValidationContext<T>;
  ValueContext : IValueContext<T>;
  ValidationOrder : TArray<string>;
  Group : string;
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

  Result := Validate<T>(Obj, ['DEFAULT']);

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
  ConstraintValidator : IConstraintValidator<variant>;
  IsValid : Boolean;
begin

  ValueContext.SetMember(MetaConstraint.GetMember);

  if not IsValidationRequired<T>(Context, ValueContext, MetaConstraint) then
    Exit;

  ConstraintValidator := FConstraintValidatorManager.GetInitializedValidator(MetaConstraint.GetConstraintType());

  try

    ConstraintValidator.Initialize(MetaConstraint.GetConstraint);

    IsValid := ConstraintValidator.IsValid(ValueContext.GetCurrentValidatedValue());
  except
    raise ValidationException.Create('Unexpected exception during isValid call');
  end;

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
