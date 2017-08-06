unit DValidation.Constraints.Future;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  FutureAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor FutureAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Future_Message;

  inherited;

end;

end.
