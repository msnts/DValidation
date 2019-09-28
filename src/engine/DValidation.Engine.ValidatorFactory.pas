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

unit DValidation.Engine.ValidatorFactory;

interface
uses
  DValidation.Engine.Validator,
  DValidation.Engine.ConstraintValidatorFactory;

type

  IValidatorFactory = interface
    ['{FF5664A2-4BDF-4DBD-BD23-B675D1E94736}']
    function GetValidator() : IValidator;
    function GetConstraintValidatorFactory() : IConstraintValidatorFactory;
  end;

implementation

end.
