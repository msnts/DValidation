unit DValidation.Engine.Impl.MessageInterpolator;

interface
uses
  System.Generics.Collections,
  DValidation.Engine.MessageInterpolator;

type

  TMessageInterpolator = class(TInterfacedObject, IMessageInterpolator)
  private
    function CastValue(const Value : variant) : string;
  public
    function Interpolate(const MessageTemplante : string; Attributes : TDictionary<string, variant>) : string;
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
  else
    raise Exception.Create('Invalid data type for interpolation');
  end;

end;

function TMessageInterpolator.Interpolate(const MessageTemplante: string;
  Attributes: TDictionary<string, variant>): string;
var
  Attribute, Value : string;

begin

  Result := MessageTemplante;

  for Attribute in Attributes.Keys do
  begin

    Value := CastValue(Attributes.Items[Attribute]);

    Result := Result.Replace(':' + Attribute, Value);

  end;

end;

end.
