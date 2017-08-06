unit DValidation.ContraintValidators.NotBlankValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.NotBlank;

type

  TNotBlankValidator = class(TInterfacedObject, IConstraintValidator<string>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TNotBlankValidator }

procedure TNotBlankValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TNotBlankValidator.IsValid(const Value: string): Boolean;
begin

  Result := not Value.Trim.IsEmpty;

end;

initialization
  TDValidation.RegisterConstraint(NotBlankAttribute, TNotBlankValidator);
end.
