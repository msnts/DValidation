unit DValidation.Constraints.NotBlankTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.NotBlank;

type
  [TestFixture]
  TNotBlankAttributeTest = class(TObject)
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

{ TNotBlankAttributeTest }

procedure TNotBlankAttributeTest.TestCreate1;
var
  Attrib: NotBlankAttribute;
begin
  Attrib := NotBlankAttribute.Create;

  try
    Assert.AreEqual(NotBlankAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotBlankAttributeTest.TestCreate2;
var
  Attrib: NotBlankAttribute;
begin
  Attrib := NotBlankAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotBlankAttributeTest.TestCreate3;
var
  Attrib: NotBlankAttribute;
begin
  Attrib := NotBlankAttribute.Create([1]);

  try
    Assert.AreEqual(NotBlankAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotBlankAttributeTest.TestCreate4;
var
  Attrib: NotBlankAttribute;
begin
  Attrib := NotBlankAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

