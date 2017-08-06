unit DValidation.Constraints.NotBlank;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  NotBlankAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor NotBlankAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_NotBlank_Message;

  inherited;

end;

end.
