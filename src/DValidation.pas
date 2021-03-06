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

unit DValidation;

interface
uses
  System.Generics.Collections,
  System.TypInfo,
  DValidation.Constraints.Constraint,
  DValidation.Engine.Validator,
  DValidation.Engine.Impl.Validator,
  DValidation.Engine.ConstraintValidatorManager,
  DValidation.Engine.Impl.ConstraintValidatorManager;

type

  TDValidation = class
  private
      class var FInstance : TDValidation;
  private
    FConstraintValidatorRegister : TDictionary<PTypeInfo, TDictionary<PTypeInfo, TClass>>;
  private
      class procedure ReleaseInstance();
  public
      class function GetInstance() : TDValidation;
      constructor Create();
      destructor Destroy(); override;
      function BuildValidator() : TValidator;
      class procedure RegisterConstraint(Constraint: TClass; DataType: PTypeInfo; ConstraintValidator : TClass);
  end;

implementation

{ TDValidation }

function TDValidation.BuildValidator: TValidator;
var
  Manager : IConstraintValidatorManager;
begin

  Manager := TConstraintValidatorManager.Create(FConstraintValidatorRegister);

  Result := TValidator.Create(Manager);

end;

constructor TDValidation.Create;
begin
  FConstraintValidatorRegister := TDictionary<PTypeInfo, TDictionary<PTypeInfo, TClass>>.Create;
end;

destructor TDValidation.Destroy;
var
  Tmp : TDictionary<PTypeInfo, TClass>;
begin


  for Tmp in FConstraintValidatorRegister.Values do
    Tmp.Free;

  FConstraintValidatorRegister.Free;

  inherited;
end;

class function TDValidation.GetInstance: TDValidation;
begin
  if not Assigned(Self.FInstance) then
      Self.FInstance := TDValidation.Create;

   Result := Self.FInstance
end;

class procedure TDValidation.RegisterConstraint(Constraint: TClass;
  DataType: PTypeInfo; ConstraintValidator: TClass);
var
  Validators : TDictionary<PTypeInfo, TClass>;
  HasValidators : Boolean;
begin

  HasValidators := FInstance.FConstraintValidatorRegister.TryGetValue(Constraint.ClassInfo, Validators);


  if not HasValidators then
  begin
    Validators := TDictionary<PTypeInfo, TClass>.Create;
    FInstance.FConstraintValidatorRegister.Add(Constraint.ClassInfo, Validators);
  end;

  Validators.Add(DataType, ConstraintValidator);

end;

class procedure TDValidation.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    Self.FInstance.Free;
end;

initialization

   TDValidation.GetInstance;

finalization
   TDValidation.ReleaseInstance;

end.
