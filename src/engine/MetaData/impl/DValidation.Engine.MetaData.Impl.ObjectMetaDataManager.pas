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

unit DValidation.Engine.MetaData.Impl.ObjectMetaDataManager;

interface
uses
  System.TypInfo,
  System.Generics.Collections,
  DValidation.Engine.MetaData.ObjectMetaData,
  DValidation.Engine.MetaData.ObjectMetaDataManager,
  DValidation.Engine.MetaData.Impl.ObjectMetaData;

type

  TObjectMetaDataManager = class(TInterfacedObject, IObjectMetaDataManager)
  private
    FObjectsMetaData : TDictionary<PTypeInfo, IObjectMetaData>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetObjectMetaData(aClass : TClass) : IObjectMetaData; overload;
    function GetObjectMetaData(aType : PTypeInfo) : IObjectMetaData; overload;
  end;

implementation

{ TObjectMetaDataManager }

constructor TObjectMetaDataManager.Create;
begin
   FObjectsMetaData := TDictionary<PTypeInfo, IObjectMetaData>.Create;
end;

destructor TObjectMetaDataManager.Destroy;
begin

  if Assigned(FObjectsMetaData) then
    FObjectsMetaData.Free;

  inherited;
end;

function TObjectMetaDataManager.GetObjectMetaData(
  aClass: TClass): IObjectMetaData;
begin

end;

function TObjectMetaDataManager.GetObjectMetaData(
  aType: PTypeInfo): IObjectMetaData;
begin

  if FObjectsMetaData.TryGetValue(aType, Result) then
    Exit;

   Result := TObjectMetaData.Create(aType);

   FObjectsMetaData.Add(aType, Result);

end;

end.
