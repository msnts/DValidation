unit DValidation.Constraints.NegativeOrZero;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  NegativeOrZeroAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor NegativeOrZeroAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_NegativeOrZero_Message;

  inherited;

end;

end.
