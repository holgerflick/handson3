unit PostalServiceImpl;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  System.Generics.Collections,
  Entities.PostalItem,
  PostalServiceInt,
  Aurelius.Types.Nullable
  ;

type
  [ServiceImplementation]
  TPostalService = class(TInterfacedObject, IPostalService)

    function Search( APostalCode: String ): TPostalItemList;
  end;

implementation

uses
  uDbController;

{ TPostalService }

function TPostalService.Search(APostalCode: String): TPostalItemList;
begin
  Result := TPostalItemList.Create;
  TDbController.Instance.SearchPostalCode(APostalCode, Result);
end;

initialization
  RegisterServiceType(TPostalService);

end.
