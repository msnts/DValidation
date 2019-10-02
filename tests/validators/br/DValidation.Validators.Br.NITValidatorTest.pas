unit DValidation.Validators.Br.NITValidatorTest;

interface
uses
  System.Generics.Collections,

  DUnitX.TestFramework,

  DValidation,
  DValidation.Constraints.Br.NIT,
  DValidation.ConstraintValidators.Br.NITValidator,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TNITValidatorTest = class(TObject)
  private
    [NIT]
    FValue: string;
  public
    [TestCase('Empty NIT', ',0')]
    [TestCase('Valid unformatted NIT', '97261389915,0')]
    [TestCase('Invalid unformatted NIT', '97261389914,1')]
    [TestCase('Valid formatted NIT', '972.61389.91-5,0')]
    [TestCase('Invalid unformatted NIT', '972.61389.91-3,1')]
    [TestCase('Invalid NIT with repeated digits', '111111111111,1')]
    [TestCase('NIT smaller than expected', '11,1')]
    [TestCase('NIT larger than expected', '111111111111,1')]
    procedure TestNITConstraint(const AValue: string; const AExpected: Integer);

    [TestCase('Empty NIT', ',true')]
    [TestCase('Valid unformatted NIT', '97261389915,true')]
    [TestCase('Invalid unformatted NIT', '97261389914,false')]
    [TestCase('Valid formatted NIT', '972.61389.91-5,true')]
    [TestCase('Invalid unformatted NIT', '972.61389.91-3,false')]
    [TestCase('Invalid NIT with repeated digits', '111111111111,false')]
    [TestCase('NIT smaller than expected', '11,false')]
    [TestCase('NIT larger than expected', '111111111111,false')]
    procedure TestNITValidator(const AValue: string; const AExpected: Boolean);
  end;

implementation

{ TNITValidatorTest }

procedure TNITValidatorTest.TestNITConstraint(const AValue: string; const AExpected: Integer);
var
  Validator : TValidator;
  Faults : TList<IConstraintViolation<TNITValidatorTest>>;
begin
  FValue := AValue;

  Validator := TDValidation.GetInstance.BuildValidator;

  Faults := Validator.Validate<TNITValidatorTest>(Self, [0]);

  try
    Assert.AreEqual(AExpected, Faults.Count);
  finally
    Validator.Free;
    Faults.Free;
  end;
end;

procedure TNITValidatorTest.TestNITValidator(const AValue: string; const AExpected: Boolean);
var
  Validator : TNITValidator;
begin
  Validator := TNITValidator.Create;

  try
    Assert.AreEqual(AExpected, Validator.IsValid(AValue));
  finally
    Validator.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TNITValidatorTest);
end.
