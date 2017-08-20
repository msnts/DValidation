unit DValidation.Validators.MaxValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation,
  DValidation.ContraintValidators.MaxValidator,
  DValidation.Constraints.Max,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TMaxValidatorTest = class(TObject)
  private
    FConstraintValidator : TMaxValidator;

    FValidator : TValidator;

    [Max('{"Max":10}')]
    FValue : Integer;
  public

    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    [Test]
    [TestCase('Case 1','10, 1, 1')]
    [TestCase('Case 2','10, 10, 1')]
    [TestCase('Case 3','10, 11, 0')]
    [TestCase('Case 4','10, -1, 1')]
    procedure TestMaxValidator(const MaxValue, Value, ExpectedValue : Integer);

    [Test]
    [TestCase('Case 1','1, 1')]
    [TestCase('Case 2','10, 1')]
    [TestCase('Case 3','11, 0')]
    [TestCase('Case 4','-1, 1')]
    procedure TestValidator(const Value, ExpectedValue : Integer);
  end;

implementation
uses System.SysUtils;

{ TMaxValidatorTest }

procedure TMaxValidatorTest.SetupFixture;
begin

  FConstraintValidator := TMaxValidator.Create;

  FValidator := TDValidation.GetInstance.BuildValidator;

end;

procedure TMaxValidatorTest.TearDownFixture;
begin

  FConstraintValidator.Free;

  if Assigned(FValidator) then
    FValidator.Free;

end;

procedure TMaxValidatorTest.TestMaxValidator(const MaxValue, Value, ExpectedValue : Integer);
begin

  FConstraintValidator.Initialize(MaxAttribute.Create('{"Max":' + string.Parse(MaxValue) + '}'));

  Assert.AreEqual(ExpectedValue <> 0, FConstraintValidator.isValid(Value));

end;

procedure TMaxValidatorTest.TestValidator(const Value, ExpectedValue: Integer);
var
  Actual : Boolean;
begin

  FValue := Value;

  Actual := FValidator.Validate<TMaxValidatorTest>(Self).Count = 0;

  Assert.AreEqual(ExpectedValue <> 0, Actual);

end;

initialization
  TDUnitX.RegisterTestFixture(TMaxValidatorTest);
end.

