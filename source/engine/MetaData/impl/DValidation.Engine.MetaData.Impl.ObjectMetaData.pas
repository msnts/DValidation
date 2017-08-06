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
  DValidation.Constraints.Constraint;

type
  TObjectMetaData = class(TInterfacedObject, IObjectMetaData)
  private
    FMetaConstraints : TList<IMetaConstraint>;
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
var
  ctxRtti: TRttiContext;
  typRtti: TRttiType;
  fldRtti: TRttiField;
  propRtti : TRttiProperty;
  metRtti : TRttiMethod;
  attribute : TCustomAttribute;
  MetaConstraint : IMetaConstraint;
begin
  FMetaConstraints := TList<IMetaConstraint>.Create;

  ctxRtti := TRttiContext.Create;

  try

    typRtti := ctxRtti.GetType(aType);

    for fldRtti in typRtti.GetFields do
    begin

      if fldRtti.Name.Equals('FRefCount') then
        continue;

      for attribute in fldRtti.GetAttributes do
      begin
        MetaConstraint := TMetaConstraint.Create(ConstraintAttribute(attribute), fldRtti);
        FMetaConstraints.Add(MetaConstraint);
      end;

    end;

    for propRtti in typRtti.GetProperties do
    begin
      for attribute in propRtti.GetAttributes do
      begin
        MetaConstraint := TMetaConstraint.Create(ConstraintAttribute(attribute), propRtti);
        FMetaConstraints.Add(MetaConstraint);
      end;
    end;

    for metRtti in typRtti.GetMethods do
    begin
      for attribute in metRtti.GetAttributes do
      begin
        MetaConstraint := TMetaConstraint.Create(ConstraintAttribute(attribute), metRtti);
        FMetaConstraints.Add(MetaConstraint);
      end;
    end;

  finally
    ctxRtti.Free;
  end;
end;

destructor TObjectMetaData.Destroy;
begin

  if Assigned(FMetaConstraints) then
    FMetaConstraints.Free;

  inherited;
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
