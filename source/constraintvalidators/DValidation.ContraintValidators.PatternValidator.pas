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

unit DValidation.ContraintValidators.PatternValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Pattern,
  System.RegularExpressions;

type

  TPatternValidator = class(TInterfacedObject, IConstraintValidator<string>)
    FRegEx: TRegEx;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation

{ TPatternValidator }

procedure TPatternValidator.Initialize(Constraint: ConstraintAttribute);
begin

  try
    FRegEx := TRegex.Create(PatternAttribute(Constraint).Regexp);
  except

  end;

end;

function TPatternValidator.IsValid(const Value: string): Boolean;
begin

  Result := FRegEx.Match(Value).Success;

end;

initialization
  TDValidation.RegisterConstraint(PatternAttribute, TPatternValidator);
end.
