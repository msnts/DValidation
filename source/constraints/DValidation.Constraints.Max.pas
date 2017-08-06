unit DValidation.Constraints.Max;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  MaxAttribute = class(ConstraintAttribute)
  private
    FMax : Integer;
  public
    constructor Create(const Parameters : string); override;
    property Max : Integer read FMax;
  end;

implementation

{ NotBlankAttribute }

constructor MaxAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Max_Message;

  inherited;

  FMax := GetParameter<Integer>('Max', MaxInt);

end;

end.
