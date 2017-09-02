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

unit DValidation.ConstraintValidators.AbstractSizeValidator;

interface
uses
  DValidation,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Size,
  DValidation.Exceptions;

type

  TAbstractSizeValidator = class(TInterfacedObject)
  protected
    FMin : Integer;
    FMax : Integer;

    procedure ValidateParameters();
    procedure DoInitialize(Constraint : ConstraintAttribute);
    function DoIsValid(const Size : Integer) : Boolean;

  end;

implementation
uses System.SysUtils;

{ TAbstractSizeValidator }

procedure TAbstractSizeValidator.DoInitialize(Constraint: ConstraintAttribute);
begin

  FMin := SizeAttribute(Constraint).Min;
  FMax := SizeAttribute(Constraint).Max;

  ValidateParameters;

end;

function TAbstractSizeValidator.DoIsValid(const Size: Integer): Boolean;
begin
  Result := ((Size >= FMin) and (Size <= FMax));
end;

procedure TAbstractSizeValidator.ValidateParameters;
begin

  if FMin < 0 then
    raise ValidationException.Create('The min parameter cannot be negative');

  if FMax < 0 then
    raise ValidationException.Create('The max parameter cannot be negative');

  if FMax < FMin then
    raise ValidationException.Create('Max cannot be less than Min');

end;

end.
