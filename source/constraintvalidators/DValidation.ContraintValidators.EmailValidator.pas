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

unit DValidation.ContraintValidators.EmailValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Email;

type

  TEmailValidator = class(TInterfacedObject, IConstraintValidator<string>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation
uses System.RegularExpressions;

{ TEmailValidator }

procedure TEmailValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TEmailValidator.IsValid(const Value: string): Boolean;
var
  RegEx: TRegEx;
begin

  RegEx := TRegex.Create('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]*[a-zA-Z0-9]+$');

  Result := RegEx.Match(Value).Success;

end;

initialization
  TDValidation.RegisterConstraint(EmailAttribute, TEmailValidator);
end.
