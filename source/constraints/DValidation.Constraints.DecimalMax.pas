unit DValidation.Constraints.DecimalMax;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  DecimalMaxAttribute = class(ConstraintAttribute)
  private
    FMax : Double;
    FInclusive : Boolean;
  public
    constructor Create(const Parameters : string); override;
    property Max : Double read FMax;
    property Inclusive : Boolean read FInclusive;
  end;

implementation
uses System.Math;

{ NotBlankAttribute }

constructor DecimalMaxAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_DecimalMax_Message;

  inherited;

  FMax := GetParameter<Double>('Max', MaxDouble);

  FInclusive := GetParameter<Boolean>('Inclusive', True);

end;

end.
