unit DValidation.ContraintValidators.AssertTrueValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.AssertTrue;

type

  TAssertTrueValidator = class(TInterfacedObject, IConstraintValidator<Boolean>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : Boolean) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TNotBlankValidator }

procedure TAssertTrueValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TAssertTrueValidator.IsValid(const Value: Boolean): Boolean;
begin

  Result := Value = True;

end;

initialization
  TDValidation.RegisterConstraint(AssertTrueAttribute, TAssertTrueValidator);
end.
