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

unit DValidation.Engine.Validator;

interface
uses
  System.Generics.Collections,
  DValidation.Engine.ConstraintViolation;

type

  IValidator = interface
    ['{63959032-1A28-4FC8-B9C0-38455BAEDB54}']

    function Validate(Obj : TObject; Groups : TArray<string>) : TList<IConstraintViolation<Tobject>>;
    function ValidateProperty(Obj : TObject; const PropertyName : string; Groups : TArray<string>) : TList<IConstraintViolation<Tobject>>;

  end;

implementation

end.
