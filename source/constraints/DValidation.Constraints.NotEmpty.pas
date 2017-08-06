unit DValidation.Constraints.NotEmpty;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  NotEmptyAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor NotEmptyAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_NotEmpty_Message;

  inherited;

end;

end.
