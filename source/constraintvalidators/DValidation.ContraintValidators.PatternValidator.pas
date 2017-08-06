unit DValidation.ContraintValidators.PatternValidator;

interface
uses
  DValidation,
  DValidation.ContraintValidators.ConstraintValidator,
  DValidation.Constraints.Constraint,
  DValidation.Constraints.Pattern,
  System.RegularExpressions;

type

  TPatternValidator = class(TInterfacedObject, IConstraintValidator<string>)
  private
    FRegEx: TRegEx;
  public
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : string) : Boolean;
  end;

implementation

{ TPatternValidator }

procedure TPatternValidator.Initialize(Constraint: ConstraintAttribute);
begin

  try
    FRegEx := TRegex.Create(PatternAttribute(Constraint).Regexp);
  except

  end;

end;

function TPatternValidator.IsValid(const Value: string): Boolean;
begin

  Result := FRegEx.Match(Value).Success;

end;

initialization
  TDValidation.RegisterConstraint(PatternAttribute, TPatternValidator);
end.
