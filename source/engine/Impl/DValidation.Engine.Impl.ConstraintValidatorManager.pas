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

unit DValidation.Engine.Impl.ConstraintValidatorManager;

interface
uses
  System.Generics.Collections,
  System.TypInfo,
  System.SysUtils,
  DValidation.Engine.ConstraintValidatorManager,
  DValidation.ContraintValidators.ConstraintValidator;

type

  TConstraintValidatorManager = class(TInterfacedObject, IConstraintValidatorManager)
  private
    FConstraintValidatorRegister : TDictionary<PTypeInfo, TDictionary<PTypeInfo, TClass>>;
  public
    constructor Create(aConstraintValidatorRegister : TDictionary<PTypeInfo, TDictionary<PTypeInfo, TClass>>);
    function GetInitializedValidator(ConstraintType, DataType : PTypeInfo) : IConstraintValidator<variant>;
  end;

implementation

{ TConstraintValidatorManager }

constructor TConstraintValidatorManager.Create(
  aConstraintValidatorRegister: TDictionary<PTypeInfo, TDictionary<PTypeInfo, TClass>>);
begin
  FConstraintValidatorRegister := aConstraintValidatorRegister;
end;

function TConstraintValidatorManager.GetInitializedValidator(ConstraintType, DataType : PTypeInfo): IConstraintValidator<variant>;
var
  Clazz : TClass;
  Validator : TInterfacedObject;
  Validators : TDictionary<PTypeInfo, TClass>;
begin

  if not FConstraintValidatorRegister.TryGetValue(ConstraintType, Validators) then
    raise Exception.Create('Not found constraint validator for ' + ConstraintType.Name);

  if not Validators.TryGetValue(DataType, Clazz) then
    raise Exception.Create('Not found constraint validator for ' + ConstraintType.Name);

  Validator := Clazz.Create as TInterfacedObject;

  Result := Validator as IConstraintValidator<variant>;

end;

end.
