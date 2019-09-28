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

unit DValidation.Constraints.Constraint;

interface
uses
  System.SysUtils,
  System.Generics.Collections;

const
  DEFAULT_GROUP = 0;

type

  TGroupSet = set of Byte;

  ConstraintAttribute = class(TCustomAttribute)
  protected
    FMessage : string;
    FGroups : TGroupSet;
    FAttributes : TDictionary<string, variant>;
    function GetMessage: string; virtual; abstract;
  public
    destructor Destroy; override;
    property Groups : TGroupSet read FGroups;
    property &Message: string read GetMessage;
    property Attributes : TDictionary<string, variant> read FAttributes;
  end;

  SimpleConstraintAttribute = class abstract(ConstraintAttribute)
  public
    constructor Create(); overload;
    constructor Create(const AMessage : string); overload;
    constructor Create(const AGroups: TGroupSet); overload;
    constructor Create(const AMessage: string; const AGroups: TGroupSet); overload;
  end;

  ConstraintAttribute<T> = class(ConstraintAttribute)
  protected
    FValue: T;
  public
    constructor Create(const AValue: T; const AGroups: TGroupSet); overload;
    constructor Create(const AValue: T; const AMessage: string; const AGroups: TGroupSet); overload;
    property Value: T read FValue;
  end;

implementation

{ TConstraintAttribute }

destructor ConstraintAttribute.Destroy;
begin
  if Assigned(FAttributes) then
    FAttributes.Free;

  inherited;
end;

{ ConstraintAttribute<T> }

constructor ConstraintAttribute<T>.Create(const AValue: T; const AMessage: string; const AGroups: TGroupSet);
begin
  FValue := AValue;
  FMessage := AMessage;
  FGroups := AGroups;
end;

constructor ConstraintAttribute<T>.Create(const AValue: T; const AGroups: TGroupSet);
begin
  Create(AValue, EmptyStr, AGroups);
end;

{ SimpleConstraintAttribute }

constructor SimpleConstraintAttribute.Create(const AMessage: string);
begin
  Create(AMessage, [DEFAULT_GROUP]);
end;

constructor SimpleConstraintAttribute.Create(const AGroups: TGroupSet);
begin
  Create(EmptyStr, AGroups);
end;

constructor SimpleConstraintAttribute.Create(const AMessage: string; const AGroups: TGroupSet);
begin
  FMessage := AMessage;
  FGroups := AGroups;
end;

constructor SimpleConstraintAttribute.Create;
begin
  Create(EmptyStr, [DEFAULT_GROUP]);
end;

end.
