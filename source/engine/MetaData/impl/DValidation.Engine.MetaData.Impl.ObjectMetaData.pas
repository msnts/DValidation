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

unit DValidation.Engine.MetaData.Impl.ObjectMetaData;

interface
uses
  System.TypInfo,
  System.Rtti,
  System.Generics.Collections,
  System.SysUtils,
  DValidation.Engine.MetaData.ObjectMetaData,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.Engine.MetaData.Impl.MetaConstraint,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Valid,
  DValidation.Engine.MetaData.RttiHelper;

type
  TObjectMetaData = class(TInterfacedObject, IObjectMetaData)
  private
    FMetaConstraints : TList<IMetaConstraint>;
    function ExtractMetaConstraint(aType : PTypeInfo) : TList<IMetaConstraint>;
  public
    constructor Create(aType : PTypeInfo);
    destructor Destroy; override;
    function HasConstraints() : Boolean;
    function GetClassHierarchy() : TArray<TClass>;
    function GetMetaConstraints() : TArray<IMetaConstraint>;
  end;


implementation

{ TObjectMetaData }

constructor TObjectMetaData.Create(aType: PTypeInfo);
begin
   FMetaConstraints := ExtractMetaConstraint(aType);
end;

destructor TObjectMetaData.Destroy;
begin

  if Assigned(FMetaConstraints) then
    FMetaConstraints.Free;

  inherited;
end;

function TObjectMetaData.ExtractMetaConstraint(aType: PTypeInfo): TList<IMetaConstraint>;
var
  ctxRtti: TRttiContext;
  typRtti: TRttiType;
  fldRtti: TRttiField;
  propRtti : TRttiProperty;
  metRtti : TRttiMethod;
  attribute : TCustomAttribute;
  MetaConstraint : IMetaConstraint;
  MetaConstraintsGraph : TList<IMetaConstraint>;
begin

  Result := TList<IMetaConstraint>.Create;

  ctxRtti := TRttiContext.Create;

  try

    typRtti := ctxRtti.GetType(aType);

    for fldRtti in typRtti.GetFields do
    begin

      if fldRtti.Name.Equals('FRefCount') then
        continue;

      for attribute in fldRtti.GetAttributes do
      begin

        MetaConstraintsGraph := nil;

        if Attribute is ValidAttribute then
        begin

          if fldRtti.FieldType.IsGenericType then
          begin

          end
          else
            MetaConstraintsGraph := ExtractMetaConstraint(fldRtti.FieldType.Handle);

        end;

        MetaConstraint := TMetaConstraint.Create(ConstraintAttribute(attribute), fldRtti, MetaConstraintsGraph);
        Result.Add(MetaConstraint);

      end;

    end;

    for propRtti in typRtti.GetProperties do
    begin

      MetaConstraintsGraph := nil;

      for attribute in propRtti.GetAttributes do
      begin
        MetaConstraint := TMetaConstraint.Create(ConstraintAttribute(attribute), propRtti, MetaConstraintsGraph);
        Result.Add(MetaConstraint);
      end;
    end;

  finally
    ctxRtti.Free;
  end;

end;

function TObjectMetaData.GetClassHierarchy: TArray<TClass>;
begin

end;

function TObjectMetaData.GetMetaConstraints: TArray<IMetaConstraint>;
begin
  Result := FMetaConstraints.ToArray;
end;

function TObjectMetaData.HasConstraints: Boolean;
begin
  Result := FMetaConstraints.Count > 0;
end;

end.
