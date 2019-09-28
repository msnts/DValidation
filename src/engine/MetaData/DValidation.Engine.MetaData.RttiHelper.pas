unit DValidation.Engine.MetaData.RttiHelper;

interface
uses System.Rtti, System.SysUtils, System.TypInfo;

type

  TRttiTypeHelper = class helper for TRttiType
  private
    function ExtractGenericArguments(ATypeInfo: PTypeInfo): string;
  public
    function IsGenericType: Boolean;
    function GetGenericArguments: TArray<TRttiType>;
  end;

implementation

{ TRttiTypeHelper }

function TRttiTypeHelper.ExtractGenericArguments(ATypeInfo: PTypeInfo): string;
var
  I: Integer;
  Name : string;
begin

  Name := UTF8ToString(ATypeInfo.Name);

  I := Name.IndexOf('<');

  if I < 1 then
    Exit(EmptyStr);

  Result := Name.Substring(Succ(i), Length(Name) - Succ(i));

end;

function TRttiTypeHelper.GetGenericArguments: TArray<TRttiType>;
var
  I: Integer;
  Arguments: TArray<string>;
  Context: TRttiContext;
begin

  if not IsGenericType then
    Exit;

  if Length(Arguments) > 0 then
    SetLength(Result, Length(Arguments));

  for I := 0 to Pred(Length(Arguments)) do
    Result[I] := Context.FindType(Arguments[I]);

end;

function TRttiTypeHelper.IsGenericType: Boolean;
begin
  Result := UTF8ToString(Handle.Name).Contains('<');
end;

end.
