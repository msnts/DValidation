unit DValidation.Validators.PastValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation,
  DValidation.ContraintValidators.PastValidatorForDate,
  DValidation.Constraints.Past,
  DValidation.Engine.Impl.Validator;

type

  [TestFixture]
  TPastValidatorTest = class(TObject)
  private

    FValidator : TValidator;

    FValue : Integer;
  public

    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    [Test]
    procedure TestPastValidatorForDate();

  end;

implementation
uses System.SysUtils;

{ TPastValidatorTest }

procedure TPastValidatorTest.SetupFixture;
begin

  FValidator := TDValidation.GetInstance.BuildValidator;

end;

procedure TPastValidatorTest.TearDownFixture;
begin

  if Assigned(FValidator) then
    FValidator.Free;

end;


procedure TPastValidatorTest.TestPastValidatorForDate;
var
  Value : TDate;
  ConstraintValidator : TPastValidatorForDate;
begin

  ConstraintValidator := TPastValidatorForDate.Create;

  try

    Assert.IsTrue(ConstraintValidator.IsValid(Date - 1));

  finally
    ConstraintValidator.Free;
  end;

end;

initialization
  TDUnitX.RegisterTestFixture(TPastValidatorTest);
end.

