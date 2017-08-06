unit DValidation.Engine.Impl.ConstraintValidatorManager;

interface
uses
  System.Generics.Collections,
  System.TypInfo,
  System.SysUtils,
  DValidation.Engine.ConstraintValidatorManager,
  DValidation.ContraintValidators.ConstraintValidator;

type

  TConstraintValidatorManager = class(TInterfacedObject, IConstraintValidatorManager)
  private
    FConstraintValidatorRegister : TDictionary<PTypeInfo, TClass>;
  public
    constructor Create(aConstraintValidatorRegister : TDictionary<PTypeInfo, TClass>);
    function GetInitializedValidator(aType : PTypeInfo) : IConstraintValidator<variant>;
  end;

implementation

{ TConstraintValidatorManager }

constructor TConstraintValidatorManager.Create(
  aConstraintValidatorRegister: TDictionary<PTypeInfo, TClass>);
begin
  FConstraintValidatorRegister := aConstraintValidatorRegister;
end;

function TConstraintValidatorManager.GetInitializedValidator(aType : PTypeInfo): IConstraintValidator<variant>;
var
  Clazz : TClass;
  Validator : TInterfacedObject;
begin

  if not FConstraintValidatorRegister.TryGetValue(aType, Clazz) then
    raise Exception.Create('Not found constraint validator for ' + aType.Name);

  Validator := Clazz.Create as TInterfacedObject;

  Result := Validator as IConstraintValidator<variant>;

end;

end.
