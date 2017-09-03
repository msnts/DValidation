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

unit DValidation.ConstraintValidators.EANValidator;

interface
uses
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.EAN,
  System.RegularExpressions,
  DValidation.Exceptions;

type

  TEANValidator = class(TInterfacedObject, IConstraintValidator<string>)
  private
    FSize : Integer;
    function CheckSum(const Barcode: string): Integer;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TEANValidator }

function TEANValidator.CheckSum(const Barcode: string): Integer;
var
  Sum, Factor, Index, Digit: Integer;
begin

  Sum := 0;
  Factor := 3;

  try

    for Index := Barcode.Length - 1 downto 1 do
    begin

      Digit := Integer.Parse(Barcode[Index]);

      Sum := Sum + (Digit * Factor);

      Factor := 4 - Factor;

    end;
  except
    Sum := -1;
  end;

  Sum := (Sum mod 10);

  if Sum <> 0 then
    Sum := 10 - Sum;

  Result := Sum;

end;

procedure TEANValidator.Initialize(Constraint: ConstraintAttribute);
begin

  case EANAttribute(Constraint).&Type of
    EAN8: FSize := 8;
    EAN13 : FSize := 13;
  else
    raise ConstraintException.Create('Invalid EAN type');
  end;

end;

function TEANValidator.IsValid(const Value: string): Boolean;
var
  Digit, Check : Integer;
begin

  if Value.IsEmpty then
    Exit(True);

  if not TRegEx.IsMatch(Value, '^\d{' + String.Parse(FSize) + '}$') then
    Exit(False);

  Digit := Integer.Parse(Value[FSize]);

  Check := CheckSum(Value);

  Result := Digit = Check;

end;

initialization
  TDValidation.RegisterConstraint(EANAttribute, TypeInfo(string), TEANValidator);
end.
