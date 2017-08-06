unit DValidation.Engine.ValueContext;

interface
uses
  System.TypInfo,
  System.Rtti,
  DValidation.Engine.MetaData.ObjectMetaData;

type

  IValueContext<T> = interface
    ['{0FE2E542-53E4-4D82-9B37-A16830E6FA7F}']
    function GetCurrentGroup(): string;
    procedure SetCurrentGroup(const Group : string);
    function GetCurrentObjectType() : PTypeInfo;
    function GetCurrentObjectMetaData() : IObjectMetaData;
    function GetCurrentObject() : T;
    function GetCurrentValidatedValue() : Variant;
    procedure SetMember(aMember : TRttiMember);
  end;

implementation

end.
