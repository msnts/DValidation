unit DValidation.Constraints.Time.FutureTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Time.Future;

type
  [TestFixture]
  TFutureAttributeTest = class(TObject)
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

{ TFutureAttributeTest }

procedure TFutureAttributeTest.TestCreate1;
var
  Attrib: FutureAttribute;
begin
  Attrib := FutureAttribute.Create;

  try
    Assert.AreEqual(FutureAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TFutureAttributeTest.TestCreate2;
var
  Attrib: FutureAttribute;
begin
  Attrib := FutureAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TFutureAttributeTest.TestCreate3;
var
  Attrib: FutureAttribute;
begin
  Attrib := FutureAttribute.Create([1]);

  try
    Assert.AreEqual(FutureAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TFutureAttributeTest.TestCreate4;
var
  Attrib: FutureAttribute;
begin
  Attrib := FutureAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

