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

unit DValidation.I18n.Impl.Locale;

interface
uses
  System.Classes,
  DValidation.I18n.Locale,
  DValidation.Exceptions;

type

  TLocale = class(TInterfacedObject, ILocale)
  private
    FViolationMessages : TStringList;

    procedure LoadViolationMessages();
  public
    constructor Create();
    destructor Destroy; override;
    function GetViolationMessage(const Identifier : string) : string;
  end;

implementation

{ TLocale }

constructor TLocale.Create();
begin

  FViolationMessages := TStringList.Create;

  LoadViolationMessages;

end;

destructor TLocale.Destroy;
begin
  FViolationMessages.Free;
  inherited;
end;

function TLocale.GetViolationMessage(const Identifier: string): string;
begin

  if FViolationMessages.IndexOfName(Identifier) = -1 then
    raise LocaleException.Create('Validation Message Not Found');

  Result := FViolationMessages.Values[Identifier];

end;

procedure TLocale.LoadViolationMessages;
var
  TmpStream: TResourceStream;
begin

  TmpStream := TResourceStream.Create(HInstance, 'ValidationMessages', 'TXTFILE');

  try
    FViolationMessages.LoadFromStream(TmpStream);
  finally
    TmpStream.Free;
  end;

end;

end.
