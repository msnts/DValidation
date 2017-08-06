unit DValidation.ContraintValidators.AssertFalseValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.AssertFalse;

type

  TAssertFalseValidator = class(TInterfacedObject, IConstraintValidator<Boolean>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : Boolean) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TNotBlankValidator }

procedure TAssertFalseValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TAssertFalseValidator.IsValid(const Value: Boolean): Boolean;
begin

  Result := Value = False;

end;

initialization
  TDValidation.RegisterConstraint(AssertFalseAttribute, TAssertFalseValidator);
end.
