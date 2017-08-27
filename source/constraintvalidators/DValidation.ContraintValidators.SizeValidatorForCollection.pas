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

unit DValidation.ContraintValidators.SizeValidatorForCollection;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.ContraintValidators.AbstractSizeValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Size,
  DValidation.Exceptions,
  DValidation.ContraintValidators.ConstraintValidatorUtils;

type

  TSizeValidatorForCollection = class(TAbstractSizeValidator, IConstraintValidator<TObject>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : TObject) : Boolean;
  end;

implementation

{ TSizeValidatorForCollection }

procedure TSizeValidatorForCollection.Initialize(Constraint: ConstraintAttribute);
begin

  DoInitialize(Constraint);

end;

function TSizeValidatorForCollection.IsValid(const Value: TObject): Boolean;
var
  Size : Integer;
begin

  Size := TConstraintValidatorUtils.GetCollectionSize(Value);

  Result := DoIsValid(Size);

end;

initialization
  TDValidation.RegisterConstraint(SizeAttribute, TypeInfo(TObject), TSizeValidatorForCollection);
end.
