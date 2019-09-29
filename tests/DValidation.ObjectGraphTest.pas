unit DValidation.ObjectGraphTest;

interface
uses
  DUnitX.TestFramework,
  System.Generics.Collections,
  DValidation,
  DValidation.Engine.Impl.Validator,
  DValidation.Engine.ConstraintViolation,
  DValidation.ConstraintValidators.DecimalMinValidator,
  DValidation.Model.ObjectGraph;

type

  [TestFixture]
  TObjectGraphTest = class(TObject)
  private
    FValidator : TValidator;
    FCar : TCar;
  public
    [SetupFixture]
    procedure Setup;
    [TearDownFixture]
    procedure TearDown;

    [Test]
    procedure TestCascadedValidation;
  end;

implementation

procedure TObjectGraphTest.Setup;
begin

  FValidator := TDValidation.GetInstance.BuildValidator;

  FCar := TCar.Create(0, nil, nil, nil);
end;

procedure TObjectGraphTest.TearDown;
begin

  FValidator.Free;

  FCar.Free;

end;


procedure TObjectGraphTest.TestCascadedValidation;
var
  Faults : TList<IConstraintViolation<TCar>>;
begin

  Faults := FValidator.Validate(FCar);

end;

initialization
  TDUnitX.RegisterTestFixture(TObjectGraphTest);
end.
