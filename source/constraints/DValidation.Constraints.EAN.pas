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

unit DValidation.Constraints.EAN;

interface
uses
  TypInfo,
  DValidation.Constraints.Constraint,
  DValidation.Exceptions;

type

  TEAN = (EAN8, EAN13);

  EANAttribute = class(ConstraintAttribute)
  private
    FType : TEAN;
  public
    constructor Create(const Parameters : string); override;
    property &Type : TEAN read FType;
  end;

implementation

{ NotBlankAttribute }

constructor EANAttribute.Create(const Parameters: string);
var
  TypeName : string;
begin

  FMessage := '{}';

  inherited;

  TypeName := GetParameter<string>('Type', 'EAN13');

  try
    FType := TEAN(GetEnumValue(TypeInfo(TEAN), TypeName));

  except
    raise ConstraintException.Create('The "' + TypeName + '" value is invalid EAN type');
  end;

end;

end.
