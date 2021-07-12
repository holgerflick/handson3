unit PostalServiceInt;

interface

uses
  XData.Service.Common,
  Aurelius.Mapping.Attributes,
  Entities.PostalItem,
  System.Generics.Collections,
  Aurelius.Types.Nullable
  ;

type
  /// <swagger name="tag-name">Postal Service (ps)</swagger>
  /// <swagger name="tag-description">Web service to lookup postal codes around the globe.</swagger>
  [ServiceContract]
  [Model('modData')]
  [Route('')]
  IPostalService = interface(IInvokable)
    ['{6A2E15B4-3176-4C3B-89D3-9A4D8ABB8E16}']

    [HttpGet]
    [Route('{APostalCode}')]
    /// <summary>
    ///  Look up a postal code and return all matching items.
    /// </summary>
    /// <param name="APostalCode">
    ///  Postal code to be looked up. String is used as postal codes may contain
    ///  numbers as well as other characters.
    /// </param>
    function Search( APostalCode: String ): TPostalItemList;

  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IPostalService));

end.
