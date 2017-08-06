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
