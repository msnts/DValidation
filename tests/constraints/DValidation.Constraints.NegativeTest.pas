unit DValidation.Constraints.NegativeTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Negative;

type
  [TestFixture]
  TNegativeAttributeTest = class(TObject)
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

{ TNegativeAttributeTest }

procedure TNegativeAttributeTest.TestCreate1;
var
  Attrib: NegativeAttribute;
begin
  Attrib := NegativeAttribute.Create;

  try
    Assert.AreEqual(NegativeAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNegativeAttributeTest.TestCreate2;
var
  Attrib: NegativeAttribute;
begin
  Attrib := NegativeAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNegativeAttributeTest.TestCreate3;
var
  Attrib: NegativeAttribute;
begin
  Attrib := NegativeAttribute.Create([1]);

  try
    Assert.AreEqual(NegativeAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNegativeAttributeTest.TestCreate4;
var
  Attrib: NegativeAttribute;
begin
  Attrib := NegativeAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

