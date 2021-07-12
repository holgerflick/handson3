unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, System.Generics.Collections,
  PostalServiceInt,
  XData.Client,
  Entities.PostalItem,
  IOUtils;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure GridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure FormDestroy(Sender: TObject);

    procedure GridCellValidate(Sender: TObject; ACol, ARow: Integer;
      var Value: string; var Valid: Boolean);
    procedure GridGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure GridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure GridComboChange(Sender: TObject; ACol, ARow, AItemIndex: Integer;
      ASelection: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FCurrentCode: String;
    FList:  TPostalItemList;

    function LookupPostalCode( APostalCode: String ):Integer;
    function GetFilename: String;

    procedure Save;
    procedure Load;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

CONST
  IDX_NAME    = 0;
  IDX_ADDR    = 1;
  IDX_ZIP     = 2;
  IDX_CITY    = 3;
  IDX_STATE   = 4;
  IDX_COUNTRY = 5;

  FILENAME    = 'postalex.bin';

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Save;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Grid.ColCount := 6;
  Grid.Cells[IDX_NAME,0] := 'Name';
  Grid.Cells[IDX_ADDR,0] := 'Address';
  Grid.Cells[IDX_ZIP,0] := 'Postal Code';
  Grid.Cells[IDX_CITY,0] := 'City';
  Grid.Cells[IDX_STATE,0] := 'State';
  Grid.Cells[IDX_COUNTRY,0] := 'Country';
  Grid.ColumnSize.StretchAll := True;
  Grid.StretchColumns;

  Load;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FList.Free;
end;

function TFrmMain.GetFilename: String;
begin
  Result := TPath.Combine(
    TPath.GetHomePath,
    FILENAME );
end;

procedure TFrmMain.GridCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  // state and country will be set
  // automatically based on selected city
  CanEdit := ACol < IDX_STATE;
end;

procedure TFrmMain.GridCellValidate(Sender: TObject; ACol, ARow: Integer;
  var Value: string; var Valid: Boolean);
begin
  if ACol = IDX_ZIP then
  begin
    if TRIM( Value ) <> ''  then
    begin
      Valid :=  LookupPostalCode(Value) > 0;
      if not Valid then
      begin
        Grid.InvalidEntryTitle := 'Postal code not found.';
        Grid.InvalidEntryText := 'Please enter a valid postal code.';
      end;
    end
    else
    begin
      Grid.Cells[ 3, IDX_CITY ] := '';
      Grid.Cells[ 4, IDX_STATE ] := '';
      Grid.Cells[ 5, IDX_COUNTRY ] := '';
    end;
  end;
end;

procedure TFrmMain.GridComboChange(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: string);
var
  LItem: TPostalItem;

begin
  // when city has been selected
  if ACol = IDX_CITY then
  begin
    // get instance of TPostalItem from combo box
    LItem := Grid.Combobox.Items.Objects[AItemIndex] as TPostalItem;

    // assign state and country to other grid cells matching the city
    Grid.Cells[ 4, ARow ] := LItem.StateName;
    Grid.Cells[ 5, ARow ] := LItem.CountryName;
  end;
end;

procedure TFrmMain.GridGetEditorProp(Sender: TObject; ACol, ARow: Integer;
  AEditLink: TEditLink);
var
  LItem : TPostalItem;

begin
  if ACol = IDX_CITY then
  begin
    // check if fetched data matches for zip code in current row
    if FCurrentCode <> Grid.Cells[IDX_ZIP, ARow] then
    begin
      // fetch data from Web service
      LookupPostalCode( Grid.Cells[IDX_ZIP, ARow] );
    end;

    // clear combo box
    Grid.Combobox.Clear;

    // iterate for all items in list
    for LItem in FList do
    begin
      // add city and object reference to combo box
      Grid.Combobox.AddItem( LItem.PlaceName, LItem );
    end;
  end;
end;

procedure TFrmMain.GridGetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
  // zip codes can be numbers and upper-case characters
  if ACol = IDX_ZIP then
  begin
    AEditor := TEditorType.edUpperCase;
  end;

  // city can be picked from list
  if ACol = IDX_CITY then
  begin
    AEditor := TEditorType.edComboList;
  end;
end;

procedure TFrmMain.Load;
begin
  if TFile.Exists(GetFilename) then
  begin
    Grid.LoadFromBinFile( GetFilename );
  end;
end;

function TFrmMain.LookupPostalCode(APostalCode: String) : Integer;
var
  LClient: TXDataClient;
  LService: IPostalService;

begin
  Result := 0;

  // create client instance
  LClient := TXDataClient.Create;

  // set host url
  LClient.Uri := 'http://localhost';
  try
    // object instances will be cleared manually
    LClient.ReturnedInstancesOwnership := TInstanceOwnership.None;

    // free existing instances from list and list itself
    if Assigned( FList ) then
    begin
      FList.Free;
    end;

    // instantiate new list
    LService := LClient.Service<IPostalService>;

    // fetch list of matching items from Web service
    FList := LService.Search(APostalCode);

    // assign number of items to Result
    Result := FList.Count;

    // update current postal code
    FCurrentCode := APostalCode;
  finally

    // release client, object instances will not be freed
    LClient.Free;
  end;
end;

procedure TFrmMain.Save;
begin
  Grid.SaveToBinFile(
   GetFilename
   );
end;

end.
