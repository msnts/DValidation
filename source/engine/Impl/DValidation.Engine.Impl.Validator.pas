unit DValidation.Engine.Impl.Validator;

interface
uses
  DValidation.Engine.Validator,
  System.Generics.Collections,
  DValidation.ConstraintViolation,
  DValidation.Engine.ValidationContext,
  DValidation.Engine.MetaData.ObjectMetaDataManager,
  DValidation.Engine.MetaData.ObjectMetaData,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.Engine.ValueContext,
  DValidation.Engine.Impl.ValueContext,
  DValidation.Engine.Impl.ValidationContext,
  DValidation.Engine.MetaData.Impl.ObjectMetaDataManager,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Engine.ConstraintValidatorManager;

type

  TValidator = class(TInterfacedObject)
  private
    FObjectMetaDataManager : IObjectMetaDataManager;
    FConstraintValidatorManager : IConstraintValidatorManager;

    function GetValidationContext<T>(Obj : T) : IValidationContext<T>;
    function DetermineGroupValidationOrder(Groups : TArray<string>) : TArray<string>;
    procedure ValidateConstraintsForCurrentGroup<T>(ValidationContext : IValidationContext<T>; ValueContext : IValueContext<T>);
    procedure ValidateMetaConstraints<T>(ValidationContext : IValidationContext<T>; ValueContext : IValueContext<T>; Constraints : TArray<IMetaConstraint>);
    procedure ValidateMetaConstraint<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; Constraint : IMetaConstraint);
    function ShouldFailFast<T>(Context : IValidationContext<T>) : Boolean;
    function IsValidationRequired<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; Constraint : IMetaConstraint) : Boolean;
  public
    constructor Create(aConstraintValidatorManager : IConstraintValidatorManager);
    function Validate<T : class>(Obj : T; Groups : TArray<string>) : TList<IConstraintViolation<T>>;
    function ValidateProperty(Obj : TObject; const PropertyName : string; Groups : TArray<string>) : TList<IConstraintViolation<Tobject>>;
  end;

implementation

{ TValidator }

constructor TValidator.Create(aConstraintValidatorManager : IConstraintValidatorManager);
begin
  FObjectMetaDataManager := TObjectMetaDataManager.Create;
  FConstraintValidatorManager := aConstraintValidatorManager;
end;

function TValidator.DetermineGroupValidationOrder(
  Groups: TArray<string>): TArray<string>;
begin
  Result := Groups;
end;

function TValidator.GetValidationContext<T>(
  Obj: T): IValidationContext<T>;
begin
  Result := TValidationContext<T>.Create(FObjectMetaDataManager, Obj);
end;

function TValidator.IsValidationRequired<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; Constraint : IMetaConstraint): Boolean;
begin

  Result := Constraint.getGroupList().contains(ValueContext.getCurrentGroup());


end;

function TValidator.ShouldFailFast<T>(Context: IValidationContext<T>): Boolean;
begin

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

end;

procedure TValidator.ValidateConstraintsForCurrentGroup<T>(ValidationContext : IValidationContext<T>; ValueContext : IValueContext<T>);
var
  ObjectMetaData : IObjectMetaData;
begin

  ObjectMetaData := FObjectMetaDataManager.GetObjectMetaData(ValueContext.GetCurrentObjectType());

  ValidateMetaConstraints<T>(ValidationContext, ValueContext, ObjectMetaData.GetMetaConstraints);

  ValidationContext.MarkCurrentBeanAsProcessed(ValueContext);

end;

procedure TValidator.ValidateMetaConstraint<T>(Context : IValidationContext<T>; ValueContext : IValueContext<T>; Constraint : IMetaConstraint);
var
  ConstraintValidator : IConstraintValidator<variant>;
begin

  ValueContext.SetMember(Constraint.GetMember);

  if not IsValidationRequired<T>(Context, ValueContext, Constraint) then
    Exit;

  ConstraintValidator := FConstraintValidatorManager.GetInitializedValidator(Constraint.GetConstraintType());

   if not ConstraintValidator.IsValid(ValueContext.GetCurrentValidatedValue()) then
   begin
     Context.AddConstraintViolations();
   end;


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

function TValidator.ValidateProperty(Obj: TObject;
  const PropertyName: string; Groups : TArray<string>): TList<IConstraintViolation<Tobject>>;
begin

end;

end.
