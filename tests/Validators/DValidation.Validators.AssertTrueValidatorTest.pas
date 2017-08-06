unit DValidation.Validators.AssertTrueValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation.ContraintValidators.AssertTrueValidator;

type

  [TestFixture]
  TAssertTrueValidatorTest = class(TObject)
  public

    [Test]
    procedure testAssertTrueValidator;
  end;

implementation

{ TAssertTrueValidatorTest }

procedure TAssertTrueValidatorTest.testAssertTrueValidator;
var
  Validator : TAssertTrueValidator;
begin

  Validator := TAssertTrueValidator.Create;

  try

    Assert.IsFalse(Validator.isValid(False), 'False value validation must fail');
    Assert.IsTrue(Validator.isValid(True), 'True value validation must succeed');

  finally
    Validator.Free;
  end;

end;

initialization
  TDUnitX.RegisterTestFixture(TAssertTrueValidatorTest);
end.

