unit DValidation.Engine.Validator;

interface
uses
  System.Generics.Collections,
  DValidation.ConstraintViolation;

type

  IValidator = interface
    ['{63959032-1A28-4FC8-B9C0-38455BAEDB54}']

    function Validate(Obj : TObject; Groups : TArray<string>) : TList<IConstraintViolation<Tobject>>;
    function ValidateProperty(Obj : TObject; const PropertyName : string; Groups : TArray<string>) : TList<IConstraintViolation<Tobject>>;

  end;

implementation

end.
