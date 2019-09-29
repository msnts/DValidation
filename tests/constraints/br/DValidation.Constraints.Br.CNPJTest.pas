unit DValidation.Constraints.Br.CNPJTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Br.CNPJ;

type
  [TestFixture]
  TCNPJAttributeTest = class(TObject)
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

{ TCNPJAttributeTest }

procedure TCNPJAttributeTest.TestCreate1;
var
  Attrib: CNPJAttribute;
begin
  Attrib := CNPJAttribute.Create;

  try
    Assert.AreEqual(CNPJAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCNPJAttributeTest.TestCreate2;
var
  Attrib: CNPJAttribute;
begin
  Attrib := CNPJAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCNPJAttributeTest.TestCreate3;
var
  Attrib: CNPJAttribute;
begin
  Attrib := CNPJAttribute.Create([1]);

  try
    Assert.AreEqual(CNPJAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TCNPJAttributeTest.TestCreate4;
var
  Attrib: CNPJAttribute;
begin
  Attrib := CNPJAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.
