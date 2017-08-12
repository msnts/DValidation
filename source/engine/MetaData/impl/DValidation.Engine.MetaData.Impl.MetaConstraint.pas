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

unit DValidation.Engine.MetaData.Impl.MetaConstraint;

interface
uses
  System.Rtti,
  System.TypInfo,
  System.Generics.Collections,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.Constraints.Constraint;

type

  TMetaConstraint = class(TInterfacedObject, IMetaConstraint)
  private
    FConstraint : ConstraintAttribute;
    FMember : TRttiMember;
    FGroups : TList<string>;
  public
    constructor Create(aConstraint : ConstraintAttribute; aMember : TRttiMember);
    destructor Destroy; override;
    function GetGroupList() : TList<string>;
    function GetConstraintType : PTypeInfo;
    function GetMember() : TRttiMember;
    function GetAttributes() : TDictionary<string, variant>;
    function GetMessageTemplate() : string;
  end;

implementation

{ TMetaConstraint }

constructor TMetaConstraint.Create(aConstraint: ConstraintAttribute;
  aMember: TRttiMember);
begin
  FConstraint := aConstraint;
  FMember := aMember;

  FGroups := TList<string>.Create;

  FGroups.AddRange(FConstraint.Groups);

end;

destructor TMetaConstraint.Destroy;
begin
  if Assigned(FGroups) then
    FGroups.Free;

  inherited;
end;

function TMetaConstraint.GetAttributes: TDictionary<string, variant>;
begin
  Result := FConstraint.Attributes;
end;

function TMetaConstraint.GetConstraintType: PTypeInfo;
begin
  Result := FConstraint.ClassInfo;
end;

function TMetaConstraint.GetGroupList: TList<string>;
begin
  Result := FGroups;
end;

function TMetaConstraint.GetMember: TRttiMember;
begin
  Result := FMember;
end;

function TMetaConstraint.GetMessageTemplate: string;
begin
  Result := FConstraint.Message;
end;

end.
