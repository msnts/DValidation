unit DValidation.Constraints.DigitsTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Digits;

type
  [TestFixture]
  TDigitsAttributeTest = class(TObject)
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

{ TDigitsAttributeTest }

procedure TDigitsAttributeTest.TestCreate1;
var
  Attrib: DigitsAttribute;
begin
  Attrib := DigitsAttribute.Create(3, 2);

  try
    Assert.AreEqual(3, Attrib.Integer, 0, 'Property: "Integer"');
    Assert.AreEqual(2, Attrib.Fraction, 0, 'Property: "Fraction"');
    Assert.AreEqual(DigitsAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TDigitsAttributeTest.TestCreate2;
var
  Attrib: DigitsAttribute;
begin
  Attrib := DigitsAttribute.Create(3, 2, 'abc');

  try
    Assert.AreEqual(3, Attrib.Integer, 0, 'Property: "Integer"');
    Assert.AreEqual(2, Attrib.Fraction, 0, 'Property: "Fraction"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TDigitsAttributeTest.TestCreate3;
var
  Attrib: DigitsAttribute;
begin
  Attrib := DigitsAttribute.Create(3, 2, [1]);

  try
    Assert.AreEqual(3, Attrib.Integer, 0, 'Property: "Integer"');
    Assert.AreEqual(2, Attrib.Fraction, 0, 'Property: "Fraction"');
    Assert.AreEqual(DigitsAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TDigitsAttributeTest.TestCreate4;
var
  Attrib: DigitsAttribute;
begin
  Attrib := DigitsAttribute.Create(3, 2, 'abc', [1]);

  try
    Assert.AreEqual(3, Attrib.Integer, 0, 'Property: "Integer"');
    Assert.AreEqual(2, Attrib.Fraction, 0, 'Property: "Fraction"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

