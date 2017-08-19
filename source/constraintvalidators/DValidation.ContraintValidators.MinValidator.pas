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

unit DValidation.ContraintValidators.MinValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Min;

type

  TMinValidator = class(TInterfacedObject, IConstraintValidator<variant>)
  private
    FMinValue : Int64;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : variant) : Boolean;
  end;

implementation
uses System.SysUtils, System.Variants;

{ TMinValidator }

procedure TMinValidator.Initialize(Constraint: ConstraintAttribute);
begin
  FMinValue := MinAttribute(Constraint).Min;
end;

function TMinValidator.IsValid(const Value: variant): Boolean;
var
  BasicType: Integer;
begin

  BasicType := VarType(Value) and VarTypeMask;

  if not(BasicType in [varByte, varShortInt, varWord, varSmallInt, varLongWord, varInteger, varInt64, varUInt64]) then
    raise Exception.Create('Invalid data type for validation');

  Result := Int64(Value) >= FMinValue;

end;

initialization
  TDValidation.RegisterConstraint(MinAttribute, TMinValidator);
end.
