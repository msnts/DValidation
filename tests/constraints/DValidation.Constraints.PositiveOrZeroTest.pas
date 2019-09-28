unit DValidation.Constraints.PositiveOrZeroTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.PositiveOrZero;

type
  [TestFixture]
  TPositiveOrZeroAttributeTest = class(TObject)
  public
    [Test]
    procedure TestCreate1;

    [Test]
    procedure TestCreate2;

    [Test]
    procedure TestCreate3;

    [Test]
    procedure TestCreate4;
  end;

implementation

{ TPositiveOrZeroAttributeTest }

procedure TPositiveOrZeroAttributeTest.TestCreate1;
var
  Attrib: PositiveOrZeroAttribute;
begin
  Attrib := PositiveOrZeroAttribute.Create;

  try
    Assert.AreEqual(PositiveOrZeroAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPositiveOrZeroAttributeTest.TestCreate2;
var
  Attrib: PositiveOrZeroAttribute;
begin
  Attrib := PositiveOrZeroAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPositiveOrZeroAttributeTest.TestCreate3;
var
  Attrib: PositiveOrZeroAttribute;
begin
  Attrib := PositiveOrZeroAttribute.Create([1]);

  try
    Assert.AreEqual(PositiveOrZeroAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPositiveOrZeroAttributeTest.TestCreate4;
var
  Attrib: PositiveOrZeroAttribute;
begin
  Attrib := PositiveOrZeroAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

