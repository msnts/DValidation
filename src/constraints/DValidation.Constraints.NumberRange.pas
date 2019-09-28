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

unit DValidation.Constraints.NumberRange;

interface
uses
  System.SysUtils,
  DValidation.Constraints.Constraint;

type

  NumberRangeAttribute<T> = class abstract(ConstraintAttribute)
  protected
    FMin: T;
    FMax: T;
    FInclusive: Boolean;
  public
    constructor Create(const AMin, AMax: T); overload;
    constructor Create(const AMin, AMax: T; const AInclusive: Boolean); overload;
    constructor Create(const AMin, AMax: T; const AMessage: string); overload;
    constructor Create(const AMin, AMax: T; const AGroups: TGroupSet); overload;
    constructor Create(const AMin, AMax: T; const AInclusive: Boolean; const AMessage: string); overload;
    constructor Create(const AMin, AMax: T; const AInclusive: Boolean; const AGroups: TGroupSet); overload;
    constructor Create(const AMin, AMax: T; const AMessage: string; const AGroups: TGroupSet); overload;
    constructor Create(const AMin, AMax: T; const AInclusive: Boolean; const AMessage: string; const AGroups: TGroupSet); overload;
    property Min: T read FMin;
    property Max: T read FMax;
    property Inclusive: Boolean read FInclusive;
  end;

implementation

{ RangeAttribute }

constructor NumberRangeAttribute<T>.Create(const AMin, AMax: T; const AMessage: string; const AGroups: TGroupSet);
begin
  Create(AMin, AMax, True, EmptyStr, [DEFAULT_GROUP]);
end;

constructor NumberRangeAttribute<T>.Create(const AMin, AMax: T);
begin
  Create(AMin, AMax, True, EmptyStr, [DEFAULT_GROUP]);
end;

constructor NumberRangeAttribute<T>.Create(const AMin, AMax: T; const AMessage: string);
begin
  Create(AMin, AMax, True, AMessage, [DEFAULT_GROUP]);
end;

constructor NumberRangeAttribute<T>.Create(const AMin, AMax: T; const AGroups: TGroupSet);
begin
  Create(AMin, AMax, True, EmptyStr, AGroups);
end;

constructor NumberRangeAttribute<T>.Create(const AMin, AMax: T; const AInclusive: Boolean; const AMessage: string; const AGroups: TGroupSet);
begin
  FMin := AMin;
  FMax := AMax;
  FInclusive := AInclusive;
  FMessage := AMessage;
  FGroups := AGroups;
end;

constructor NumberRangeAttribute<T>.Create(const AMin, AMax: T; const AInclusive: Boolean);
begin

end;

constructor NumberRangeAttribute<T>.Create(const AMin, AMax: T;  const AInclusive: Boolean; const AMessage: string);
begin

end;

constructor NumberRangeAttribute<T>.Create(const AMin, AMax: T;  const AInclusive: Boolean; const AGroups: TGroupSet);
begin

end;

end.
