unit DValidation.Constraints.Br.TituloEleitorTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.Br.TituloEleitor;

type
  [TestFixture]
  TTituloEleitorAttributeTest = class(TObject)
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

{ TTituloEleitorAttributeTest }

procedure TTituloEleitorAttributeTest.TestCreate1;
var
  Attrib: TituloEleitorAttribute;
begin
  Attrib := TituloEleitorAttribute.Create;

  try
    Assert.AreEqual(TituloEleitorAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TTituloEleitorAttributeTest.TestCreate2;
var
  Attrib: TituloEleitorAttribute;
begin
  Attrib := TituloEleitorAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TTituloEleitorAttributeTest.TestCreate3;
var
  Attrib: TituloEleitorAttribute;
begin
  Attrib := TituloEleitorAttribute.Create([1]);

  try
    Assert.AreEqual(TituloEleitorAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TTituloEleitorAttributeTest.TestCreate4;
var
  Attrib: TituloEleitorAttribute;
begin
  Attrib := TituloEleitorAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.
