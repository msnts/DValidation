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

unit DValidation.ConstraintValidators.NotEmptyValidatorForCollection;

interface
uses
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.NotEmpty,
  DValidation.Exceptions,
  DValidation.ConstraintValidators.ConstraintValidatorUtils;

type

  TNotEmptyValidatorForCollection = class(TInterfacedObject, IConstraintValidator<TObject>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Collection : TObject) : Boolean;
  end;

implementation

{ TNotEmptyValidatorForCollection }

procedure TNotEmptyValidatorForCollection.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TNotEmptyValidatorForCollection.IsValid(const Collection: TObject): Boolean;
var
  Size : Integer;
begin

  if Collection = nil then
    Exit(False);

  Size := TConstraintValidatorUtils.GetCollectionSize(Collection);

  Result := Size > 0;

end;

initialization
  TDValidation.RegisterConstraint(NotEmptyAttribute, TypeInfo(TObject), TNotEmptyValidatorForCollection);
end.
