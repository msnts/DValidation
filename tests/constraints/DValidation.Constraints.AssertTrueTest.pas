unit DValidation.Constraints.AssertTrueTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.AssertTrue;

type
  [TestFixture]
  TAssertTrueAttributeTest = class(TObject)
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

{ TAssertTrueAttributeTest }

procedure TAssertTrueAttributeTest.TestCreate1;
var
  Attrib: AssertTrueAttribute;
begin
  Attrib := AssertTrueAttribute.Create;

  try
    Assert.AreEqual(AssertTrueAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TAssertTrueAttributeTest.TestCreate2;
var
  Attrib: AssertTrueAttribute;
begin
  Attrib := AssertTrueAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TAssertTrueAttributeTest.TestCreate3;
var
  Attrib: AssertTrueAttribute;
begin
  Attrib := AssertTrueAttribute.Create([1]);

  try
    Assert.AreEqual(AssertTrueAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TAssertTrueAttributeTest.TestCreate4;
var
  Attrib: AssertTrueAttribute;
begin
  Attrib := AssertTrueAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

