unit DValidation.Constraints.GroupSequence;

interface

type

  GroupSequenceAttribute = class(TCustomAttribute)
  private
    FGroups : TArray<string>;
  public
    constructor Create(const AGroups : string);
    property Groups : TArray<string> read FGroups;
  end;

implementation
uses System.SysUtils;

{ GroupSequenceAttribute }

constructor GroupSequenceAttribute.Create(const AGroups: string);
begin
  FGroups := AGroups.Split([',']);
end;

end.
