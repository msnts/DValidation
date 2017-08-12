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

unit DValidation.Constraints.Valid;

interface

type
  /// <summary> Marks a property, method parameter for validation cascading.
  /// <para>
  /// Constraints defined on the object and its properties are be validated when the
  /// property, method parameter is validated. </para>
  /// <para>
  /// This behavior is applied recursively.
  /// </para>
  /// </summary>
  ValidAttribute = class(TCustomAttribute);

implementation

end.
