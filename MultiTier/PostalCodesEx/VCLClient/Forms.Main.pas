unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, Vcl.StdCtrls, AdvEdit,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Data.DB,
  Aurelius.Bind.BaseDataset, Aurelius.Bind.Dataset, Entities.PostalItem,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList;

type
  TFrmMain = class(TForm)
    txtPostalCode: TAdvEdit;
    btnSearch: TAdvGlowButton;
    Grid: TDBAdvGrid;
    DataSource: TDataSource;
    Dataset: TAureliusDataset;
    DatasetCountryName: TWideStringField;
    DatasetPlaceName: TWideStringField;
    DatasetStateName: TWideStringField;
    DatasetCountyName: TWideStringField;
    DatasetCommunityName: TWideStringField;
    Images: TVirtualImageList;
    Collection: TImageCollection;
    procedure FormDestroy(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtPostalCodeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FList : TPostalItemList;

    procedure Search( APostalCode: String );
    procedure ReleaseList;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  PostalServiceInt,
  XData.Client
    ;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Grid.StyleElements := [];
  Grid.Options := Grid.Options + [ goFixedVertLine, goFixedHorzLine ];
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned( FList ) then
  begin
    ReleaseList;
  end;
end;

procedure TFrmMain.ReleaseList;
var
  LItem: TPostalItem;
begin

  for LItem in FList do
  begin
    LItem.Free;
  end;

  FList.Free;
  FList := nil;
end;

procedure TFrmMain.btnSearchClick(Sender: TObject);
begin
  Search( txtPostalCode.Text );
  txtPostalCode.Clear;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  txtPostalCode.Text := '';
  txtPostalCode.SetFocus;
end;

procedure TFrmMain.Search( APostalCode: String );
var
  LClient : TXDataClient;
  LService: IPostalService;

begin
  LClient := TXDataClient.Create;
  try
    LClient.Uri := 'http://localhost:80';
    LClient.ReturnedInstancesOwnership := TInstanceOwnerShip.None;

    LService := LClient.Service<IPostalService>;

    if Assigned( FList ) then
    begin
      ReleaseList;
    end;

    try
      FList := LService.Search(APostalCode);

      Dataset.Close;
      Dataset.SetSourceList(FList);
      Dataset.Active := True;
    except on E: EXDataClientException do
      ShowMessage( 'Communication error. Please make sure that the ' +
                   'XData server is available.' );


    end;
  finally
    LClient.Free;
  end;

end;

procedure TFrmMain.txtPostalCodeChange(Sender: TObject);
begin
  btnSearch.Enabled := (Sender as TAdvEdit).Text <> '';
end;

end.
