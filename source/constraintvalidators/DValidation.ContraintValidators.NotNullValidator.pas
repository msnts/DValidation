unit DValidation.ContraintValidators.NotNullValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.NotNull;

type

  TNotNullValidator = class(TInterfacedObject, IConstraintValidator<TObject>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : TObject) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TNotBlankValidator }

procedure TNotNullValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TNotNullValidator.IsValid(const Value: TObject): Boolean;
begin

  Result := Value <> nil;

end;

initialization
  TDValidation.RegisterConstraint(NotNullAttribute, TNotNullValidator);
end.
