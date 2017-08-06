unit DValidation;

interface
uses
  System.Generics.Collections,
  System.TypInfo,
  DValidation.Constraints.Constraint,
  DValidation.Engine.Validator,
  DValidation.Engine.Impl.Validator,
  DValidation.Engine.ConstraintValidatorManager,
  DValidation.Engine.Impl.ConstraintValidatorManager;

type

  TDValidation = class
  private
      class var FInstance : TDValidation;
  private
    FConstraintValidatorRegister : TDictionary<PTypeInfo, TClass>;
  private
      class procedure ReleaseInstance();
  public
      class function GetInstance() : TDValidation;
      constructor Create();
      destructor Destroy(); override;
      function BuildValidator() : TValidator;
      class procedure RegisterConstraint(Contraint, ContraintValidator : TClass);
  end;

implementation

{ TDValidation }

function TDValidation.BuildValidator: TValidator;
var
  Manager : IConstraintValidatorManager;
begin

  Manager := TConstraintValidatorManager.Create(FConstraintValidatorRegister);

  Result := TValidator.Create(Manager);

end;

constructor TDValidation.Create;
begin
  FConstraintValidatorRegister := TDictionary<PTypeInfo,TClass>.Create;
end;

destructor TDValidation.Destroy;
begin
  FConstraintValidatorRegister.Free;
  inherited;
end;

class function TDValidation.GetInstance: TDValidation;
begin
  if not Assigned(Self.FInstance) then
      Self.FInstance := TDValidation.Create;

   Result := Self.FInstance
end;

class procedure TDValidation.RegisterConstraint(Contraint,
  ContraintValidator: TClass);
begin
  FInstance.FConstraintValidatorRegister.Add(Contraint.ClassInfo, ContraintValidator);
end;

class procedure TDValidation.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    Self.FInstance.Free;
end;

initialization

   TDValidation.GetInstance;

finalization
   TDValidation.ReleaseInstance;

end.
