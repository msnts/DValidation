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

unit DValidation.ConstraintValidators.RangeValidatorForOrdinal;

interface
uses
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Range;

type

  TRangeValidatorForOrdinal = class(TInterfacedObject, IConstraintValidator<Int64>)
  private
    FMinValue : Int64;
    FMaxValue : Int64;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : Int64) : Boolean;
  end;

implementation

{ TRangeValidatorForOrdinal }

procedure TRangeValidatorForOrdinal.Initialize(Constraint: ConstraintAttribute);
begin
  FMinValue := RangeAttribute(Constraint).Min;
  FMaxValue := RangeAttribute(Constraint).Max;
end;

function TRangeValidatorForOrdinal.IsValid(const Value: Int64): Boolean;
begin

  Result := ((Value >= FMinValue) and (Value <= FMaxValue));

end;

initialization
  TDValidation.RegisterConstraint(RangeAttribute, TypeInfo(Int64), TRangeValidatorForOrdinal);
end.
