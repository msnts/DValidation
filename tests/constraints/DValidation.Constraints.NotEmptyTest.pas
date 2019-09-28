unit DValidation.Constraints.NotEmptyTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.NotEmpty;

type
  [TestFixture]
  TNotEmptyAttributeTest = class(TObject)
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

{ TNotEmptyAttributeTest }

procedure TNotEmptyAttributeTest.TestCreate1;
var
  Attrib: NotEmptyAttribute;
begin
  Attrib := NotEmptyAttribute.Create;

  try
    Assert.AreEqual(NotEmptyAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotEmptyAttributeTest.TestCreate2;
var
  Attrib: NotEmptyAttribute;
begin
  Attrib := NotEmptyAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotEmptyAttributeTest.TestCreate3;
var
  Attrib: NotEmptyAttribute;
begin
  Attrib := NotEmptyAttribute.Create([1]);

  try
    Assert.AreEqual(NotEmptyAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TNotEmptyAttributeTest.TestCreate4;
var
  Attrib: NotEmptyAttribute;
begin
  Attrib := NotEmptyAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

