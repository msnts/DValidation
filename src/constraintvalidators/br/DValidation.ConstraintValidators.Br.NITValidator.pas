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

unit DValidation.ConstraintValidators.Br.NITValidator;

interface
uses
  System.SysUtils,
  System.RegularExpressions,

  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Br.NIT;

type

  TNITValidator = class(TInterfacedObject, IConstraintValidator<string>)
  private
    function DoIsValid(const Value: string): Boolean;
    function HasAllRepeatedDigits(const Value: string): Boolean;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation

{ TNITValidator }

function TNITValidator.DoIsValid(const Value: string): Boolean;
var
  Soma, I, Digito, DigVer, Mult: Integer;
begin
  DigVer := Integer.Parse(Value[11]);

  Soma := 0;
  Mult := 2;

  for I := 10 downto 1 do
  begin
    Soma := Soma + (Mult * Integer.Parse(Value[I]));

    if Mult < 9 then
      Inc(Mult)
    else
      Mult := 2;
  end;

  Digito := 11 - (Soma mod 11);

  if Digito > 9 then
    Digito := 0;

  Result := (DigVer = Digito);
end;

function TNITValidator.HasAllRepeatedDigits(const Value: string): Boolean;
var
  I: Integer;
begin
  for I := 1 to 10 do
    if not (Value.Chars[I] = Value.Chars[0]) then
      Exit(False);

  Result := True;
end;

procedure TNITValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TNITValidator.IsValid(const Value: string): Boolean;
var
  LValue: string;
begin
  LValue := TRegEx.Replace(Value.Trim, '[\.\/-]*', '');

  if LValue.IsEmpty then
    Exit(True);

  if not TRegEx.IsMatch(LValue, '^\d{11}$') then
    Exit(False);

  if HasAllRepeatedDigits(LValue) then
    Exit(False);

  Result := DoIsValid(LValue);
end;

initialization
  TDValidation.RegisterConstraint(NITAttribute, TypeInfo(string), TNITValidator);
end.
