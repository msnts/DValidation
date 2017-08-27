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

unit DValidation.Engine.Impl.ValueContext;

interface
uses
  System.TypInfo,
  System.Rtti,
  DValidation.Engine.ValueContext,
  DValidation.Engine.MetaData.ObjectMetaData;

type
  TValueContext<T : class> = class(TInterfacedObject, IValueContext<T>)
  private
    FCurrentObjectType : PTypeInfo;
    FCurrentObject : T;
    FCurrentObjectMetaData : IObjectMetaData;
    FCurrentGroup : string;
    FCurrentValidateValue : TValue;
    FCurrentMember : TRttiMember;
  public
    constructor Create(CurrentObject : T; CurrentObjectMetaData : IObjectMetaData);
    function GetCurrentGroup(): string;
    procedure SetCurrentGroup(const Group : string);
    function GetCurrentObjectType() : PTypeInfo;
    function GetCurrentObjectMetaData() : IObjectMetaData;
    function GetCurrentObject() : T;
    function GetCurrentValidatedValue() : TValue;
    procedure SetMember(aMember : TRttiMember);
  end;

implementation

{ TValueContext<T> }

constructor TValueContext<T>.Create(CurrentObject: T;
  CurrentObjectMetaData: IObjectMetaData);
begin
  FCurrentObjectType := TypeInfo(T);
  FCurrentObject := CurrentObject;
  FCurrentObjectMetaData := CurrentObjectMetaData;
end;

function TValueContext<T>.GetCurrentObject: T;
begin
  Result := FCurrentObject;
end;

function TValueContext<T>.GetCurrentObjectMetaData: IObjectMetaData;
begin
  Result := FCurrentObjectMetaData;
end;

function TValueContext<T>.GetCurrentGroup: string;
begin
  Result := FCurrentGroup;
end;

function TValueContext<T>.GetCurrentObjectType: PTypeInfo;
begin
  Result := FCurrentObjectType;
end;

function TValueContext<T>.GetCurrentValidatedValue: TValue;
begin
  Result := FCurrentValidateValue;
end;

procedure TValueContext<T>.SetCurrentGroup(const Group: string);
begin
  FCurrentGroup := Group;
end;

procedure TValueContext<T>.SetMember(aMember: TRttiMember);
begin

  FCurrentMember := aMember;

  if FCurrentMember is TRttiField then
  begin
    FCurrentValidateValue := TRttiField(FCurrentMember).GetValue(TObject(FCurrentObject));
    Exit;
  end;

  if FCurrentMember is TRttiProperty then
    FCurrentValidateValue := TRttiProperty(FCurrentMember).GetValue(TObject(FCurrentObject));

end;

end.
