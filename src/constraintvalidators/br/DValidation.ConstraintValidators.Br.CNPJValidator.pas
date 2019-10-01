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

unit DValidation.ConstraintValidators.Br.CNPJValidator;

interface
uses
  System.SysUtils,
  System.Math,
  System.RegularExpressions,
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Br.CNPJ;

type

  TCNPJValidator = class(TInterfacedObject, IConstraintValidator<string>)
  private
    function DoIsVAlid(const Value: string): Boolean;
    function HasAllRepeatedDigits(const Value: string): Boolean;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation

{ TCNPJValidator }

function TCNPJValidator.DoIsVAlid(const Value: string): Boolean;
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  try
    for I := 1 to 14 do
      cnpj[i] := StrToInt(Value[i]);

    //1� digit
    v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
    v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
    v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);

    //2� digit
    v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
    v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
    v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
    v[2] := v[2] + 2*v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);

    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));
  except on E: Exception do
    Result := False;
  end;
end;

function TCNPJValidator.HasAllRepeatedDigits(const Value: string): Boolean;
var
  I: Integer;
begin
  for I := 1 to 13 do
    if not (Value.Chars[I] = Value.Chars[0]) then
      Exit(False);

  Result := True;
end;

procedure TCNPJValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TCNPJValidator.IsValid(const Value: string): Boolean;
var
  LValue: string;
begin
  LValue := TRegEx.Replace(Value.Trim, '[\.\/-]*', '');

  if LValue.IsEmpty then
    Exit(True);

  if not TRegEx.IsMatch(LValue, '^\d{14}$') then
    Exit(False);

  if HasAllRepeatedDigits(LValue) then
    Exit(False);

  Result := DoIsVAlid(LValue);
end;

initialization
  TDValidation.RegisterConstraint(CNPJAttribute, TypeInfo(string), TCNPJValidator);
end.
