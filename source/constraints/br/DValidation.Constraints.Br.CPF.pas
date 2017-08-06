unit DValidation.Constraints.Br.CPF;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  CPFAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor CPFAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_CPF_Message;

  inherited;

end;

end.
