unit PostalServiceImpl;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  System.Generics.Collections,
  Entities.PostalItem,
  PostalServiceInt
  ;

type
  [ServiceImplementation]
  TPostalService = class(TInterfacedObject, IPostalService)

    function Search( APostalCode: String ): TPostalItemList;
  end;

implementation

uses
  Modules.DbController;

{ TPostalService }

function TPostalService.Search(APostalCode: String): TPostalItemList;
begin
  Result := TPostalItemList.Create;
  DbController.SearchPostalCode(APostalCode, Result);
end;

initialization
  RegisterServiceType(TPostalService);

end.
