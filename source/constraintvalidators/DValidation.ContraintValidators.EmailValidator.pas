unit DValidation.ContraintValidators.EmailValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Email;

type

  TEmailValidator = class(TInterfacedObject, IConstraintValidator<string>)
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation
uses System.RegularExpressions;

{ TEmailValidator }

procedure TEmailValidator.Initialize(Constraint: ConstraintAttribute);
begin

end;

function TEmailValidator.IsValid(const Value: string): Boolean;
var
  RegEx: TRegEx;
begin

  RegEx := TRegex.Create('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]*[a-zA-Z0-9]+$');

  Result := RegEx.Match(Value).Success;

end;

initialization
  TDValidation.RegisterConstraint(EmailAttribute, TEmailValidator);
end.
