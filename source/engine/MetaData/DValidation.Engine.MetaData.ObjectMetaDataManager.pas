unit DValidation.Engine.MetaData.ObjectMetaDataManager;

interface
uses
  System.TypInfo,
  DValidation.Engine.MetaData.ObjectMetaData;

type

  IObjectMetaDataManager = interface
    ['{5A9D462C-C480-4AC2-9C28-0EF1AE65A404}']
    function GetObjectMetaData(aClass : TClass) : IObjectMetaData; overload;
    function GetObjectMetaData(aType : PTypeInfo) : IObjectMetaData; overload;
  end;

implementation

end.
