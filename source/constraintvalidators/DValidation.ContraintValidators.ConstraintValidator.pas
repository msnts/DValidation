unit DValidation.ContraintValidators.ConstraintValidator;

interface
uses
  DValidation.Constraints.Constraint;

type

  IConstraintValidator<T>  = interface
    ['{945CF11F-B978-436D-AD37-76CBD71BD58E}']
    procedure Initialize(Constraint : ConstraintAttribute);
    function IsValid(const Value : T) : Boolean;
  end;


implementation

end.
