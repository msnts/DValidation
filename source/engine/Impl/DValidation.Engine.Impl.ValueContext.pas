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
    FCurrentValidateValue : Variant;
    FCurrentMember : TRttiMember;
  public
    constructor Create(CurrentObject : T; CurrentObjectMetaData : IObjectMetaData);
    function GetCurrentGroup(): string;
    procedure SetCurrentGroup(const Group : string);
    function GetCurrentObjectType() : PTypeInfo;
    function GetCurrentObjectMetaData() : IObjectMetaData;
    function GetCurrentObject() : T;
    function GetCurrentValidatedValue() : Variant;
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

function TValueContext<T>.GetCurrentValidatedValue: Variant;
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
    FCurrentValidateValue := TRttiField(FCurrentMember).GetValue(TObject(FCurrentObject)).AsVariant;
    Exit;
  end;

  if FCurrentMember is TRttiProperty then
    FCurrentValidateValue := TRttiProperty(FCurrentMember).GetValue(TObject(FCurrentObject)).AsVariant;

end;

end.
