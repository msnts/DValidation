unit DValidation.Validators.EANValidatorTest;

interface
uses
  DUnitX.TestFramework,
  System.Generics.Collections,
  DValidation,
  DValidation.Constraints.EAN,
  DValidation.ConstraintValidators.EANValidator,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TEANValidatorTest = class(TObject)
  private
    [EAN]
    FValid : string;

    [EAN]
    FInvalid : string;

    FConstraintValidator : TEANValidator;

    FValidator : TValidator;

  public

    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    [Test]
    procedure TestEANConstraint;

    [Test]
    [TestCase('Case 1', '0,12345670,true')]
    [TestCase('Case 2', '0,12334568,true')]
    [TestCase('Case 3', '0,12334563,false')]
    [TestCase('Case 4', '1,1233456456742,true')]
    [TestCase('Case 4', '1,1233456456744,false')]
    procedure TestEANValidator(const TypeEAN: Integer; const Barcode: string; const Expected: Boolean);
  end;

implementation

{ TEANValidatorTest }

procedure TEANValidatorTest.SetupFixture;
begin
  FConstraintValidator := TEANValidator.Create;
  FValidator := TDValidation.GetInstance.BuildValidator;
end;

procedure TEANValidatorTest.TearDownFixture;
begin
  FConstraintValidator.Free;
  FValidator.Free;
end;

procedure TEANValidatorTest.TestEANConstraint;
var
  Faults : TList<IConstraintViolation<TEANValidatorTest>>;
begin

  FValid := '1233456456742';
  FInvalid := '1233456456744';

  Faults := FValidator.Validate<TEANValidatorTest>(Self, [0]);

  Assert.AreEqual(Faults.Count, 1);

  Faults.Free;

end;

procedure TEANValidatorTest.TestEANValidator(const TypeEAN: Integer; const Barcode: string; const Expected: Boolean);
var
  IsValid : Boolean;
begin

  FConstraintValidator.Initialize(EANAttribute.Create(TEAN(TypeEAN)));

  IsValid := FConstraintValidator.IsValid(Barcode);

  Assert.AreEqual(Expected, IsValid);

end;

initialization
  TDUnitX.RegisterTestFixture(TEANValidatorTest);
end.
