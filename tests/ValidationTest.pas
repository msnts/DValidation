unit ValidationTest;

interface
uses
  DUnitX.TestFramework,
  DValidation,
  DValidation.Engine.Impl.Validator,
  Customer;

type

  [TestFixture]
  TValidationTest = class(TObject)
  public
    [Test]
    procedure ValidatorTest();
  end;

implementation


{ TValidationTest }

procedure TValidationTest.ValidatorTest;
var
  Validator : TValidator;
  Customer : TCustomer;
begin

  Validator := TDValidation.GetInstance.BuildValidator;

  Customer := TCustomer.Create;
  Customer.Valid := True;
  Customer.NotValid := False;

  try
    Validator.Validate<TCustomer>(Customer, ['DEFAULT']);
  finally
    Validator.Free;
     Customer.Free;
  end;

end;

initialization
  TDUnitX.RegisterTestFixture(TValidationTest);
end.
