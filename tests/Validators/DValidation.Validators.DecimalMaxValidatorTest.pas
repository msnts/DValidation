unit DValidation.Validators.DecimalMaxValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation,
  DValidation.ContraintValidators.DecimalMaxValidator,
  DValidation.Constraints.DecimalMax,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TDecimalMaxValidatorTest = class(TObject)
  private
    FConstraintValidator : TDecimalMaxValidator;

    FValidator : TValidator;

    [DecimalMax('{"Max":10.0}')]
    FValue : double;
  public

    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    [Test]
    [TestCase('Case 1','10.0, 1.1, 1')]
    [TestCase('Case 2','10.0, 10, 1')]
    [TestCase('Case 3','10.0, 11, 0')]
    [TestCase('Case 4','10.0, -1, 1')]
    procedure TestDecimalMaxValidator(const MaxValue, Value, ExpectedValue : double);

    [Test]
    [TestCase('Case 1','1, 1')]
    [TestCase('Case 2','10, 1')]
    [TestCase('Case 3','11, 0')]
    [TestCase('Case 4','-1, 1')]
    procedure TestValidator(const Value, ExpectedValue : double);
  end;

implementation
uses System.SysUtils;

{ TDecimalMaxValidatorTest }

procedure TDecimalMaxValidatorTest.SetupFixture;
begin

  FConstraintValidator := TDecimalMaxValidator.Create;

  FValidator := TDValidation.GetInstance.BuildValidator;

end;

procedure TDecimalMaxValidatorTest.TearDownFixture;
begin

  FConstraintValidator.Free;

  if Assigned(FValidator) then
    FValidator.Free;

end;

procedure TDecimalMaxValidatorTest.TestDecimalMaxValidator(const MaxValue, Value, ExpectedValue : double);
begin

  FConstraintValidator.Initialize(DecimalMaxAttribute.Create('{"Max":' + string.Parse(MaxValue) + '}'));

  Assert.AreEqual(ExpectedValue <> 0, FConstraintValidator.isValid(Value));

end;

procedure TDecimalMaxValidatorTest.TestValidator(const Value, ExpectedValue: double);
var
  Actual : Boolean;
begin

  Actual := FValidator.Validate<TDecimalMaxValidatorTest>(Self).Count = 0;

  Assert.AreEqual(ExpectedValue <> 0, Actual);

end;

initialization
  TDUnitX.RegisterTestFixture(TDecimalMaxValidatorTest);
end.

