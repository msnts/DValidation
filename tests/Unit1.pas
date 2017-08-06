unit Unit1;

interface

uses
  DUnitX.TestFramework,
  Rtti,
  Customer,
  DValidation.Constraints.Constraint;

type

  [TestFixture]
  TConstraintsTest = class(TObject)
  public
    [Test]
    procedure ConstraintCreateTest;
  end;

implementation

{ TConstraintsTest }

procedure TConstraintsTest.ConstraintCreateTest;
var
  Elem: TCustomer;
  ctx: TRttiContext;
  objType: TRttiType;
  Field : TRttiField;
  Attribute : TCustomAttribute;
  Contraint : ConstraintAttribute;
begin

  Elem := TCustomer.Create;

  try

    ctx := TRttiContext.Create;

    objType := ctx.GetType(Elem.ClassInfo);

    Field := objType.GetField('Email');

    for Attribute in Field.GetAttributes do
    begin

      Contraint := Attribute as ConstraintAttribute;

    end;

  finally
    Elem.Free;
  end;

end;

initialization

TDUnitX.RegisterTestFixture(TConstraintsTest);

end.
