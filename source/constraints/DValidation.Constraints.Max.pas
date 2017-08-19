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

unit DValidation.Constraints.Max;

interface
uses
  DValidation.Constraints.Constraint,
  DValidation.Exceptions;

type

  MaxAttribute = class(ConstraintAttribute)
  private
    FMax : Int64;
  public
    constructor Create(const Parameters : string); override;
    property Max : Int64 read FMax;
  end;

implementation

{ NotBlankAttribute }

constructor MaxAttribute.Create(const Parameters: string);
begin

  FMessage := '{validation.constraints.Max.message}';

  inherited;

  if not HasParameter('Max') then
    raise ConstraintException.Create('Parameter "Max" required');

  FMax := GetParameter<Int64>('Max', High(Int64));

end;

end.
