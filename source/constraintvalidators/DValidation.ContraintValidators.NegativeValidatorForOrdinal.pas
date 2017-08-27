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

unit DValidation.ContraintValidators.NegativeValidatorForOrdinal;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Negative;

type

  TNegativeValidator = class(TInterfacedObject, IConstraintValidator<Int64>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : Int64) : Boolean;
  end;

implementation

{ TNegativeValidator }

procedure TNegativeValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TNegativeValidator.IsValid(const Value: Int64): Boolean;
begin

  Result := Value < 0;

end;

initialization
  TDValidation.RegisterConstraint(NegativeAttribute, TypeInfo(Int64), TNegativeValidator);
end.
