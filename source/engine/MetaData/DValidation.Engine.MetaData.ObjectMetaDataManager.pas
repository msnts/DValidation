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

unit DValidation.Engine.MetaData.ObjectMetaDataManager;

interface
uses
  System.TypInfo,
  DValidation.Engine.MetaData.ObjectMetaData;

type

  IObjectMetaDataManager = interface
    ['{5A9D462C-C480-4AC2-9C28-0EF1AE65A404}']
    function GetObjectMetaData(aClass : TClass) : IObjectMetaData; overload;
    function GetObjectMetaData(aType : PTypeInfo) : IObjectMetaData; overload;
  end;

implementation

end.
