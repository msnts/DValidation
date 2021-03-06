unit DValidation.Validators.DecimalMaxValidatorTest;

interface
uses
  System.Generics.Collections,
  DUnitX.TestFramework,
  DValidation,
  DValidation.ConstraintValidators.DecimalMaxValidator,
  DValidation.Constraints.DecimalMax,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TDecimalMaxValidatorTest = class(TObject)
  private
    FConstraintValidator : TDecimalMaxValidator;

    FValidator : TValidator;

    [DecimalMax(10)]
    FValue : double;
  public

    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    // Decimal values in Brazilian format
    [Test]
    [TestCase('Case 1','10,0; 1,1; 1', ';')]
    [TestCase('Case 2','10,0; 10; 1', ';')]
    [TestCase('Case 3','10,0; 11; 0', ';')]
    [TestCase('Case 4','10,0; -1; 1', ';')]
    procedure TestDecimalMaxValidator(const MaxValue, Value, ExpectedValue : double);

    [Test]
    [TestCase('Case 1','1, 1')]
    [TestCase('Case 2','10, 1')]
    [TestCase('Case 3','11, 0')]
    [TestCase('Case 4','-1, 1')]
    [TestCase('Case 5','1,357; 1', ';')]
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
var
  Attrib: DecimalMaxAttribute;
begin

  Attrib := DecimalMaxAttribute.Create(MaxValue);

  try
    FConstraintValidator.Initialize(Attrib);

    Assert.AreEqual(ExpectedValue <> 0, FConstraintValidator.isValid(Value));
  finally
    Attrib.Free;
  end;
end;

procedure TDecimalMaxValidatorTest.TestValidator(const Value, ExpectedValue: double);
var
  Actual : Boolean;
  Faults : TList<IConstraintViolation<TDecimalMaxValidatorTest>>;
begin

  FValue := Value;

  Faults := FValidator.Validate<TDecimalMaxValidatorTest>(Self);

  try
    Actual := Faults.Count = 0;

    Assert.AreEqual(ExpectedValue <> 0, Actual);
  finally
    Faults.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TDecimalMaxValidatorTest);
end.

