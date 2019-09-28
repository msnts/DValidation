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

unit DValidation.Constraints.Email;

interface

uses
  System.SysUtils,
  DValidation.Constraints.Constraint;

type

  EmailAttribute = class(ConstraintAttribute)
  const
    DEFAULT_MESSAGE = '{validation.constraints.Email.message}';
  private
    FPattern: string;
  protected
    function GetMessage: string; override;
  public
    property Pattern: string read FPattern;
  end;

implementation

{ EmailAttribute }

function EmailAttribute.GetMessage: string;
begin
  if FMessage.IsEmpty then
    Exit(DEFAULT_MESSAGE);

  Result := FMessage;
end;

end.
