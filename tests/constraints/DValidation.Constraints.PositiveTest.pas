unit DValidation.Constraints.PositiveTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Positive;

type
  [TestFixture]
  TPositiveAttributeTest = class(TObject)
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

{ TPositiveAttributeTest }

procedure TPositiveAttributeTest.TestCreate1;
var
  Attrib: PositiveAttribute;
begin
  Attrib := PositiveAttribute.Create;

  try
    Assert.AreEqual(PositiveAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPositiveAttributeTest.TestCreate2;
var
  Attrib: PositiveAttribute;
begin
  Attrib := PositiveAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPositiveAttributeTest.TestCreate3;
var
  Attrib: PositiveAttribute;
begin
  Attrib := PositiveAttribute.Create([1]);

  try
    Assert.AreEqual(PositiveAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPositiveAttributeTest.TestCreate4;
var
  Attrib: PositiveAttribute;
begin
  Attrib := PositiveAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

