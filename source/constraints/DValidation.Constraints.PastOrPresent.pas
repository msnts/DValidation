unit DValidation.Constraints.PastOrPresent;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  PastOrPresentAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor PastOrPresentAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_PastOrPresent_Message;

  inherited;

end;

end.
