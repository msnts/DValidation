unit DValidation.Constraints.Min;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  MinAttribute = class(ConstraintAttribute)
  private
    FMin : Integer;
  public
    constructor Create(const Parameters : string); override;
    property Min : Integer read FMin;
  end;

implementation

{ NotBlankAttribute }

constructor MinAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Min_Message;

  inherited;

  FMin := GetParameter<Integer>('Min', 0);

end;

end.
