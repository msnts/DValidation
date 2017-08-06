unit DValidation.Constraints.Range;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  RangeAttribute = class(ConstraintAttribute)
  private
    FMin : Integer;
    FMax : Integer;
  public
    constructor Create(const Parameters : string); override;
    property Min : Integer read FMin;
    property Max : Integer read FMax;
  end;

implementation

{ NotBlankAttribute }

constructor RangeAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Range_Message;

  inherited;

  FMin := GetParameter<Integer>('Min', 0);
  FMax := GetParameter<Integer>('Max', MaxInt);

end;

end.
