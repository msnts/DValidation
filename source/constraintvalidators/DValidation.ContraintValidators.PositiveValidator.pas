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

unit DValidation.ContraintValidators.PositiveValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Positive;

type

  TPositiveValidator = class(TInterfacedObject, IConstraintValidator<variant>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : variant) : Boolean;
  end;

implementation
uses System.SysUtils, System.Variants;

{ TPositiveValidator }

procedure TPositiveValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TPositiveValidator.IsValid(const Value: variant): Boolean;
var
  BasicType: Integer;
begin

  BasicType := VarType(Value) and VarTypeMask;

  if BasicType in [varByte, varShortInt, varWord, varSmallInt, varLongWord, varInteger, varInt64] then
    Result := not (Int64(Value) < 0)
  else
    if BasicType in [varSingle, varDouble, varCurrency] then
      Result := not (Extended(Value) < 0)
    else
      raise Exception.Create('Invalid data type for validation');

end;

initialization
  TDValidation.RegisterConstraint(PositiveAttribute, TPositiveValidator);
end.
