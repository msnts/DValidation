unit DValidation.Engine.MetaData.ObjectMetaData;

interface
uses
  DValidation.Engine.MetaData.MetaConstraint;

type

  IObjectMetaData  = interface
    ['{00A88A21-A884-4999-9473-D2220C6F7DEA}']
    function HasConstraints() : Boolean;
    function GetClassHierarchy() : TArray<TClass>;
    function GetMetaConstraints() : TArray<IMetaConstraint>;
  end;

implementation

end.
