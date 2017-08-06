unit DValidation.Constraints.Past;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  PastAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor PastAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Past_Message;

  inherited;

end;

end.
