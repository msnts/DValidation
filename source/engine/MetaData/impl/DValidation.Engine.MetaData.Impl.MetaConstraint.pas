unit DValidation.Engine.MetaData.Impl.MetaConstraint;

interface
uses
  System.Rtti,
  System.TypInfo,
  System.Generics.Collections,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.Constraints.Constraint;

type

  TMetaConstraint = class(TInterfacedObject, IMetaConstraint)
  private
    FConstraint : ConstraintAttribute;
    FMember : TRttiMember;
    FGroups : TList<string>;
  public
    constructor Create(aConstraint : ConstraintAttribute; aMember : TRttiMember);
    destructor Destroy; override;
    function GetGroupList() : TList<string>;
    function GetConstraintType : PTypeInfo;
    function GetMember() : TRttiMember;
  end;

implementation

{ TMetaConstraint }

constructor TMetaConstraint.Create(aConstraint: ConstraintAttribute;
  aMember: TRttiMember);
begin
  FConstraint := aConstraint;
  FMember := aMember;

  FGroups := TList<string>.Create;

  FGroups.AddRange(FConstraint.Groups);

end;

destructor TMetaConstraint.Destroy;
begin
  if Assigned(FGroups) then
    FGroups.Free;

  inherited;
end;

function TMetaConstraint.GetConstraintType: PTypeInfo;
begin
  Result := FConstraint.ClassInfo;
end;

function TMetaConstraint.GetGroupList: TList<string>;
begin
  Result := FGroups;
end;

function TMetaConstraint.GetMember: TRttiMember;
begin
  Result := FMember;
end;

end.
