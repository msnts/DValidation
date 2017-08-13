{ ******************************************************************************
  Copyright 2017 Marcos Santos

  Contact: marcos.santos@outlook.com

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  *****************************************************************************}

unit DValidation.Constraints.Constraint;

interface
uses System.JSON, System.SysUtils, System.Generics.Collections, DValidation.Exceptions;

type

   ConstraintAttribute = class(TCustomAttribute)
   protected
      FJSONObject : TJSONObject;
      FMessage : string;
      FGroups : TArray<string>;
      FAttributes : TDictionary<string, variant>;

      procedure Initialize(const Parameters : string);
      function GetParameter<T>(const ParameterName : string; Default : T) : T;
   public
      constructor Create(const Parameters : string = ''); virtual;
      destructor Destroy; override;
      property &Message : string read FMessage;
      property Groups : TArray<string> read FGroups;
      property Attributes : TDictionary<string, variant> read FAttributes;
   end;

implementation

{ TConstraintAttribute }

constructor ConstraintAttribute.Create(const Parameters: string = '');
begin

  FJSONObject := TJSONObject.Create;

  Initialize(Parameters);

  FAttributes := TDictionary<string, variant>.Create;

  FAttributes.AddOrSetValue('Message', FMessage);
  FAttributes.AddOrSetValue('Groups', FGroups);

end;

destructor ConstraintAttribute.Destroy;
begin

  if Assigned(FJSONObject) then
    FJSONObject.Free;

  if Assigned(FAttributes) then
    FAttributes.Free;

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
    raise ConstraintException.Create('Invalid parameter "' + ParameterName + '"');

end;

procedure ConstraintAttribute.Initialize(const Parameters: string);
const
  DEFAULT_GROUP = 'DEFAULT';
begin

  if Parameters.IsEmpty then
  begin
    FMessage := '';
    FGroups := [DEFAULT_GROUP];
    Exit;
  end;

  try

    if FJSONObject.Parse(BytesOf(Parameters), 0) < 0 then
      raise ConstraintException.Create('Invalid Format Constraint Parameters');

    FMessage := GetParameter<string>('Message', FMessage);

    FGroups := GetParameter<TArray<string>>('Groups', [DEFAULT_GROUP]);

  except
    FJSONObject.Free;
    raise;
  end;

end;

end.
