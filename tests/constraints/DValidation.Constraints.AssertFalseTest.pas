unit DValidation.Constraints.AssertFalseTest;

interface
uses
  DUnitX.TestFramework,

  DValidation.Constraints.Constraint,
  DValidation.Constraints.AssertFalse;

type
  [TestFixture]
  TAssertFalseAttributeTest = class(TObject)
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

{ TAssertFalseAttributeTest }

procedure TAssertFalseAttributeTest.TestCreate1;
var
  Attrib: AssertFalseAttribute;
begin
  Attrib := AssertFalseAttribute.Create;

  try
    Assert.AreEqual(AssertFalseAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TAssertFalseAttributeTest.TestCreate2;
var
  Attrib: AssertFalseAttribute;
begin
  Attrib := AssertFalseAttribute.Create('abc');

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([DEFAULT_GROUP] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TAssertFalseAttributeTest.TestCreate3;
var
  Attrib: AssertFalseAttribute;
begin
  Attrib := AssertFalseAttribute.Create([1]);

  try
    Assert.AreEqual(AssertFalseAttribute.DEFAULT_MESSAGE, Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

procedure TAssertFalseAttributeTest.TestCreate4;
var
  Attrib: AssertFalseAttribute;
begin
  Attrib := AssertFalseAttribute.Create('abc', [1]);

  try
    Assert.AreEqual('abc', Attrib.Message, 'Property: "Message"');
    Assert.IsTrue([1] = Attrib.Groups, 'Property: "Groups"');
  finally
    Attrib.Free;
  end;
end;

end.
