unit DValidation.Constraints.Br.CPFTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Br.CPF;

type
  [TestFixture]
  TCPFAttributeTest = class(TObject)
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

{ TCPFAttributeTest }

procedure TCPFAttributeTest.TestCreate1;
var
  Attrib: CPFAttribute;
begin
  Attrib := CPFAttribute.Create;

  try
    Assert.AreEqual(CPFAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCPFAttributeTest.TestCreate2;
var
  Attrib: CPFAttribute;
begin
  Attrib := CPFAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCPFAttributeTest.TestCreate3;
var
  Attrib: CPFAttribute;
begin
  Attrib := CPFAttribute.Create([1]);

  try
    Assert.AreEqual(CPFAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCPFAttributeTest.TestCreate4;
var
  Attrib: CPFAttribute;
begin
  Attrib := CPFAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.
