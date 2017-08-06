unit DValidation.Constraints.Br.TituloEleitor;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  TituloEleitorAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor TituloEleitorAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_TituloEleitor_Message;

  inherited;

end;

end.
