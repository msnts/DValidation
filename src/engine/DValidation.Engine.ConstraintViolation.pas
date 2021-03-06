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

unit DValidation.Engine.ConstraintViolation;

interface
uses System.Rtti;

type
  IConstraintViolation<T> = interface
    ['{C052BF76-4957-494A-A1AA-8ED7782D4B37}']
    function GetMessage() : string;
    function GetRootObject() : T;
    function GetInvalidValue() : TValue;
  end;

implementation

end.
