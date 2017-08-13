unit DValidation.Engine.Impl.MessageInterpolator;

interface
uses
  System.Generics.Collections,
  System.RegularExpressions,
  DValidation.Engine.MessageInterpolator,
  DValidation.I18n.Locale;

type

  TMessageInterpolator = class(TInterfacedObject, IMessageInterpolator)
  private
    FLocale : ILocale;

    function CastValue(const Value : variant) : string;
    function MessageResolve(const MessageTemplate : string) : string;
  public
    constructor Create(Locale : ILocale);
    function Interpolate(const MessageTemplate : string; Attributes : TDictionary<string, variant>) : string;
  end;

implementation
uses System.SysUtils, Variants;

{ TMessageInterpolator }

function TMessageInterpolator.CastValue(const Value: variant): string;
var
  BasicType : Integer;
begin

  BasicType := VarType(Value) and VarTypeMask;

  case BasicType of
    varSmallInt, varInteger, varByte, varInt64 : Result := Integer.ToString(Value);
    varSingle    : Result := VarToStr(Value);
    varDouble, varCurrency  : Result := double.ToString(Value);
    varDate      : Result := VarToStr(VarToDateTime(Value));
    varOleStr    : Result := VarToStr(Value);
    varBoolean   : Result := VarToStr(Value);
    varWord      : Result := VarToStr(Value);
    varLongWord  : Result := VarToStr(Value);
    varStrArg    : Result := VarToStr(Value);
    varString    : Result := VarToStr(Value);
    varUString   : Result := VarToStr(Value);
  else
    raise Exception.Create('Invalid data type for interpolation');
  end;

end;

constructor TMessageInterpolator.Create(Locale: ILocale);
begin
  FLocale := Locale;
end;

function TMessageInterpolator.Interpolate(const MessageTemplate: string;
  Attributes: TDictionary<string, variant>): string;
var
  Attribute, Value : string;
  AttributeValue : variant;
begin

  Result := MessageResolve(MessageTemplate);

  for Attribute in Attributes.Keys do
  begin

    AttributeValue := Attributes.Items[Attribute];

    if VarIsArray(AttributeValue) then
      continue;

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
