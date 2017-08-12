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

unit DValidation.Engine.ValidationContext;

interface
uses
  System.Generics.Collections,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.MetaData.ObjectMetaData,
  DValidation.Engine.ValueContext,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.ContraintValidators.ConstraintValidator;

type

  IValidationContext<T> = interface
    ['{DA4D0DCA-D795-40C7-A3CD-58CF1CAA47F5}']
    function GetRootObjectMetaData() : IObjectMetaData;
    function GetCurrentObjectType() : TClass;
    procedure MarkCurrentBeanAsProcessed(ValueContext : IValueContext<T>);
    procedure MarkConstraintProcessed();
    function GetFailingConstraints() : TList<IConstraintViolation<T>>;
    procedure AddConstraintViolation(ValueContext : IValueContext<T>; MetaContraint : IMetaConstraint);
    function IsFailFastModeEnabled() : Boolean;
    function HasFailingConstraints() : Boolean;
  end;

implementation

end.
