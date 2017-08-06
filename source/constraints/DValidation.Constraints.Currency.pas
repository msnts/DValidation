unit DValidation.Constraints.Currency;

interface
uses
  DValidation.Constraints.Constraint,
  DValidation.I18n.Messages;

type

  CurrencyAttribute = class(ConstraintAttribute)
  public
    constructor Create(const Parameters : string); override;
  end;

implementation

{ NotBlankAttribute }

constructor CurrencyAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Currency_Message;

  inherited;

end;

end.
