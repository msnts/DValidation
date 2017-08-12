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

unit DValidation.Constraints.Pattern;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  PatternAttribute = class(ConstraintAttribute)
  private
    FRegexp : string;
    FFlags : string;
  public
    constructor Create(const Parameters : string); override;
    property Regexp : string read FRegexp;
    property Flags : string read FFlags;
  end;

implementation

{ NotBlankAttribute }

constructor PatternAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Pattern_Message;

  inherited;

  FRegexp := GetParameter<string>('Regexp', '');
  FFlags := GetParameter<string>('Flags', '');

end;

end.
