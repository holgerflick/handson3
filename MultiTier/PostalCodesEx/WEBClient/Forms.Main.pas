unit Forms.Main;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.StdCtrls, WEBLib.StdCtrls, Vcl.Controls, DB,
  WEBLib.Grids, XData.Web.Client, XData.Web.JsonDataset, XData.Web.Dataset,
  XData.Web.Connection;

type
  TFrmMain = class(TWebForm)
    txtPostalCode: TWebEdit;
    btnSearch: TWebButton;
    Table: TWebTableControl;
    XConnection: TXDataWebConnection;
    XClient: TXDataWebClient;
    procedure btnSearchClick(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    procedure XClientLoad(Response: TXDataClientResponse);
    procedure XConnectionConnect(Sender: TObject);
  private
    { Private declarations }
    procedure Search( APostalCode: String );
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  WebLib.JSON;

procedure TFrmMain.btnSearchClick(Sender: TObject);
begin
  Search( txtPostalCode.Text );
end;

procedure TFrmMain.Search( APostalCode: String );
begin
  XClient.RawInvoke( 'IPostalService.Search', [ APostalCode ]);
end;

procedure TFrmMain.WebFormCreate(Sender: TObject);
begin
  btnSearch.Enabled := False;
  txtPostalCode.Text := '';
  Table.ColCount := 5;

  XConnection.Connected := True;
end;

procedure TFrmMain.XClientLoad(Response: TXDataClientResponse);
var
  LItems: TJSArray;
  LItem: JSValue;
  i : Integer;
begin
  if Response.StatusCode = 200 then
  begin
    LItems := TJSArray( TJSObject( Response.Result )['value'] );
    Table.RowCount := LItems.Length+1;
    Table.Cells[0,0] := 'Country';
    Table.Cells[1,0] := 'City';
    Table.Cells[2,0] := 'State';
    Table.Cells[3,0] := 'County';
    Table.Cells[4,0] := 'Community';

    for i := 0 to LItems.Length-1 do
    begin
      LItem := LItems[i];
      Table.Cells[0, i+1] := string( TJSObject( LItem )['CountryName'] );
      Table.Cells[1, i+1] := string( TJSObject( LItem )['PlaceName'] );
      Table.Cells[2, i+1] := string( TJSObject( LItem )['StateName'] );
      Table.Cells[3, i+1] := string( TJSObject( LItem )['CountyName'] );
      Table.Cells[4, i+1] := string( TJSObject( LItem )['CommunityName'] );
    end;
  end;
end;

procedure TFrmMain.XConnectionConnect(Sender: TObject);
begin
  btnSearch.Enabled := True;
end;

end.
