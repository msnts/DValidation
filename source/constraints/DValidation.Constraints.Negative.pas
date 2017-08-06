unit DValidation.Constraints.Negative;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  NegativeAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor NegativeAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Negative_Message;

  inherited;

end;

end.
