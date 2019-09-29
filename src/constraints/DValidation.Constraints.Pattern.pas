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
  System.SysUtils,
  System.RegularExpressions,
  DValidation.Constraints.Constraint;

type

  TPatternFlags = TRegExOption;

  PatternAttribute = class(ConstraintAttribute)
  const
    DEFAULT_MESSAGE = '{validation.constraints.Pattern.message}';
  private
    FRegexp: string;
    FFlags: TPatternFlags;
  protected
    function GetMessage: string; override;
  public
    constructor Create(const ARegexp: string); overload;
    constructor Create(const ARegexp: string; const AFlags: TPatternFlags); overload;
    constructor Create(const ARegexp: string; const AMessage: string); overload;
    constructor Create(const ARegexp: string; const AGroups: TGroupSet); overload;
    constructor Create(const ARegexp: string; const AFlags: TPatternFlags; const AMessage: string); overload;
    constructor Create(const ARegexp: string; const AFlags: TPatternFlags; const AGroups: TGroupSet); overload;
    constructor Create(const ARegexp: string; const AMessage: string; const AGroups: TGroupSet); overload;
    constructor Create(const ARegexp: string; const AFlags: TPatternFlags; const AMessage: string; const AGroups: TGroupSet); overload;
    property Regexp: string read FRegexp;
    property Flags: TPatternFlags read FFlags;
  end;

implementation

{ PatternAttribute }

constructor PatternAttribute.Create(const ARegexp: string);
begin
  Create(ARegexp, [roNotEmpty], EmptyStr, [DEFAULT_GROUP]);
end;

constructor PatternAttribute.Create(const ARegexp: string; const AFlags: TPatternFlags);
begin
  Create(ARegexp, AFlags, EmptyStr, [DEFAULT_GROUP]);
end;

constructor PatternAttribute.Create(const ARegexp: string; const AFlags: TPatternFlags; const AMessage: string);
begin
  Create(ARegexp, AFlags, AMessage, [DEFAULT_GROUP]);
end;

constructor PatternAttribute.Create(const ARegexp: string; const AGroups: TGroupSet);
begin
  Create(ARegexp, [roNotEmpty], EmptyStr, AGroups);
end;

constructor PatternAttribute.Create(const ARegexp, AMessage: string);
begin
  Create(ARegexp, [roNotEmpty], AMessage, [DEFAULT_GROUP]);
end;

constructor PatternAttribute.Create(const ARegexp: string; const AFlags: TPatternFlags; const AMessage: string; const AGroups: TGroupSet);
begin
  FRegexp := ARegexp;
  FFlags := AFlags;
  FMessage := AMessage;
  FGroups := AGroups;
end;

constructor PatternAttribute.Create(const ARegexp, AMessage: string; const AGroups: TGroupSet);
begin
  Create(ARegexp, [roNotEmpty], AMessage, AGroups);
end;

constructor PatternAttribute.Create(const ARegexp: string; const AFlags: TPatternFlags; const AGroups: TGroupSet);
begin
  Create(ARegexp, AFlags, EmptyStr, AGroups);
end;

function PatternAttribute.GetMessage: string;
begin
  if FMessage.IsEmpty then
    Exit(DEFAULT_MESSAGE);

  Result := FMessage;
end;

end.
