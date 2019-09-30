unit DValidation.Validators.MaxValidatorTest;

interface
uses
  System.Generics.Collections,

  DUnitX.TestFramework,
  DValidation,
  DValidation.ConstraintValidators.MaxValidator,
  DValidation.Constraints.Max,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TMaxValidatorTest = class(TObject)
  private
    FConstraintValidator : TMaxValidator;

    FValidator : TValidator;

    [Max(10)]
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
var
  Attrib: MaxAttribute;
begin

  Attrib := MaxAttribute.Create(MaxValue);

  try
    FConstraintValidator.Initialize(Attrib);

    Assert.AreEqual(ExpectedValue <> 0, FConstraintValidator.isValid(Value));
  finally
    Attrib.Free;
  end;
end;

procedure TMaxValidatorTest.TestValidator(const Value, ExpectedValue: Integer);
var
  Faults: TList<IConstraintViolation<TMaxValidatorTest>>;
begin

  FValue := Value;

  Faults := FValidator.Validate<TMaxValidatorTest>(Self);

  try
    Assert.AreEqual(ExpectedValue <> 0, Faults.Count = 0);
  finally
    Faults.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TMaxValidatorTest);
end.

