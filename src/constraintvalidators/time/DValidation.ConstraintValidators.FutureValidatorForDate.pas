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

unit DValidation.ConstraintValidators.FutureValidatorForDate;

interface
uses
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Time.Future;

type

  TFutureValidatorForDate = class(TInterfacedObject, IConstraintValidator<TDate>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : TDate) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TNotBlankValidator }

procedure TFutureValidatorForDate.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TFutureValidatorForDate.IsValid(const Value: TDate): Boolean;
begin

  Result := Value > Date;

end;

initialization
  TDValidation.RegisterConstraint(FutureAttribute, TypeInfo(TDate), TFutureValidatorForDate);
end.
