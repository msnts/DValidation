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

unit DValidation.Constraints.EAN;

interface
uses
  System.SysUtils,
  DValidation.Constraints.Constraint;

type

  TEAN = (EAN8, EAN13);

  EANAttribute = class(SimpleConstraintAttribute)
  const
    DEFAULT_MESSAGE = '{validation.constraints.EAN.message}';
  private
    FType: TEAN;
  protected
    function GetMessage: string; override;
  public
    constructor Create(const AType: TEAN); overload;
    constructor Create(const AType: TEAN; const AMessage: string); overload;
    constructor Create(const AType: TEAN; const AGroups: TGroupSet); overload;
    constructor Create(const AMessage: string; const AGroups: TGroupSet); overload;
    constructor Create(const AType: TEAN; const AMessage: string; const AGroups: TGroupSet); overload;
    property &Type: TEAN read FType;
  end;

implementation

{ EANAttribute }

constructor EANAttribute.Create(const AType: TEAN; const AMessage: string; const AGroups: TGroupSet);
begin
  FType := AType;
  FMessage := AMessage;
  FGroups := AGroups;
end;

constructor EANAttribute.Create(const AMessage: string; const AGroups: TGroupSet);
begin
  Create(TEAN.EAN13, AMessage, AGroups);
end;

constructor EANAttribute.Create(const AType: TEAN);
begin
  Create(AType, EmptyStr, [DEFAULT_GROUP]);
end;

constructor EANAttribute.Create(const AType: TEAN; const AMessage: string);
begin
  Create(AType, AMessage, [DEFAULT_GROUP]);
end;

constructor EANAttribute.Create(const AType: TEAN; const AGroups: TGroupSet);
begin
  Create(AType, EmptyStr, AGroups);
end;

function EANAttribute.GetMessage: string;
begin
  if FMessage.IsEmpty then
    Exit(DEFAULT_MESSAGE);

  Result := FMessage;
end;

end.
