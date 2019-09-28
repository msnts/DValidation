unit DValidation.Engine.MessageInterpolator;

interface
uses System.Generics.Collections;

type

  IMessageInterpolator = interface
    ['{686D16DD-23D0-40EA-AE4A-C083148266C0}']
    function Interpolate(const MessageTemplante : string; Attributes : TDictionary<string, variant>) : string;
  end;

implementation

end.
