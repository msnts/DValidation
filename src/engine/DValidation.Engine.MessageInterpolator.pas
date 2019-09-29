unit DValidation.Engine.MessageInterpolator;

interface
uses
  System.Rtti,
  System.Generics.Collections;

type

  IMessageInterpolator = interface
    ['{686D16DD-23D0-40EA-AE4A-C083148266C0}']
    function Interpolate(const MessageTemplante : string; Attributes : TDictionary<string, TValue>) : string;
  end;

implementation

end.
