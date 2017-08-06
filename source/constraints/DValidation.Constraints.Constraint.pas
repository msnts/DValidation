unit DValidation.Constraints.Constraint;

interface
uses System.JSON, System.SysUtils;

type

   ConstraintAttribute = class(TCustomAttribute)
   protected
      FJSONObject : TJSONObject;
      FMessage : string;
      FGroups : TArray<string>;

      function GetParameter<T>(const ParameterName : string; Default : T) : T;
   public
      constructor Create(const Parameters : string); virtual;
      destructor Destroy; override;
      property &Message : string read FMessage;
      property Groups : TArray<string> read FGroups;
   end;



implementation


{ TConstraintAttribute }

constructor ConstraintAttribute.Create(const Parameters: string);

begin

   FJSONObject := TJSONObject.Create;

   FJSONObject.Parse(BytesOf(Parameters), 0);

   FMessage := GetParameter<string>('Message', FMessage);

   FGroups := GetParameter<TArray<string>>('Groups', ['DEFAULT']);

end;

destructor ConstraintAttribute.Destroy;
begin

  if Assigned(FJSONObject) then
    FJSONObject.Free;

  inherited;
end;

function ConstraintAttribute.GetParameter<T>(const ParameterName: string; Default : T): T;
var
  Parameter : TJSONValue;
  Arr : TJSONArray;
begin

  Parameter := FJSONObject.GetValue(ParameterName);

  if Parameter = nil then
  begin
    Result := Default;
    Exit;
  end;

  if not Parameter.TryGetValue(Result) then
    raise Exception.Create('Invalid parameter "' + ParameterName + '"');

end;

end.
