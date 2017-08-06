unit DValidation.Constraints.Size;

interface
uses
  DValidation.Constraints.Constraint;

type

  SizeAttribute = class(ConstraintAttribute)
  private
    FMin : Integer;
    FMax : Integer;
  public
    constructor Create(const Parameters : string); override;
    property Min : Integer read FMin;
    property Max : Integer read FMax;
  end;

implementation

{ SizeAttribute }

constructor SizeAttribute.Create(const Parameters: string);
begin

  FMessage := '';

  inherited;

  FMin := GetParameter<Integer>('Min', 0);
  FMax := GetParameter<Integer>('Max', MaxInt);

end;

end.
