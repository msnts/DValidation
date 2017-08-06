unit DValidation.Constraints.Email;

interface

uses
  DValidation.Constraints.Constraint;

type

  EmailAttribute = class(ConstraintAttribute)
  private
    FPattern: string;
  public
    constructor Create(const Parameters : string); override;
    property Pattern: string read FPattern;
  end;

implementation

{ TEmailAttribute }

constructor EmailAttribute.Create(const Parameters: string);
begin

  FMessage := 'Email Invalid';

  inherited;

  FPattern := GetParameter<string>('Pattern', '');

end;

end.
