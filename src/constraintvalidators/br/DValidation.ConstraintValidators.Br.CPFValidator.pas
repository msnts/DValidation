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

unit DValidation.ConstraintValidators.Br.CPFValidator;

interface
uses
  System.SysUtils,
  System.Math,
  System.RegularExpressions,
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Br.CPF;

type

  TCPFValidator = class(TInterfacedObject, IConstraintValidator<string>)
  private
    function DoIsVAlid(const Value: string): Boolean;
    function HasAllRepeatedDigits(const Value: string): Boolean;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation

{ TCPFValidator }

function TCPFValidator.DoIsVAlid(const Value: string): Boolean;
var
  v: array[0..1] of Word;
  cpf: array[0..10] of Byte;
  I: Byte;
begin
  try
    for I := 1 to 11 do
      cpf[i-1] := StrToInt(Value[i]);

    //1º Digit
    v[0] := 10*cpf[0] + 9*cpf[1] + 8*cpf[2];
    v[0] := v[0] + 7*cpf[3] + 6*cpf[4] + 5*cpf[5];
    v[0] := v[0] + 4*cpf[6] + 3*cpf[7] + 2*cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[0] := IfThen(v[0] >= 10, 0, v[0]);

    //2º Digit
    v[1] := 11*cpf[0] + 10*cpf[1] + 9*cpf[2];
    v[1] := v[1] + 8*cpf[3] +  7*cpf[4] + 6*cpf[5];
    v[1] := v[1] + 5*cpf[6] +  4*cpf[7] + 3*cpf[8];
    v[1] := v[1] + 2*v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);

    Result :=  ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except on E: Exception do
    Result := False;
  end;
end;

function TCPFValidator.HasAllRepeatedDigits(const Value: string): Boolean;
var
  I: Integer;
begin
  for I := 1 to 10 do
    if not (Value.Chars[I] = Value.Chars[0]) then
      Exit(False);

  Result := True;
end;

procedure TCPFValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TCPFValidator.IsValid(const Value: string): Boolean;
var
  LValue: string;
begin
  LValue := TRegEx.Replace(Value.Trim, '[\.-]*', '');

  if LValue.IsEmpty then
    Exit(True);

  if not TRegEx.IsMatch(LValue, '^\d{11}$') then
    Exit(False);

  if HasAllRepeatedDigits(LValue) then
    Exit(False);

  Result := DoIsVAlid(LValue);
end;

initialization
  TDValidation.RegisterConstraint(CPFAttribute, TypeInfo(string), TCPFValidator);
end.
