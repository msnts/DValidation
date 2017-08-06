unit DValidation.Constraints.Br.CNPJ;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  CNPJAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor CNPJAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_CNPJ_Message;

  inherited;

end;

end.
