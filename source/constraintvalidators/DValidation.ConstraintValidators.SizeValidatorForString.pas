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

unit DValidation.ConstraintValidators.SizeValidatorForString;

interface
uses
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.ConstraintValidators.AbstractSizeValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Size,
  DValidation.Exceptions;

type

  TSizeValidator = class(TAbstractSizeValidator, IConstraintValidator<string>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TSizeValidator }

procedure TSizeValidator.Initialize(Constraint: ConstraintAttribute);
begin

  DoInitialize(Constraint);

end;

function TSizeValidator.IsValid(const Value: string): Boolean;
var
  StrSize : Integer;
begin

  StrSize := Value.Length;

  Result := DoIsValid(StrSize);

end;

initialization
  TDValidation.RegisterConstraint(SizeAttribute, TypeInfo(string), TSizeValidator);
end.
