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

unit DValidation.ConstraintValidators.NegativeOrZeroValidatorForDecimal;

interface
uses
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.NegativeOrZero;

type

  TNegativeOrZeroValidatorForDecimal = class(TInterfacedObject, IConstraintValidator<Extended>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : Extended) : Boolean;
  end;

implementation

{ TNegativeOrZeroValidatorForDecimal }

procedure TNegativeOrZeroValidatorForDecimal.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TNegativeOrZeroValidatorForDecimal.IsValid(const Value: Extended): Boolean;
begin

  Result := Value <= 0;

end;

initialization
  TDValidation.RegisterConstraint(NegativeOrZeroAttribute, TypeInfo(Extended), TNegativeOrZeroValidatorForDecimal);
end.
