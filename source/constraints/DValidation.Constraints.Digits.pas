unit DValidation.Constraints.Digits;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  DigitsAttribute = class(ConstraintAttribute)
  private
    FInteger : Integer;
    FFraction : Integer;
  public
    constructor Create(const Parameters : string); override;
    property &Integer : Integer read FInteger;
    property Fraction : Integer read FFraction;
  end;

implementation

{ NotBlankAttribute }

constructor DigitsAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Digits_Message;

  inherited;

  FInteger := GetParameter<System.Integer>('Integer', -1);
  FFraction := GetParameter<System.Integer>('Fraction', -1);

end;

end.
