unit DValidation.Constraints.MaxTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Max;

type
  [TestFixture]
  TMaxAttributeTest = class(TObject)
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

{ TMaxAttributeTest }

procedure TMaxAttributeTest.TestCreate1;
var
  Attrib: MaxAttribute;
begin
  Attrib := MaxAttribute.Create(1);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsTrue(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual(MaxAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMaxAttributeTest.TestCreate2;
var
  Attrib: MaxAttribute;
begin
  Attrib := MaxAttribute.Create(1, False);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsFalse(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual(MaxAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMaxAttributeTest.TestCreate3;
var
  Attrib: MaxAttribute;
begin
  Attrib := MaxAttribute.Create(1, 'abc');

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsTrue(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMaxAttributeTest.TestCreate4;
var
  Attrib: MaxAttribute;
begin
  Attrib := MaxAttribute.Create(1, [1]);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsTrue(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual(MaxAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMaxAttributeTest.TestCreate5;
var
  Attrib: MaxAttribute;
begin
  Attrib := MaxAttribute.Create(1, False, 'abc');

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsFalse(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMaxAttributeTest.TestCreate6;
var
  Attrib: MaxAttribute;
begin
  Attrib := MaxAttribute.Create(1, False, [1]);

  try
    Assert.AreEqual(1, Attrib.Value, 0, 'Property: "Value"');
    Assert.IsFalse(Attrib.Inclusive, 'Property: "Inclusive"');
    Assert.AreEqual(MaxAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TMaxAttributeTest.TestCreate7;
var
  Attrib: MaxAttribute;
begin
  Attrib := MaxAttribute.Create(1, False, 'abc', [1]);

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

