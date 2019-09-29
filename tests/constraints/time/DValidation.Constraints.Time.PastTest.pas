unit DValidation.Constraints.Time.PastTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Time.Past;

type
  [TestFixture]
  TPastAttributeTest = class(TObject)
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

{ TPastAttributeTest }

procedure TPastAttributeTest.TestCreate1;
var
  Attrib: PastAttribute;
begin
  Attrib := PastAttribute.Create;

  try
    Assert.AreEqual(PastAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPastAttributeTest.TestCreate2;
var
  Attrib: PastAttribute;
begin
  Attrib := PastAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPastAttributeTest.TestCreate3;
var
  Attrib: PastAttribute;
begin
  Attrib := PastAttribute.Create([1]);

  try
    Assert.AreEqual(PastAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPastAttributeTest.TestCreate4;
var
  Attrib: PastAttribute;
begin
  Attrib := PastAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

