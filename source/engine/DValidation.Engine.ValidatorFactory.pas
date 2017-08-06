unit DValidation.Engine.ValidatorFactory;

interface
uses
  DValidation.Engine.Validator,
  DValidation.Engine.ConstraintValidatorFactory;

type

  IValidatorFactory = interface
    ['{FF5664A2-4BDF-4DBD-BD23-B675D1E94736}']
    function GetValidator() : IValidator;
    function GetConstraintValidatorFactory() : IConstraintValidatorFactory;
  end;

implementation

end.
