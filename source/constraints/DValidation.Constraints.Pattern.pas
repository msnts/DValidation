unit DValidation.Constraints.Pattern;

interface
uses
  DValidation.I18n.Messages,
  DValidation.Constraints.Constraint;

type

  PatternAttribute = class(ConstraintAttribute)
  private
    FRegexp : string;
    FFlags : string;
  public
    constructor Create(const Parameters : string); override;
    property Regexp : string read FRegexp;
    property Flags : string read FFlags;
  end;

implementation

{ NotBlankAttribute }

constructor PatternAttribute.Create(const Parameters: string);
begin

  FMessage := Constraint_Pattern_Message;

  inherited;

  FRegexp := GetParameter<string>('Regexp', '');
  FFlags := GetParameter<string>('Flags', '');

end;

end.
