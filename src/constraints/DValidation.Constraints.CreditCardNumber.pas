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

unit DValidation.Constraints.CreditCardNumber;

interface
uses
  System.SysUtils,
  DValidation.Constraints.Constraint;

type

  CreditCardNumberAttribute = class(SimpleConstraintAttribute)
  const
    DEFAULT_MESSAGE = '{validation.constraints.CreditCardNumber.message}';
  private
    FIgnoreNonDigitCharacters: Boolean;
  protected
    function GetMessage: string; override;
  public
    constructor Create(const AIgnoreNonDigitCharacters: Boolean); overload;
    constructor Create(const AIgnoreNonDigitCharacters: Boolean; const AMessage: string); overload;
    constructor Create(const AIgnoreNonDigitCharacters: Boolean; const AGroups: TGroupSet); overload;
    constructor Create(const AIgnoreNonDigitCharacters: Boolean; const AMessage: string; const AGroups: TGroupSet); overload;
    property IgnoreNonDigitCharacters: Boolean read FIgnoreNonDigitCharacters;
  end;

implementation

{ CreditCardNumberAttribute }

constructor CreditCardNumberAttribute.Create(const AIgnoreNonDigitCharacters: Boolean);
begin
  FIgnoreNonDigitCharacters := AIgnoreNonDigitCharacters;
  FMessage := EmptyStr;
  FGroups := [DEFAULT_GROUP];
end;

constructor CreditCardNumberAttribute.Create(const AIgnoreNonDigitCharacters: Boolean; const AMessage: string);
begin
  FIgnoreNonDigitCharacters := AIgnoreNonDigitCharacters;
  FMessage := AMessage;
  FGroups := [DEFAULT_GROUP];
end;

constructor CreditCardNumberAttribute.Create(const AIgnoreNonDigitCharacters: Boolean; const AGroups: TGroupSet);
begin
  FIgnoreNonDigitCharacters := AIgnoreNonDigitCharacters;
  FMessage := EmptyStr;
  FGroups := AGroups;
end;

constructor CreditCardNumberAttribute.Create(const AIgnoreNonDigitCharacters: Boolean; const AMessage: string;  const AGroups: TGroupSet);
begin
  FIgnoreNonDigitCharacters := AIgnoreNonDigitCharacters;
  FMessage := AMessage;
  FGroups := AGroups;
end;

function CreditCardNumberAttribute.GetMessage: string;
begin
  if FMessage.IsEmpty then
    Exit(DEFAULT_MESSAGE);

  Result := FMessage;
end;

end.
