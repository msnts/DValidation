unit ValidationTest;

interface
uses
  System.Generics.Collections,
  DUnitX.TestFramework,
  DValidation,
  DValidation.Engine.Impl.Validator,
  DValidation.Engine.ConstraintViolation,
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
  List: TList<IConstraintViolation<TCustomer>>;
begin

  Validator := TDValidation.GetInstance.BuildValidator;

  Customer := TCustomer.Create;
  Customer.Valid := True;
  Customer.NotValid := False;

  try
    List := Validator.Validate<TCustomer>(Customer, [0]);

    Assert.AreEqual(0, List.Count);
  finally
    List.Free;
    Customer.Free;
    Validator.Free;
  end;

end;

initialization
  TDUnitX.RegisterTestFixture(TValidationTest);
end.
