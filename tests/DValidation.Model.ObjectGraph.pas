unit DValidation.Model.ObjectGraph;

interface
uses
  System.Generics.Collections,
  DValidation.Constraints.NotNull,
  DValidation.Constraints.NotEmpty,
  DValidation.Constraints.Size,
  DValidation.Constraints.DecimalMax,
  DValidation.Constraints.DecimalMin,
  DValidation.Constraints.AssertTrue,
  DValidation.Constraints.Valid;

type

  TPerson = class
  private
    [NotEmpty]
    FName : string;
  public
    constructor Create(const AName : string);
    property Name : string read FName write FName;
  end;

  TPart = class
  private
    [NotEmpty]
    FName : string;
  public
    constructor Create(const AName : string);
    property Name : string read FName write FName;
  end;

  TCar = class
  private

    [DecimalMin(500.56), DecimalMax(987.8)]
    FWeight : Double;

    //[Size('{"Min":2, "Max":14}')]
    FLicensePlate : string;

    [AssertTrue]
    FIsRegistered : Boolean;

    //[NotNull, Valid]
    FDriver : TPerson;

    //[NotNull, Size('{"Min":1, "Max":5}')]
    FPassengers : TList<TPerson>;

  //  [NotNull, Valid]
    FParts : TList<TPart>;
  public
    constructor Create(const AWeight: Double; ADriver: TPerson; APassengers: TList<TPerson>; AParts: TList<TPart>);
    destructor Destroy; override;
    property Driver : TPerson read FDriver write FDriver;
    property Passengers : TList<TPerson> read FPassengers write FPassengers;
    property Parts : TList<TPart> read FParts write FParts;
  end;



implementation

{ TCar }

constructor TCar.Create(const AWeight: Double; ADriver: TPerson; APassengers: TList<TPerson>;
  AParts: TList<TPart>);
begin
  FWeight := AWeight;
  FDriver := ADriver;
  FPassengers := APassengers;
  FParts := AParts;
end;

destructor TCar.Destroy;
var
  Passenger : TPerson;
  Part : TPart;
begin

  if Assigned(FDriver) then
    FDriver.Free;

  if Assigned(FPassengers) then
  begin

    for Passenger in FPassengers do
      Passenger.Free;

    FPassengers.Free;
  end;

  if Assigned(FParts) then
  begin

    for Part in FParts do
      Part.Free;

    FParts.Free;
  end;

  inherited;
end;

{ TPart }

constructor TPart.Create(const AName: string);
begin
  FName := AName;
end;

{ TPerson }

constructor TPerson.Create(const AName: string);
begin
  FName := AName;
end;

end.
