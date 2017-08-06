unit DValidation.Engine.MetaData.MetaConstraint;

interface
uses
  System.Generics.Collections,
  System.TypInfo,
  System.Rtti;

type

  IMetaConstraint = interface
    ['{5592C0D5-1B22-4496-893F-4B28FAE8D337}']
    function GetGroupList() : TList<string>;
    function GetConstraintType() : PTypeInfo;
    function GetMember() : TRttiMember;
  end;

implementation

end.
