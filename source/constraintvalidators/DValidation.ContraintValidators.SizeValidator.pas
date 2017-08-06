unit DValidation.ContraintValidators.SizeValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Size,
  DValidation.Exceptions;

type

  TSizeValidator = class(TInterfacedObject, IConstraintValidator<string>)
  private
    FMin : Integer;
    FMax : Integer;

    procedure ValidateParameters();
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation
uses System.SysUtils;

{ TSizeValidator }

procedure TSizeValidator.Initialize(Constraint: ConstraintAttribute);
begin

  FMin := SizeAttribute(Constraint).Min;
  FMax := SizeAttribute(Constraint).Max;

  ValidateParameters;

end;

function TSizeValidator.IsValid(const Value: string): Boolean;
var
  StrSize : Integer;
begin

  StrSize := Value.Length;

  Result := ((StrSize >= FMin) and (StrSize <= FMax));

end;

procedure TSizeValidator.ValidateParameters;
begin

  if FMin < 0 then
    raise ValidationException.Create('The min parameter cannot be negative');

  if FMax < 0 then
    raise ValidationException.Create('The max parameter cannot be negative');

  if FMax < FMin then
    raise ValidationException.Create('Max cannot be less than Min');

end;

initialization
  TDValidation.RegisterConstraint(SizeAttribute, TSizeValidator);
end.
