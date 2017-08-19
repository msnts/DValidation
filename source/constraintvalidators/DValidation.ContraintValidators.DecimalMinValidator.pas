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

unit DValidation.ContraintValidators.DecimalMinValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.DecimalMin;

type

  TDecimalMinValidator = class(TInterfacedObject, IConstraintValidator<variant>)
  private
    FDecimalMinValue : Extended;
    FInclusive : Boolean;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : variant) : Boolean;
  end;

implementation
uses System.SysUtils, System.Variants;

{ TDecimalMinValidator }

procedure TDecimalMinValidator.Initialize(Constraint: ConstraintAttribute);
begin
  FDecimalMinValue := DecimalMinAttribute(Constraint).Min;
  FInclusive := DecimalMinAttribute(Constraint).Inclusive;
end;

function TDecimalMinValidator.IsValid(const Value: variant): Boolean;
var
  BasicType : Integer;
begin

  BasicType := VarType(Value) and VarTypeMask;

  if not (BasicType in [varSingle, varDouble, varCurrency]) then
    raise Exception.Create('Invalid data type for interpolation');

  if FInclusive then
    Result := Extended(Value) >= FDecimalMinValue
  else
    Result := Extended(Value) > FDecimalMinValue;

end;

initialization
  TDValidation.RegisterConstraint(DecimalMinAttribute, TDecimalMinValidator);
end.
