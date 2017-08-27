unit DValidation.Validators.NotEmptyValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation,
  DValidation.ContraintValidators.NotEmptyValidatorForString,
  DValidation.Constraints.NotEmpty,
  DValidation.Engine.Impl.Validator,
  DValidation.Engine.ConstraintViolation,
  System.Generics.Collections;

type

  [TestFixture]
  TNotEmptyValidatorTest = class(TObject)
  private
    FValidator : TValidator;

    [NotEmpty('')]
    FValue : string;

    [NotEmpty('')]
    FCollectionsList : TList<integer>;

    [NotEmpty('')]
    FArray : TArray<Integer>;

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

  FCollectionsList := TList<integer>.Create;

end;

procedure TNotEmptyValidatorTest.TearDownFixture;
begin

  if Assigned(FValidator) then
    FValidator.Free;

  FCollectionsList.Free;

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

  FCollectionsList.Add(1);

  Faults := FValidator.Validate<TNotEmptyValidatorTest>(Self);

  Actual := Faults.Count = 0;

  Assert.IsTrue(Actual);

end;

initialization
  TDUnitX.RegisterTestFixture(TNotEmptyValidatorTest);
end.

