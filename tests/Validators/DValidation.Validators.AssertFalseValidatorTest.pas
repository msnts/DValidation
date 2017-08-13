unit DValidation.Validators.AssertFalseValidatorTest;

interface
uses
  DUnitX.TestFramework,
  System.Generics.Collections,
  DValidation,
  DValidation.Constraints.AssertFalse,
  DValidation.ContraintValidators.AssertFalseValidator,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TAssertFalseValidatorTest = class(TObject)
  private
    [AssertFalse]
    FValid : Boolean;

    [AssertFalse]
    FInvalid : Boolean;
  public

    [Test]
    procedure TestAssertFalseConstraint;

    [Test]
    procedure TestAssertFalseValidator;
  end;

implementation

{ TAssertFalseValidatorTest }

procedure TAssertFalseValidatorTest.TestAssertFalseConstraint;
var
  Validator : TValidator;
  Faults : TList<IConstraintViolation<TAssertFalseValidatorTest>>;
begin

  FValid := True;
  FInvalid := False;

  Validator := TDValidation.GetInstance.BuildValidator;

  try

    Faults := Validator.Validate<TAssertFalseValidatorTest>(Self, ['DEFAULT']);

    Assert.AreEqual(Faults.Count, 1);

  finally
    Validator.Free;
  end;

end;

procedure TAssertFalseValidatorTest.TestAssertFalseValidator;
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
