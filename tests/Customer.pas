unit Customer;

interface
uses
  DValidation.Constraints.Valid,
  DValidation.Constraints.GroupSequence,
  DValidation.Constraints.Email,
  DValidation.Constraints.NotEmpty,
  DValidation.Constraints.Size,
  DValidation.Constraints.AssertTrue,
  DValidation.Constraints.AssertFalse;

const DEFAULT = 0;

type

  IPerson = interface
    ['{F5581C7B-57D4-4D9F-B2D4-B2201FC50E04}']

   // [NotEmpty('')]
    function GetFirstName() : string;

    function GetMiddleName() : string;

   // [NotEmpty('')]
    function GetLastName() : string;

  end;

  TAddress = class
  private

    //[NotEmpty(''), Size('{"max":30}')]
    FStreet : string;

    FCountry : string;

    FZipCode : string;

    FCity : string;
  public
    property Street : string read FStreet write FStreet;
    property Country : string read FCountry write FCountry;
    property ZipCode : string read FZipCode write FZipCode;
    property City : string read FCity write FCity;
  end;


 // [GroupSequence('default')]
  TCustomer = class(TInterfacedObject, IPerson)
  private
    FFirstName : string;
    FMiddleName : string;
    FLastName : string;

    //[NotNull('{"Message":"NotNull"}')]
    FAddress : TAddress;
  public
    //[Email('{"Message":"teste"}')]
    //[Size('{"Min":10, "Max":20}')]
    Email : string;

    [AssertTrue([DEFAULT, 3, 5])]
    Valid : Boolean;

    [AssertFalse()]
    NotValid : Boolean;

    function GetFirstName() : string;
    procedure SetFirstName(const aFirstName : string);
    function GetMiddleName() : string;
    procedure SetMiddleName(const aMiddleName : string);
    function GetLastName() : string;
    procedure SetLastName(const aLastName : string);

    property Address : TAddress read FAddress write FAddress;
  end;

implementation

{ TCustomer }

function TCustomer.GetFirstName: string;
begin
  Result := FFirstName;
end;

function TCustomer.GetLastName: string;
begin
  Result := FLastName;
end;

function TCustomer.GetMiddleName: string;
begin
  Result := FMiddleName;
end;

procedure TCustomer.SetFirstName(const aFirstName: string);
begin
  FFirstName := aFirstName;
end;

procedure TCustomer.SetLastName(const aLastName: string);
begin
  FLastName := aLastName;
end;

procedure TCustomer.SetMiddleName(const aMiddleName: string);
begin
  FMiddleName := aMiddleName;
end;

end.
