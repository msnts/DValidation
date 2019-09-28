unit DValidation.Constraints.MinTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Min;

type
  [TestFixture]
  TMinAttributeTest = class(TObject)
  public
    [Test]
    procedure TestCreate1;

    [Test]
    procedure TestCreate2;

    [Test]
    procedure TestCreate3;

    [Test]
    procedure TestCreate4;

    [Test]
    procedure TestCreate5;

    [Test]
    procedure TestCreate6;

    [Test]
    procedure TestCreate7;
  end;

implementation

{ TMinAttributeTest }

procedure TMinAttributeTest.TestCreate1;
var
  Attrib: MinAttribute;
begin
  Attrib := MinAttribute.Create(1);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsTrue(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual(MinAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMinAttributeTest.TestCreate2;
var
  Attrib: MinAttribute;
begin
  Attrib := MinAttribute.Create(1, False);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsFalse(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual(MinAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMinAttributeTest.TestCreate3;
var
  Attrib: MinAttribute;
begin
  Attrib := MinAttribute.Create(1, 'abc');

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsTrue(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMinAttributeTest.TestCreate4;
var
  Attrib: MinAttribute;
begin
  Attrib := MinAttribute.Create(1, [1]);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsTrue(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual(MinAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMinAttributeTest.TestCreate5;
var
  Attrib: MinAttribute;
begin
  Attrib := MinAttribute.Create(1, False, 'abc');

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsFalse(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMinAttributeTest.TestCreate6;
var
  Attrib: MinAttribute;
begin
  Attrib := MinAttribute.Create(1, False, [1]);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsFalse(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual(MinAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMinAttributeTest.TestCreate7;
var
  Attrib: MinAttribute;
begin
  Attrib := MinAttribute.Create(1, False, 'abc', [1]);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsFalse(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

