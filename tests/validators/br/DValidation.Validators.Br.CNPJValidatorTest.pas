unit DValidation.Validators.Br.CNPJValidatorTest;

interface
uses
  System.Generics.Collections,

  DUnitX.TestFramework,

  DValidation,
  DValidation.Constraints.Br.CNPJ,
  DValidation.ConstraintValidators.Br.CNPJValidator,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TCNPJValidatorTest = class(TObject)
  private
    [CNPJ]
    FValue: string;
  public
    [TestCase('Empty CNPJ', ',0')]
    [TestCase('Valid unformatted cnpj', '77725483000116,0')]
    [TestCase('Invalid unformatted cnpj', '777254830001161,1')]
    [TestCase('Valid formatted cnpj', '77.725.483/0001-16,0')]
    [TestCase('Invalid unformatted cnpj', '77.254.830/0001-61,1')]
    [TestCase('Invalid CNPJ with repeated digits', '11111111111111,1')]
    [TestCase('CNPJ smaller than expected', '11,1')]
    [TestCase('CNPJ larger than expected', '1111111111111111,1')]
    procedure TestCNPJConstraint(const AValue: string; const AExpected: Integer);

    [TestCase('Empty CNPJ', ',true')]
    [TestCase('Valid unformatted cnpj', '77725483000116,true')]
    [TestCase('Invalid unformatted cnpj', '777254830001161,false')]
    [TestCase('Valid formatted cnpj', '77.725.483/0001-16,true')]
    [TestCase('Invalid unformatted cnpj', '77.254.830/0001-61,false')]
    [TestCase('Invalid CNPJ with repeated digits', '11111111111111,false')]
    [TestCase('CNPJ smaller than expected', '11,false')]
    [TestCase('CNPJ larger than expected', '1111111111111111,false')]
    procedure TestCNPJValidator(const AValue: string; const AExpected: Boolean);
  end;

implementation

{ TCNPJValidatorTest }

procedure TCNPJValidatorTest.TestCNPJConstraint(const AValue: string; const AExpected: Integer);
var
  Validator : TValidator;
  Faults : TList<IConstraintViolation<TCNPJValidatorTest>>;
begin
  FValue := AValue;

  Validator := TDValidation.GetInstance.BuildValidator;

  Faults := Validator.Validate<TCNPJValidatorTest>(Self, [0]);

  try
    Assert.AreEqual(AExpected, Faults.Count);
  finally
    Validator.Free;
    Faults.Free;
  end;
end;

procedure TCNPJValidatorTest.TestCNPJValidator(const AValue: string; const AExpected: Boolean);
var
  Validator : TCNPJValidator;
begin
  Validator := TCNPJValidator.Create;

  try
    Assert.AreEqual(AExpected, Validator.IsValid(AValue));
  finally
    Validator.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TCNPJValidatorTest);
end.
