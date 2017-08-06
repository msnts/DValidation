unit DValidation.Constraints.AssertFalse;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  AssertFalseAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor AssertFalseAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_AssertFalse_Message;

  inherited;

end;

end.
