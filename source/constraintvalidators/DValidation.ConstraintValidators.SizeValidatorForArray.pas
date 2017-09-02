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

unit DValidation.ConstraintValidators.SizeValidatorForArray;

interface
uses
  System.Rtti,
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.ConstraintValidators.AbstractSizeValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Size,
  DValidation.Exceptions;

type

  TSizeValidatorForArray = class(TAbstractSizeValidator, IConstraintValidator<TValue>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : TValue) : Boolean;
  end;

implementation

{ TSizeValidatorForArray }

procedure TSizeValidatorForArray.Initialize(Constraint: ConstraintAttribute);
begin
  DoInitialize(Constraint);
end;

function TSizeValidatorForArray.IsValid(const Value: TValue): Boolean;
var
  Size : Integer;
begin

  if not Value.IsArray then
    raise ConstraintException.Create('Invalid data type for validation');

  Size := Value.GetArrayLength;

  Result := DoIsValid(Size);

end;

initialization
  TDValidation.RegisterConstraint(SizeAttribute, TypeInfo(TValue), TSizeValidatorForArray);
end.
