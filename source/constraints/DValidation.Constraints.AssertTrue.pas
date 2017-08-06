unit DValidation.Constraints.AssertTrue;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  AssertTrueAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor AssertTrueAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_AssertTrue_Message;

  inherited;

end;

end.
