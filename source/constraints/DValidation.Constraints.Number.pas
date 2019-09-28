unit DValidation.Constraints.Number;

interface
uses
  System.SysUtils,
  DValidation.Constraints.Constraint;

type
  TNumberAttribute<T> = class abstract(ConstraintAttribute<T>)
  protected
    FInclusive: Boolean;
  public
    constructor Create(const AValue: T); overload;
    constructor Create(const AValue: T; const AInclusive: Boolean); overload;
    constructor Create(const AValue: T; const AMessage: string); overload;
    constructor Create(const AValue: T; const AGroups: TGroupSet); overload;
    constructor Create(const AValue: T; const AInclusive: Boolean; const AMessage: string); overload;
    constructor Create(const AValue: T; const AInclusive: Boolean; const AGroups: TGroupSet); overload;
    constructor Create(const AValue: T; const AInclusive: Boolean; const AMessage: string; const AGroups: TGroupSet); overload;
    property Inclusive: Boolean read FInclusive;
  end;

implementation

{ TNumberAttribute<T> }

constructor TNumberAttribute<T>.Create(const AValue: T; const AMessage: string);
begin
  Create(AValue, True, AMessage, [DEFAULT_GROUP]);
end;

constructor TNumberAttribute<T>.Create(const AValue: T; const AInclusive: Boolean);
begin
  Create(AValue, AInclusive, EmptyStr, [DEFAULT_GROUP]);
end;

constructor TNumberAttribute<T>.Create(const AValue: T);
begin
  Create(AValue, True, EmptyStr, [DEFAULT_GROUP]);
end;

constructor TNumberAttribute<T>.Create(const AValue: T; const AGroups: TGroupSet);
begin
  Create(AValue, True, EmptyStr, AGroups);
end;

constructor TNumberAttribute<T>.Create(const AValue: T; const AInclusive: Boolean; const AMessage: string; const AGroups: TGroupSet);
begin
  FValue := AValue;
  FInclusive := AInclusive;
  FMessage := AMessage;
  FGroups := AGroups;
end;

constructor TNumberAttribute<T>.Create(const AValue: T; const AInclusive: Boolean; const AGroups: TGroupSet);
begin
  Create(AValue, AInclusive, EmptyStr, AGroups);
end;

constructor TNumberAttribute<T>.Create(const AValue: T; const AInclusive: Boolean; const AMessage: string);
begin
   Create(AValue, AInclusive, AMessage, [DEFAULT_GROUP]);
end;

end.
