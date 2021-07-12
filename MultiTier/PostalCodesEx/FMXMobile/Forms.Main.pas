unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid;

type
  TFrmMain = class(TForm)
    txtPostalCode: TEdit;
    btnSearch: TButton;
    Grid: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    procedure btnSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Search( APostalCode:String );

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

uses
  System.Generics.Collections,
  XData.Client,
  PostalServiceInt,
  Entities.PostalItem;

procedure TFrmMain.btnSearchClick(Sender: TObject);
begin
  Search( txtPostalCode.Text );
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  txtPostalCode.Text := '';
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  txtPostalCode.SetFocus;
end;

procedure TFrmMain.Search( APostalCode:String );
var
  LClient: TXDataClient;
  LService: IPostalService;
  LList: TPostalItemList;
  i: Integer;

begin
  LClient := TXDataClient.Create;
  try
    LClient.Uri := 'http://192.168.0.2:80';

    LService := LClient.Service<IPostalService>;
    LList := LService.Search( APostalCode );

    Grid.RowCount := LList.Count;

    for i := 0 to LList.Count-1 do
    begin
      Grid.Cells[0,i] := LList[i].CountryName;
      Grid.Cells[1,i] := LList[i].PlaceName;
      Grid.Cells[2,i] := LList[i].StateName;
    end;
  finally
    LList.Free;
    LClient.Free;
  end;
end;

end.
