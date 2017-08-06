unit DValidation.Engine.ValidationContext;

interface
uses
  System.Generics.Collections,
  DValidation.ConstraintViolation,
  DValidation.Engine.MetaData.ObjectMetaData,
  DValidation.Engine.ValueContext,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.ContraintValidators.ConstraintValidator;

type

  IValidationContext<T> = interface
    ['{DA4D0DCA-D795-40C7-A3CD-58CF1CAA47F5}']
    function GetRootObjectMetaData() : IObjectMetaData;
    function GetCurrentObjectType() : TClass;
    procedure SetCurrentGroup(const Group : string);
    procedure MarkCurrentBeanAsProcessed(ValueContext : IValueContext<T>);
    procedure MarkConstraintProcessed();
    function GetFailingConstraints() : TList<IConstraintViolation<T>>;
    function GetConstraintValidator(Constraint : IMetaConstraint) : IConstraintValidator<T>;
  end;

implementation

end.
