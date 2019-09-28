unit DValidation.Constraints.NegativeOrZeroTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.NegativeOrZero;

type
  [TestFixture]
  TNegativeOrZeroAttributeTest = class(TObject)
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

{ TNegativeOrZeroAttributeTest }

procedure TNegativeOrZeroAttributeTest.TestCreate1;
var
  Attrib: NegativeOrZeroAttribute;
begin
  Attrib := NegativeOrZeroAttribute.Create;

  try
    Assert.AreEqual(NegativeOrZeroAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNegativeOrZeroAttributeTest.TestCreate2;
var
  Attrib: NegativeOrZeroAttribute;
begin
  Attrib := NegativeOrZeroAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNegativeOrZeroAttributeTest.TestCreate3;
var
  Attrib: NegativeOrZeroAttribute;
begin
  Attrib := NegativeOrZeroAttribute.Create([1]);

  try
    Assert.AreEqual(NegativeOrZeroAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNegativeOrZeroAttributeTest.TestCreate4;
var
  Attrib: NegativeOrZeroAttribute;
begin
  Attrib := NegativeOrZeroAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

