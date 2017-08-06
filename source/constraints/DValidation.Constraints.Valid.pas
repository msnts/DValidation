unit DValidation.Constraints.Valid;

interface

type
  /// <summary> Marks a property, method parameter for validation cascading.
  /// <para>
  /// Constraints defined on the object and its properties are be validated when the
  /// property, method parameter is validated. </para>
  /// <para>
  /// This behavior is applied recursively.
  /// </para>
  /// </summary>
  ValidAttribute = class(TCustomAttribute);

implementation

end.
