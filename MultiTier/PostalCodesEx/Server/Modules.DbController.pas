unit Modules.DbController;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client,
  Entities.PostalItem
  ;

type
  TDbController = class(TDataModule)
    Manager: TFDManager;
  private
    { Private declarations }
    function GetConnection: TFDConnection;

  public
    { Public declarations }
    procedure SearchPostalCode( APostalCode: String; AList: TPostalItemList );
  end;

var
  DbController: TDbController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

CONST
  SQL_SEARCH = 'SELECT Z.*, C.Name as Country ' +
               'FROM worldwide as Z, countrycodes AS C ' +
               'WHERE (Z.postalCode = :text) AND (C.Code = Z.countryCode)';

function TDbController.GetConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.ConnectionDefName := 'postal';
  Result.LoginPrompt := False;
end;

procedure TDbController.SearchPostalCode(APostalCode: String;
  AList: TPostalItemList);

var
 LItem: TPostalItem;
 LCon: TFDConnection;
 LQuery: TFDQuery;

begin
  if Assigned( AList ) then
  begin
    AList.Clear;

    LCon := GetConnection;
    LQuery := TFDQuery.Create(nil);
    try
      LQuery.Connection := LCon;

      LQuery.SQL.Text := SQL_SEARCH;
      LQuery.ParamByName('text').AsString := APostalCode;

      LQuery.Open();
      while not LQuery.Eof do
      begin
        LItem := TPostalItem.Create;
        LItem.CountryCode := LQuery['CountryCode'];
        LItem.CountryName := LQuery['Country'];
        LItem.PostalCode := LQuery['PostalCode'];
        LItem.PlaceName := LQuery['PlaceName'];
        LItem.StateName  := LQuery['StateName'];
        LItem.StateCode  := LQuery['StateCode'];
        LItem.CountyName  := LQuery['CountyName'];
        LItem.CommunityName  := LQuery['CommunityName'];
        LItem.CommunityCode  := LQuery['CommunityCode'];

        AList.Add(LItem);

        LQuery.Next;
      end;
    finally
      LQuery.Free;
      LCon.Free;
    end;
  end;
end;

end.
