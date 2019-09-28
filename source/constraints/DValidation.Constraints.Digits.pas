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

unit DValidation.Constraints.Digits;

interface
uses
  System.SysUtils,
  DValidation.Constraints.Constraint;

type

  DigitsAttribute = class(ConstraintAttribute)
  const
    DEFAULT_MESSAGE = '{validation.constraints.Digits.message}';
  private
    FInteger : Integer;
    FFraction : Integer;
  protected
    function GetMessage: string; override;
  public
    constructor Create(const AInteger, AFraction: Integer); overload;
    constructor Create(const AInteger, AFraction: Integer; const AMessage : string); overload;
    constructor Create(const AInteger, AFraction: Integer; const AGroups: TGroupSet); overload;
    constructor Create(const AInteger, AFraction: Integer; const AMessage: string; const AGroups: TGroupSet); overload;
    property &Integer : Integer read FInteger;
    property Fraction : Integer read FFraction;
  end;

implementation

{ DigitsAttribute }

constructor DigitsAttribute.Create(const AInteger, AFraction: Integer);
begin
  Create(AInteger, AFraction, EmptyStr, [DEFAULT_GROUP]);
end;

constructor DigitsAttribute.Create(const AInteger, AFraction: Integer; const AMessage: string);
begin
  Create(AInteger, AFraction, AMessage, [DEFAULT_GROUP]);
end;

constructor DigitsAttribute.Create(const AInteger, AFraction: Integer; const AGroups: TGroupSet);
begin
   Create(AInteger, AFraction, EmptyStr, AGroups);
end;

constructor DigitsAttribute.Create(const AInteger, AFraction: Integer; const AMessage: string; const AGroups: TGroupSet);
begin
  FInteger := AInteger;
  FFraction := AFraction;
  FMessage := AMessage;
  FGroups := AGroups;
end;

function DigitsAttribute.GetMessage: string;
begin
  if FMessage.IsEmpty then
    Exit(DEFAULT_MESSAGE);

  Result := FMessage;
end;

end.
