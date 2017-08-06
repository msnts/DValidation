unit DValidation.Constraints.DecimalMin;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  DecimalMinAttribute = class(ConstraintAttribute)
  private
    FMin : Double;
    FInclusive : Boolean;
  public
    constructor Create(const Parameters : string); override;
    property Min : Double read FMin;
    property Inclusive : Boolean read FInclusive;
  end;

implementation

{ NotBlankAttribute }

constructor DecimalMinAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_DecimalMin_Message;

  inherited;

  FMin := GetParameter<Double>('Min', 0.0);
  FInclusive := Getparameter<Boolean>('Inclusive', True);

end;

end.
