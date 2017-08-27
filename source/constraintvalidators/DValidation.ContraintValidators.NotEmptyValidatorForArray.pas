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

unit DValidation.ContraintValidators.NotEmptyValidatorForArray;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.NotEmpty,
  DValidation.Exceptions,
  System.Generics.Collections;

type

  TNotEmptyValidatorForArray = class(TInterfacedObject, IConstraintValidator<variant>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : variant) : Boolean;
  end;

implementation
uses System.SysUtils, System.Variants;

{ TNotEmptyValidatorForArray }

procedure TNotEmptyValidatorForArray.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TNotEmptyValidatorForArray.IsValid(const Value: variant): Boolean;
begin

  if not VarIsArray(Value) then
    raise ConstraintException.Create('Invalid data type for validation');

  Result := VarArrayDimCount(Value) > 0;

end;


initialization
  TDValidation.RegisterConstraint(NotEmptyAttribute, TypeInfo(variant), TNotEmptyValidatorForArray);
end.
