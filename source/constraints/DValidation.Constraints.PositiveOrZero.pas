unit DValidation.Constraints.PositiveOrZero;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  PositiveOrZeroAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor PositiveOrZeroAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_PositiveOrZero_Message;

  inherited;

end;

end.
