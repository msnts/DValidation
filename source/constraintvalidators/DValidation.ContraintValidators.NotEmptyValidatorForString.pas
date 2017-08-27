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

unit DValidation.ContraintValidators.NotEmptyValidatorForString;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.NotEmpty,
  DValidation.Exceptions,
  System.Generics.Collections;

type

  TNotEmptyValidatorForString = class(TInterfacedObject, IConstraintValidator<string>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TNotEmptyValidatorForString }

procedure TNotEmptyValidatorForString.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TNotEmptyValidatorForString.IsValid(const Value: string): Boolean;
begin

  Result := not Value.Trim.IsEmpty;

end;

initialization
  TDValidation.RegisterConstraint(NotEmptyAttribute, TypeInfo(string), TNotEmptyValidatorForString);
end.
