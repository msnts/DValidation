unit DValidation.Constraints.PastOrPresentTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Time.PastOrPresent;

type
  [TestFixture]
  TPastOrPresentAttributeTest = class(TObject)
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

{ TPastOrPresentAttributeTest }

procedure TPastOrPresentAttributeTest.TestCreate1;
var
  Attrib: PastOrPresentAttribute;
begin
  Attrib := PastOrPresentAttribute.Create;

  try
    Assert.AreEqual(PastOrPresentAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPastOrPresentAttributeTest.TestCreate2;
var
  Attrib: PastOrPresentAttribute;
begin
  Attrib := PastOrPresentAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPastOrPresentAttributeTest.TestCreate3;
var
  Attrib: PastOrPresentAttribute;
begin
  Attrib := PastOrPresentAttribute.Create([1]);

  try
    Assert.AreEqual(PastOrPresentAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TPastOrPresentAttributeTest.TestCreate4;
var
  Attrib: PastOrPresentAttribute;
begin
  Attrib := PastOrPresentAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

