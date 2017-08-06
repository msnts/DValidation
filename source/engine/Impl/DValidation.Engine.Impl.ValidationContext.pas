unit DValidation.Engine.Impl.ValidationContext;

interface
uses
  DValidation.Engine.ValidationContext,
  System.Generics.Collections,
  DValidation.ConstraintViolation,
  DValidation.Engine.MetaData.ObjectMetaData,
  DValidation.Engine.MetaData.ObjectMetaDataManager,
  DValidation.Engine.ValueContext,
  DValidation.Engine.MetaData.MetaConstraint,
  DValidation.ContraintValidators.ConstraintValidator;

type
  TValidationContext<T> = class(TInterfacedObject, IValidationContext<T>)
  private
    FRootObject : T;
    FRootObjectMetaData : IObjectMetaData;
    FObjectMetaDataManager : IObjectMetaDataManager;
  public
    constructor Create(ObjectMetaDataManager : IObjectMetaDataManager; RootObject : T);
    function GetRootObjectMetaData() : IObjectMetaData;
    function GetCurrentObjectType() : TClass;
    procedure SetCurrentGroup(const Group : string);
    procedure MarkCurrentBeanAsProcessed(ValueContext : IValueContext<T>);
    procedure MarkConstraintProcessed();
    function GetFailingConstraints() : TList<IConstraintViolation<T>>;
    function GetConstraintValidator(Constraint : IMetaConstraint) : IConstraintValidator<T>;
  end;

implementation

{ TValidationContext<T> }

constructor TValidationContext<T>.Create(
  ObjectMetaDataManager: IObjectMetaDataManager;  RootObject : T);
begin

  FRootObject := RootObject;

  FRootObjectMetaData := ObjectMetaDataManager.GetObjectMetaData(TypeInfo(T));

  FObjectMetaDataManager := ObjectMetaDataManager;

end;

function TValidationContext<T>.GetConstraintValidator(
  Constraint: IMetaConstraint): IConstraintValidator<T>;
begin

end;

function TValidationContext<T>.GetCurrentObjectType: TClass;
begin

end;

function TValidationContext<T>.GetFailingConstraints: TList<IConstraintViolation<T>>;
begin

end;

function TValidationContext<T>.GetRootObjectMetaData: IObjectMetaData;
begin
  Result := FRootObjectMetaData;
end;

procedure TValidationContext<T>.MarkConstraintProcessed;
begin

end;

procedure TValidationContext<T>.MarkCurrentBeanAsProcessed(
  ValueContext: IValueContext<T>);
begin

end;

procedure TValidationContext<T>.SetCurrentGroup(const Group: string);
begin

end;

end.
