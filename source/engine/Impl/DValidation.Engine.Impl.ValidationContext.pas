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

unit DValidation.Engine.Impl.ValidationContext;

interface
uses
  DValidation.Engine.ValidationContext,
  System.Generics.Collections,
  DValidation.Engine.ConstraintViolation,
  DValidation.Engine.Impl.ConstraintViolation,
  DValidation.Engine.MetaData.ObjectMetaData,
  DValidation.Engine.MetaData.ObjectMetaDataManager,
  DValidation.Engine.ValueContext,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.ConstraintValidators.ConstraintValidator,
  DValidation.Engine.MessageInterpolator;

type
  TValidationContext<T> = class(TInterfacedObject, IValidationContext<T>)
  private
    FRootObject : T;
    FRootObjectMetaData : IObjectMetaData;
    FObjectMetaDataManager : IObjectMetaDataManager;
    FMessageInterpolator : IMessageInterpolator;
    FConstraintVioliations : TList<IConstraintViolation<T>>;
    FFailFast : Boolean;
  public
    constructor Create(ObjectMetaDataManager : IObjectMetaDataManager; MessageInterpolator : IMessageInterpolator; RootObject : T);
    destructor Destroy; override;
    function GetRootObjectMetaData() : IObjectMetaData;
    function GetCurrentObjectType() : TClass;
    procedure MarkCurrentBeanAsProcessed(ValueContext : IValueContext<T>);
    procedure MarkConstraintProcessed();
    function GetFailingConstraints() : TList<IConstraintViolation<T>>;
    procedure AddConstraintViolation(ValueContext : IValueContext<T>; MetaContraint : IMetaConstraint);
    function IsFailFastModeEnabled() : Boolean;
    function HasFailingConstraints() : Boolean;
  end;

implementation

{ TValidationContext<T> }

procedure TValidationContext<T>.AddConstraintViolation(ValueContext : IValueContext<T>; MetaContraint : IMetaConstraint);
var
  ConstraintViolation : IConstraintViolation<T>;
  InterpolatedMessage : string;
begin

  InterpolatedMessage := FMessageInterpolator.Interpolate(MetaContraint.GetMessageTemplate, MetaContraint.GetAttributes);

  ConstraintViolation := TConstraintViolation<T>.Create(InterpolatedMessage, FRootObject, ValueContext.GetCurrentValidatedValue);

  FConstraintVioliations.Add(ConstraintViolation);

end;

constructor TValidationContext<T>.Create(
  ObjectMetaDataManager: IObjectMetaDataManager; MessageInterpolator : IMessageInterpolator; RootObject : T);
begin

  FRootObject := RootObject;

  FRootObjectMetaData := ObjectMetaDataManager.GetObjectMetaData(TypeInfo(T));

  FObjectMetaDataManager := ObjectMetaDataManager;

  FMessageInterpolator := MessageInterpolator;

  FFailFast := False;

  FConstraintVioliations := TList<IConstraintViolation<T>>.Create;

end;

destructor TValidationContext<T>.Destroy;
begin

  if Assigned(FConstraintVioliations) then
   // FConstraintVioliations.Free;

  inherited;
end;

function TValidationContext<T>.GetCurrentObjectType: TClass;
begin

end;

function TValidationContext<T>.GetFailingConstraints: TList<IConstraintViolation<T>>;
begin
  Result := FConstraintVioliations;
end;

function TValidationContext<T>.GetRootObjectMetaData: IObjectMetaData;
begin
  Result := FRootObjectMetaData;
end;

function TValidationContext<T>.HasFailingConstraints: Boolean;
begin
  Result := FConstraintVioliations.Count > 0;
end;

function TValidationContext<T>.IsFailFastModeEnabled: Boolean;
begin
  Result := FFailFast;
end;

procedure TValidationContext<T>.MarkConstraintProcessed;
begin

end;

procedure TValidationContext<T>.MarkCurrentBeanAsProcessed(
  ValueContext: IValueContext<T>);
begin

end;

end.
