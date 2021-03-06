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

unit DValidation.Engine.MetaData.MetaConstraint;

interface
uses
  System.Generics.Collections,
  System.TypInfo,
  System.Rtti,
  DValidation.Constraints.Constraint;

type

  IMetaConstraint = interface
    ['{5592C0D5-1B22-4496-893F-4B28FAE8D337}']
    function GetGroupList() : TGroupSet;
    function GetConstraintType() : PTypeInfo;
    function GetMember() : TRttiMember;
    function GetAttributes() : TDictionary<string, TValue>;
    function GetMessageTemplate() : string;
    function GetConstraint() : ConstraintAttribute;
  end;

implementation

end.
