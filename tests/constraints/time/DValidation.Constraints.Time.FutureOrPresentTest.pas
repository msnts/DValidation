unit DValidation.Constraints.Time.FutureOrPresentTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Time.FutureOrPresent;

type
  [TestFixture]
  TFutureOrPresentAttributeTest = class(TObject)
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

{ TFutureOrPresentAttributeTest }

procedure TFutureOrPresentAttributeTest.TestCreate1;
var
  Attrib: FutureOrPresentAttribute;
begin
  Attrib := FutureOrPresentAttribute.Create;

  try
    Assert.AreEqual(FutureOrPresentAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TFutureOrPresentAttributeTest.TestCreate2;
var
  Attrib: FutureOrPresentAttribute;
begin
  Attrib := FutureOrPresentAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TFutureOrPresentAttributeTest.TestCreate3;
var
  Attrib: FutureOrPresentAttribute;
begin
  Attrib := FutureOrPresentAttribute.Create([1]);

  try
    Assert.AreEqual(FutureOrPresentAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TFutureOrPresentAttributeTest.TestCreate4;
var
  Attrib: FutureOrPresentAttribute;
begin
  Attrib := FutureOrPresentAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

