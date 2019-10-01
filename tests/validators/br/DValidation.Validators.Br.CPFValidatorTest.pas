unit DValidation.Validators.Br.CPFValidatorTest;

interface
uses
  System.Generics.Collections,

  DUnitX.TestFramework,

  DValidation,
  DValidation.Constraints.Br.CPF,
  DValidation.ConstraintValidators.Br.CPFValidator,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TCPFValidatorTest = class(TObject)
  private
    [CPF]
    FValue: string;
  public
    [TestCase('Empty CPF', ',0')]
    [TestCase('Valid unformatted CPF', '59011325052,0')]
    [TestCase('Invalid unformatted CPF', '51011325052,1')]
    [TestCase('Valid formatted CPF', '590.113.250-52,0')]
    [TestCase('Invalid unformatted CPF', '580.113.250-52,1')]
    [TestCase('Invalid CPF with repeated digits', '00000000000,1')]
    [TestCase('CPF smaller than expected', '11,1')]
    [TestCase('CPF larger than expected', '1111111111111111,1')]
    procedure TestCPFConstraint(const AValue: string; const AExpected: Integer);

    [TestCase('Empty CPF', ',true')]
    [TestCase('Valid unformatted CPF', '59011325052,true')]
    [TestCase('Invalid unformatted CPF', '51011325052,false')]
    [TestCase('Valid formatted CPF', '590.113.250-52,true')]
    [TestCase('Invalid unformatted CPF', '580.113.250-52,false')]
    [TestCase('Invalid CPF with repeated digits', '00000000000,false')]
    [TestCase('CPF smaller than expected', '11,false')]
    [TestCase('CPF larger than expected', '1111111111111111,false')]
    procedure TestCPFValidator(const AValue: string; const AExpected: Boolean);
  end;

implementation

{ TCPFValidatorTest }

procedure TCPFValidatorTest.TestCPFConstraint(const AValue: string; const AExpected: Integer);
var
  Validator: TValidator;
  Faults: TList<IConstraintViolation<TCPFValidatorTest>>;
begin
  FValue := AValue;

  Validator := TDValidation.GetInstance.BuildValidator;

  try
    Faults := Validator.Validate<TCPFValidatorTest>(Self, [0]);

    Assert.AreEqual(AExpected, Faults.Count);
  finally
    Validator.Free;
    Faults.Free;
  end;
end;

procedure TCPFValidatorTest.TestCPFValidator(const AValue: string; const AExpected: Boolean);
var
  Validator: TCPFValidator;
begin
  Validator := TCPFValidator.Create;

  try
    Assert.AreEqual(AExpected, Validator.IsValid(AValue));
  finally
    Validator.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TCPFValidatorTest);
end.
