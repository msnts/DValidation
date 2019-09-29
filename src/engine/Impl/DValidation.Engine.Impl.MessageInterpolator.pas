unit DValidation.Engine.Impl.MessageInterpolator;

interface
uses
  System.Rtti,
  System.TypInfo,
  System.SysUtils,
  System.Generics.Collections,
  System.RegularExpressions,
  DValidation.Engine.MessageInterpolator,
  DValidation.I18n.Locale;

type

  TMessageInterpolator = class(TInterfacedObject, IMessageInterpolator)
  private
    FLocale : ILocale;

    function CastValue(const Value : TValue) : string;
    function MessageResolve(const MessageTemplate : string) : string;
  public
    constructor Create(Locale : ILocale);
    function Interpolate(const MessageTemplate : string; Attributes : TDictionary<string, TValue>) : string;
  end;

implementation

{ TMessageInterpolator }

function TMessageInterpolator.CastValue(const Value: TValue): string;
begin
  case Value.Kind of
    tkInteger, tkInt64: Result := Integer.ToString(Value.AsInt64);
    tkChar, tkString, tkWChar, tkLString, tkWString, tkUString: Result := Value.AsString;
    tkEnumeration:
    begin
      if Value.IsType<Boolean> then
        Exit(Boolean.ToString(Value.AsBoolean, TUseBoolStrs.True));
      Result := GetEnumName(Value.TypeInfo, Value.AsOrdinal);
    end;
    tkFloat:
    begin
      if 'TTime'.Equals(Value.TypeInfo.Name)  then
        Exit(FormatDateTime('tt', Value.AsType<TTime>()));
      if 'TDate'.Equals(Value.TypeInfo.Name) then
        Exit(FormatDateTime('ddddd', Value.AsType<TDate>()));
      if 'TDateTime'.Equals(Value.TypeInfo.Name) then
        Exit(FormatDateTime('c', Value.AsType<TDateTime>()));
      Result := Double.ToString(Value.AsExtended);
    end;
  else
    raise Exception.Create('Invalid data type for interpolation');
  end;
end;

constructor TMessageInterpolator.Create(Locale: ILocale);
begin
  FLocale := Locale;
end;

function TMessageInterpolator.Interpolate(const MessageTemplate: string; Attributes: TDictionary<string, TValue>): string;
var
  Attribute, Value: string;
  AttributeValue: TValue;
begin

  Result := MessageResolve(MessageTemplate);

  for Attribute in Attributes.Keys do
  begin

    AttributeValue := Attributes.Items[Attribute];

    if AttributeValue.IsArray then
      Continue;

    Value := CastValue(AttributeValue);

    Result := TRegEx.Replace(Result, '\{' + Attribute + '\}', Value, [roIgnoreCase]);

  end;

end;

function TMessageInterpolator.MessageResolve(const MessageTemplate : string): string;
const
  MESSAGE_REGEX = '^\{(([\d\w])+(\.[\d\w]+)*)\}$';
var
  RegEx : TRegEx;
  Match : TMatch;
  Group : TGroup;
begin

  RegEx := TRegex.Create(MESSAGE_REGEX);

  Match := RegEx.Match(MessageTemplate);

  if not Match.Success then
  begin
    Result := MessageTemplate;
    Exit;
  end;

  Group := Match.Groups.Item[1];

  Result := FLocale.GetViolationMessage(Group.Value);

end;

end.
