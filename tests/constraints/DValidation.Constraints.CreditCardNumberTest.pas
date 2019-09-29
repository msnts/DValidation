unit DValidation.Constraints.CreditCardNumberTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.CreditCardNumber;

type
  [TestFixture]
  TCreditCardNumberAttributeTest = class(TObject)
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

    [Test]
    procedure TestCreate8;
  end;

implementation

{ TCreditCardNumberAttributeTest }

procedure TCreditCardNumberAttributeTest.TestCreate1;
var
  Attrib: CreditCardNumberAttribute;
begin
  Attrib := CreditCardNumberAttribute.Create();

  try
    Assert.IsFalse(Attrib.IgnoreNonDigitCharacters, 'Property: "IgnoreNonDigitCharacters"');
    Assert.AreEqual(CreditCardNumberAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCreditCardNumberAttributeTest.TestCreate2;
var
  Attrib: CreditCardNumberAttribute;
begin
  Attrib := CreditCardNumberAttribute.Create(True);

  try
    Assert.IsTrue(Attrib.IgnoreNonDigitCharacters, 'Property: "IgnoreNonDigitCharacters"');
    Assert.AreEqual(CreditCardNumberAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCreditCardNumberAttributeTest.TestCreate3;
var
  Attrib: CreditCardNumberAttribute;
begin
  Attrib := CreditCardNumberAttribute.Create(True, 'abc');

  try
    Assert.IsTrue(Attrib.IgnoreNonDigitCharacters, 'Property: "IgnoreNonDigitCharacters"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCreditCardNumberAttributeTest.TestCreate4;
var
  Attrib: CreditCardNumberAttribute;
begin
  Attrib := CreditCardNumberAttribute.Create(True, [1]);

  try
    Assert.IsTrue(Attrib.IgnoreNonDigitCharacters, 'Property: "IgnoreNonDigitCharacters"');
    Assert.AreEqual(CreditCardNumberAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCreditCardNumberAttributeTest.TestCreate5;
var
  Attrib: CreditCardNumberAttribute;
begin
  Attrib := CreditCardNumberAttribute.Create(True, 'abc', [1]);

  try
    Assert.IsTrue(Attrib.IgnoreNonDigitCharacters, 'Property: "IgnoreNonDigitCharacters"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCreditCardNumberAttributeTest.TestCreate6;
var
  Attrib: CreditCardNumberAttribute;
begin
  Attrib := CreditCardNumberAttribute.Create('abc', [1]);

  try
    Assert.IsFalse(Attrib.IgnoreNonDigitCharacters, 'Property: "IgnoreNonDigitCharacters"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCreditCardNumberAttributeTest.TestCreate7;
var
  Attrib: CreditCardNumberAttribute;
begin
  Attrib := CreditCardNumberAttribute.Create('abc');

  try
    Assert.IsFalse(Attrib.IgnoreNonDigitCharacters, 'Property: "IgnoreNonDigitCharacters"');
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCreditCardNumberAttributeTest.TestCreate8;
var
  Attrib: CreditCardNumberAttribute;
begin
  Attrib := CreditCardNumberAttribute.Create([1]);

  try
    Assert.IsFalse(Attrib.IgnoreNonDigitCharacters, 'Property: "IgnoreNonDigitCharacters"');
    Assert.AreEqual(CreditCardNumberAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.

