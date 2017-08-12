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

unit DValidation.Constraints.Min;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  MinAttribute = class(ConstraintAttribute)
  private
    FMin : Integer;
  public
    constructor Create(const Parameters : string); override;
    property Min : Integer read FMin;
  end;

implementation

{ NotBlankAttribute }

constructor MinAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Min_Message;

  inherited;

  FMin := GetParameter<Integer>('Min', 0);

end;

end.
