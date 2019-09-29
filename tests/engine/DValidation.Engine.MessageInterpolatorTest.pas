unit DValidation.Engine.MessageInterpolatorTest;

interface
uses
  System.Rtti,
  DUnitX.TestFramework,
  System.Generics.Collections,
  DValidation.Engine.MessageInterpolator,
  DValidation.Engine.Impl.MessageInterpolator,
  DValidation.I18n.Impl.Locale;

type

  [TestFixture]
  TMessageInterpolatorTest = class(TObject)
  private
    FInterpolator : IMessageInterpolator;
    FAttributes : TDictionary<string, TValue>;
  public

    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    [Test]
    procedure InterpolateIntegersTest();

    [Test]
    procedure InterpolateDoublesTest();

    [Test]
    procedure InterpolateBooleanTest();

    [Test]
    procedure InterpolateDateTest();

    [Test]
    procedure InterpolateDatetimeTest();

    [Test]
    procedure InterpolateTimeTest();

    [Test]
    procedure InterpolateMessageTest();

  end;

implementation
uses System.SysUtils;


{ TMessageInterpolatorTest }

procedure TMessageInterpolatorTest.InterpolateBooleanTest;
var
  InterpolatedMessage : string;
begin

  FAttributes.Clear;

  FAttributes.Add('value', TValue.From<Boolean>(true));

  InterpolatedMessage := FInterpolator.Interpolate('{value} is an boolean value', FAttributes);

  Assert.AreEqual('true is an boolean value', InterpolatedMessage);

end;

procedure TMessageInterpolatorTest.InterpolateDateTest;
var
  InterpolatedMessage, Expected : string;
begin

  FAttributes.Clear;

  FAttributes.Add('value', TValue.From<TDate>(Date));

  InterpolatedMessage := FInterpolator.Interpolate('{value} is an date value', FAttributes);

  Expected := DateToStr(Date) + ' is an date value';

  Assert.AreEqual(Expected, InterpolatedMessage);

end;

procedure TMessageInterpolatorTest.InterpolateDatetimeTest;
var
  InterpolatedMessage, Expected : string;
  CurrentDateTime : TDateTime;
begin

  FAttributes.Clear;

  CurrentDateTime := Now;

  FAttributes.Add('value', TValue.From<TDateTime>(CurrentDateTime));

  InterpolatedMessage := FInterpolator.Interpolate('{value} is an datetime value', FAttributes);

  Expected := DateTimeToStr(CurrentDateTime) + ' is an datetime value';

  Assert.AreEqual(Expected, InterpolatedMessage);

end;

procedure TMessageInterpolatorTest.InterpolateDoublesTest;
var
  InterpolatedMessage : string;
begin

  FAttributes.Clear;

  FAttributes.Add('value', 1.1);

  InterpolatedMessage := FInterpolator.Interpolate('{value} is an double value', FAttributes);

  Assert.AreEqual('1,1 is an double value', InterpolatedMessage);

end;

procedure TMessageInterpolatorTest.InterpolateIntegersTest;
var
  InterpolatedMessage : string;
begin

  FAttributes.Clear;

  FAttributes.Add('value', 1);

  InterpolatedMessage := FInterpolator.Interpolate('{value} is an integer value', FAttributes);

  Assert.AreEqual('1 is an integer value', InterpolatedMessage);

end;

procedure TMessageInterpolatorTest.InterpolateMessageTest;
var
  InterpolatedMessage : string;
begin

  FAttributes.Clear;

  FAttributes.Add('min', 1);

  FAttributes.Add('Max', 10);

  InterpolatedMessage := FInterpolator.Interpolate('{validation.constraints.Size.message}', FAttributes);

  Assert.AreEqual('size must be between 1 and 10', InterpolatedMessage);

end;

procedure TMessageInterpolatorTest.InterpolateTimeTest;
var
  InterpolatedMessage, Expected : string;
  CurrentTime : TTime;
begin

  FAttributes.Clear;

  CurrentTime := Time;

  FAttributes.Add('value', TValue.From<TTime>(CurrentTime));

  InterpolatedMessage := FInterpolator.Interpolate('{value} is an time value', FAttributes);

  Expected := TimeToStr(CurrentTime) + ' is an time value';

  Assert.AreEqual(Expected, InterpolatedMessage);

end;

procedure TMessageInterpolatorTest.SetupFixture;
begin
  FInterpolator := TMessageInterpolator.Create(TLocale.Create);
  FAttributes := TDictionary<string, TValue>.Create;
end;

procedure TMessageInterpolatorTest.TearDownFixture;
begin
  FAttributes.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TMessageInterpolatorTest);
end.
