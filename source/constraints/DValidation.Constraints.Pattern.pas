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
  DValidation.Constraints.Constraint,
  DValidation.Exceptions;

type

  PatternAttribute = class(ConstraintAttribute)
  private
    FRegexp : string;
    FFlags : string;
  public
    /// <summary> The annotated {string} must match the specified regular expression.
    /// </summary>
    /// <param name="Regexp">The regular expression to match</param>
    /// <param name="Flags">Array of Flags considered when resolving the regular expression</param>
    /// <param name="Message">The error message template</param>
    /// <param name="Groups">The groups the constraint belongs to</param>
    /// <remarks>
    /// If parameter "Regexp" is null or empty, an exception is raised.
    /// <see cref="ConstraintException"/>
    /// </remarks>
    constructor Create(const Parameters : string);
    property Regexp : string read FRegexp;
    property Flags : string read FFlags;
  end;

implementation

{ NotBlankAttribute }

constructor PatternAttribute.Create(const Parameters: string);
begin

  FMessage := '{validation.constraints.Pattern.message}';


  //FRegexp := GetParameter<string>('Regexp', '');
  //FFlags := GetParameter<string>('Flags', '');

end;

end.
