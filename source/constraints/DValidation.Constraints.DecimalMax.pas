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

unit DValidation.Constraints.DecimalMax;

interface
uses
  DValidation.Constraints.Constraint;

type

  DecimalMaxAttribute = class(ConstraintAttribute)
  private
    FMax : Double;
    FInclusive : Boolean;
  public
    constructor Create(const Parameters : string); override;
    property Max : Double read FMax;
    property Inclusive : Boolean read FInclusive;
  end;

implementation
uses System.Math;

{ NotBlankAttribute }

constructor DecimalMaxAttribute.Create(const Parameters: string);
begin

  FMessage := '{validation.constraints.DecimalMax.message}';

  inherited;

  FMax := GetParameter<Double>('Max', MaxDouble);

  FInclusive := GetParameter<Boolean>('Inclusive', True);

end;

end.
