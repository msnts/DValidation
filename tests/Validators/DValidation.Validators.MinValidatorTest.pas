unit DValidation.Validators.MinValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation,
  DValidation.ContraintValidators.MinValidator,
  DValidation.Constraints.Min,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TMinValidatorTest = class(TObject)
  private
    FConstraintValidator : TMinValidator;

    FValidator : TValidator;

    [Min('{"Min":10}')]
    FValue : Integer;
  public

    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    [Test]
    [TestCase('Case 1','10, 10, 1')]
    [TestCase('Case 2','10, 11, 1')]
    [TestCase('Case 3','10, 9, 0')]
    [TestCase('Case 4','-100, -1, 1')]
    [TestCase('Case 4','0, -1, 0')]
    procedure TestMinValidator(const MinValue, Value, ExpectedValue : Integer);

    [Test]
    [TestCase('Case 1','10, 1')]
    [TestCase('Case 2','11, 1')]
    [TestCase('Case 3','9, 0')]
    [TestCase('Case 4','-1, 0')]
    procedure TestValidator(const Value, ExpectedValue : Integer);
  end;

implementation
uses System.SysUtils;

{ TMinValidatorTest }

procedure TMinValidatorTest.SetupFixture;
begin

  FConstraintValidator := TMinValidator.Create;

  FValidator := TDValidation.GetInstance.BuildValidator;

end;

procedure TMinValidatorTest.TearDownFixture;
begin

  FConstraintValidator.Free;

  if Assigned(FValidator) then
    FValidator.Free;

end;

procedure TMinValidatorTest.TestMinValidator(const MinValue, Value, ExpectedValue : Integer);
begin

  FConstraintValidator.Initialize(MinAttribute.Create('{"Min":' + string.Parse(MinValue) + '}'));

  Assert.AreEqual(ExpectedValue <> 0, FConstraintValidator.isValid(Value));

end;

procedure TMinValidatorTest.TestValidator(const Value, ExpectedValue: Integer);
var
  Actual : Boolean;
begin

  Actual := FValidator.Validate<TMinValidatorTest>(Self).Count = 0;

  Assert.AreEqual(ExpectedValue <> 0, Actual);

end;

initialization
  TDUnitX.RegisterTestFixture(TMinValidatorTest);
end.

