unit DValidation.Validators.AssertFalseValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation.ContraintValidators.AssertFalseValidator;

type

  [TestFixture]
  TAssertFalseValidatorTest = class(TObject) 
  public

    [Test]
    procedure testAssertFalseValidator;
  end;

implementation

{ TAssertFalseValidatorTest }

procedure TAssertFalseValidatorTest.testAssertFalseValidator;
var
  Validator : TAssertFalseValidator;
begin

  Validator := TAssertFalseValidator.Create;

  try

    Assert.IsFalse(Validator.isValid(true), 'True value validation must fail');
    Assert.IsTrue(Validator.isValid(false), 'False value validation must succeed');

  finally
    Validator.Free;
  end;

end;

initialization
  TDUnitX.RegisterTestFixture(TAssertFalseValidatorTest);
end.
