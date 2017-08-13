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

unit DValidation.Constraints.Digits;

interface
uses
  DValidation.Constraints.Constraint;

type

  DigitsAttribute = class(ConstraintAttribute)
  private
    FInteger : Integer;
    FFraction : Integer;
  public
    constructor Create(const Parameters : string); override;
    property &Integer : Integer read FInteger;
    property Fraction : Integer read FFraction;
  end;

implementation

{ NotBlankAttribute }

constructor DigitsAttribute.Create(const Parameters: string);
begin

  FMessage := '{validation.constraints.Digits.message}';

  inherited;

  FInteger := GetParameter<System.Integer>('Integer', -1);
  FFraction := GetParameter<System.Integer>('Fraction', -1);

end;

end.
