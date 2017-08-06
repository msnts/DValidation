unit DValidation.Constraints.EAN;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  TEAN = (EAN13, EAN8);

  EANAttribute = class(ConstraintAttribute)
  private
    FType : TEAN;
  public
    constructor Create(const Parameters : string); override;
    property &Type : TEAN read FType;
  end;

implementation

{ NotBlankAttribute }

constructor EANAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_NotBlank_Message;

  inherited;

  FType := GetParameter<TEAN>('Type', EAN13);
end;

end.
