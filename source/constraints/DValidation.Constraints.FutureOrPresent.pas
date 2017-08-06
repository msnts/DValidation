unit DValidation.Constraints.FutureOrPresent;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  FutureOrPresentAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor FutureOrPresentAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_FutureOrPresent_Message;

  inherited;

end;

end.
