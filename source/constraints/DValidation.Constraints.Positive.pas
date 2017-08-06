unit DValidation.Constraints.Positive;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  PositiveAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor PositiveAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Positive_Message;

  inherited;

end;

end.
