unit DValidation.Constraints.CreditCardNumber;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  CreditCardNumberAttribute = class(ConstraintAttribute)
  private
    FIgnoreNonDigitCharacters : Boolean;
  public
    constructor Create(const Parameters : string); override;
    property IgnoreNonDigitCharacters : Boolean read FIgnoreNonDigitCharacters;
  end;

implementation

{ NotBlankAttribute }

constructor CreditCardNumberAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_CreditCardNumber_Message;

  inherited;

  FIgnoreNonDigitCharacters := GetParameter<Boolean>('IgnoreNonDigitCharacters', False);

end;

end.
