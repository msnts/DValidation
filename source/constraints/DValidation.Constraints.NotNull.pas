unit DValidation.Constraints.NotNull;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  NotNullAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotNullAttribute }

constructor NotNullAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_NotNull_Message;

  inherited;

end;

end.
