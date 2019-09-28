unit DValidation.Validators.NotEmptyValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation,
  DValidation.ConstraintValidators.NotEmptyValidatorForString,
  DValidation.Constraints.NotEmpty,
  DValidation.Engine.Impl.Validator,
  DValidation.Engine.ConstraintViolation,
  System.Generics.Collections;

type

  [TestFixture]
  TNotEmptyValidatorTest = class(TObject)
  private
    FValidator : TValidator;

    [NotEmpty]
    FValue : string;

    [NotEmpty]
    FInvalidCollectionsList : TList<integer>;

    [NotEmpty]
    FValidCollectionsList : TList<integer>;

    [NotEmpty]
    FInvalidArray : TArray<Integer>;

    [NotEmpty]
    FValidArray : TArray<Integer>;
  public

    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    [Test]
    procedure TestNotEmptyValidatorForString();

    [Test]
    procedure TestValidator();
  end;

implementation
uses System.SysUtils;

{ TNotEmptyValidatorTest }

procedure TNotEmptyValidatorTest.SetupFixture;
begin

  FValidator := TDValidation.GetInstance.BuildValidator;

  FInvalidCollectionsList := TList<integer>.Create;

  FValidCollectionsList := TList<integer>.Create;
end;

procedure TNotEmptyValidatorTest.TearDownFixture;
begin

  if Assigned(FValidator) then
    FValidator.Free;

  FInvalidCollectionsList.Free;

  FValidCollectionsList.Free;

end;

procedure TNotEmptyValidatorTest.TestNotEmptyValidatorForString();
var
  ConstraintValidator : TNotEmptyValidatorForString;
begin

  ConstraintValidator := TNotEmptyValidatorForString.Create ;

  try

    Assert.IsTrue(ConstraintValidator.IsValid('asfasd'), 'Test string');

    Assert.IsFalse(ConstraintValidator.IsValid(''));

  finally
    ConstraintValidator.Free;
  end;

end;

procedure TNotEmptyValidatorTest.TestValidator();
var
  Actual : Boolean;
  Faults : TList<IConstraintViolation<TNotEmptyValidatorTest>>;
begin
  FValue := 'test';

  FValidCollectionsList.Add(1);

  FValidArray := [1];

  Faults := FValidator.Validate<TNotEmptyValidatorTest>(Self);

  try
    Assert.AreEqual(Faults.Count, 2);
  finally
    Faults.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TNotEmptyValidatorTest);
end.

