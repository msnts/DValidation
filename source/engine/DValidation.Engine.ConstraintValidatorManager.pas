unit DValidation.Engine.ConstraintValidatorManager;

interface
uses
  System.TypInfo,
  DValidation.ContraintValidators.ConstraintValidator;

type

  IConstraintValidatorManager = interface
    ['{59CC48B4-B442-422A-AEE9-16264B80FC3D}']
    function GetInitializedValidator(aType : PTypeInfo) : IConstraintValidator<variant>;
  end;


implementation

end.
