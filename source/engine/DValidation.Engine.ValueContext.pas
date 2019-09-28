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

unit DValidation.Engine.ValueContext;

interface
uses
  System.TypInfo,
  System.Rtti,
  DValidation.Engine.MetaData.ObjectMetaData;

type

  IValueContext<T> = interface
    ['{0FE2E542-53E4-4D82-9B37-A16830E6FA7F}']
    function GetCurrentGroup(): Byte;
    procedure SetCurrentGroup(const Group : Byte);
    function GetCurrentObjectType() : PTypeInfo;
    function GetCurrentObjectMetaData() : IObjectMetaData;
    function GetCurrentObject() : T;
    function GetCurrentValidatedValue() : TValue;
    procedure SetMember(aMember : TRttiMember);
  end;

implementation

end.
