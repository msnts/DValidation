unit DValidation.Constraints.NotNullTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.NotNull;

type
  [TestFixture]
  TNotNullAttributeTest = class(TObject)
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

{ TNotNullAttributeTest }

procedure TNotNullAttributeTest.TestCreate1;
var
  Attrib: NotNullAttribute;
begin
  Attrib := NotNullAttribute.Create;

  try
    Assert.AreEqual(NotNullAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotNullAttributeTest.TestCreate2;
var
  Attrib: NotNullAttribute;
begin
  Attrib := NotNullAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotNullAttributeTest.TestCreate3;
var
  Attrib: NotNullAttribute;
begin
  Attrib := NotNullAttribute.Create([1]);

  try
    Assert.AreEqual(NotNullAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotNullAttributeTest.TestCreate4;
var
  Attrib: NotNullAttribute;
begin
  Attrib := NotNullAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

