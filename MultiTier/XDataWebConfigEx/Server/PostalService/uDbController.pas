unit uDbController;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Stan.Param,
  FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client,
  Entities.PostalItem,
  FireDAC.DApt;

type
  TDbController = class(TDataModule)
    Manager: TFDManager;
  private
    { Private declarations }

    procedure GetConnectionParams( ALines: TStringList );
    procedure AssignQueryToItem( AItem: TPostalItem; AQuery: TFDQuery );

    function GetConnection: TFDConnection;
    class var FInstance : TDbController;

  public
    class destructor Destroy;
    class function Instance: TDbController;

    { Public declarations }
    procedure SearchPostalCode( const APostalCode: String; AList: TPostalItemList );
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uServerSettings;


CONST
  SQL_SEARCH = 'SELECT Z.*, C.Name as Country ' +
               'FROM worldwide as Z, countrycodes AS C ' +
               'WHERE (Z.postalCode = :text) AND (C.Code = Z.countryCode)';

procedure TDbController.AssignQueryToItem(AItem: TPostalItem; AQuery: TFDQuery);
begin
  if Assigned( AItem ) and Assigned( AQuery ) then
  begin
    AItem.CountryCode := AQuery['CountryCode'];
    AItem.CountryName := AQuery['Country'];
    AItem.PostalCode := AQuery['PostalCode'];
    AItem.PlaceName := AQuery['PlaceName'];
    AItem.StateName  := AQuery['StateName'];
    AItem.StateCode  := AQuery['StateCode'];
    AItem.CountyName  := AQuery['CountyName'];
    AItem.CommunityName  := AQuery['CommunityName'];
    AItem.CommunityCode  := AQuery['CommunityCode'];
  end;
end;

class destructor TDbController.Destroy;
begin
  FInstance.Free;
end;

function TDbController.GetConnection: TFDConnection;
const
  LDefName = 'postal_temp';

var
  LLines: TStringList;

begin
  // set up a private connection definition without using a config file
  // see http://docwiki.embarcadero.com/RADStudio/Sydney/en/Defining_Connection_(FireDAC)
  //
  if Manager.ConnectionDefs.FindConnectionDef(LDefName) = nil then
  begin
    LLines := TStringlist.Create;
    try
      GetConnectionParams( LLines );

      Manager.AddConnectionDef(LDefName, 'MYSQL', LLines, False );
    finally
      LLines.Free;
    end;
  end;

  // create connection instance using the private connection definition
  Result := TFDConnection.Create(nil);
  Result.ConnectionDefName := LDefName;
end;

procedure TDbController.GetConnectionParams(ALines: TStringList);
var
  LSettings : TServerSettings;

begin
  LSettings := TServerSettings.Create;

  try
    LSettings.LoadFromFile;

    ALines.Add('Server=' + LSettings.DatabaseServer );
    ALines.Add('Database=' + LSettings.DatabaseName );
    ALines.Add('Port=' + LSettings.DatabasePort);
    ALines.Add('User_Name=' + LSettings.DatabaseUsername );
    ALines.Add('Password=' + LSettings.DatabasePassword);
    ALines.Add('Pooled=True');
    ALines.Add('CharacterSet=utf8');
  finally
    LSettings.Free;
  end;
end;

class function TDbController.Instance: TDbController;
begin
  if not Assigned( FInstance ) then
  begin
    FInstance := TDbController.Create(nil);
  end;

  Result := FInstance;
end;

procedure TDbController.SearchPostalCode( const APostalCode: String;
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
        AssignQueryToItem( LItem, LQuery );
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
