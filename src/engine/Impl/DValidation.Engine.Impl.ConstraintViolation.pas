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

unit DValidation.Engine.Impl.ConstraintViolation;

interface
uses
  System.Rtti,
  DValidation.Engine.ConstraintViolation;

type

  TConstraintViolation<T> = class(TInterfacedObject, IConstraintViolation<T>)
  private
    FMessage : string;
    FRootObject : T;
    FValue : TValue;
  public
    constructor Create(const aMessage : string; aRootObject : T; Value : TValue);
    destructor Destroy(); override;
    function GetMessage() : string;
    function GetRootObject() : T;
    function GetInvalidValue() : TValue;
  end;

implementation

{ TConstraintViolation<T> }

constructor TConstraintViolation<T>.Create(const aMessage: string;
  aRootObject: T; Value: TValue);
begin
  FMessage := aMessage;
  FRootObject := aRootObject;
  FValue := Value;
end;

destructor TConstraintViolation<T>.Destroy;
begin

  inherited;
end;

function TConstraintViolation<T>.GetInvalidValue: TValue;
begin
  Result := FValue;
end;

function TConstraintViolation<T>.GetMessage: string;
begin
  Result := FMessage;
end;

function TConstraintViolation<T>.GetRootObject: T;
begin
  Result := FRootObject;
end;

end.
