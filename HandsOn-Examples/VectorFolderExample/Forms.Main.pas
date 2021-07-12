unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  AdvGlowButton, AdvToolBar, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  FolderDialog,
  Classes.Meta,
  IOUtils,
  AdvUtils,
  AdvStyleIF, AdvAppStyler, AdvTypes, AdvTrackBar,
  Zip, asgprint, asgprev, tmsAdvGridExcel,
  Classes.AppSettings, AdvToolBarStylers;

type
  TFrmMain = class(TForm)
    Track: TAdvTrackBar;
    lblSize: TLabel;
    AdvDockPanel1: TAdvDockPanel;
    Toolbar: TAdvToolBar;
    btnLoadFolder: TAdvGlowButton;
    Grid: TAdvStringGrid;
    Images: TVirtualImageList;
    dlgFolder: TFolderDialog;
    ToolImages: TVirtualImageList;
    AdvFormStyler1: TAdvFormStyler;
    Vectors: TAdvSVGImageCollection;
    ToolVectors: TAdvSVGImageCollection;
    btnLoadZip: TAdvGlowButton;
    Excel: TAdvGridExcelIO;
    btnExcel: TAdvGlowButton;
    dlgOpenZip: TFileOpenDialog;
    dlgSaveExcel: TFileSaveDialog;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    procedure FormCreate(Sender: TObject);
    procedure btnLoadFolderClick(Sender: TObject);
    procedure FormAfterMonitorDpiChanged(Sender: TObject; OldDPI,
      NewDPI: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure btnLoadZipClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure TrackChanged(Sender: TObject);
  private
    { Private declarations }
    FIcons: TIconItemList;
    FAppSettings: TAppSettings;

    procedure InitTrackbar;

    procedure LoadFolder( const AFolderName: String );
    procedure LoadZip( const AZipFileName: String );
    procedure SelectFolder;

    procedure UpdateLabel;
    procedure UpdateGrid;
    procedure UpdateImages;

    procedure SetIconSize(const Value: Integer);
    function GetIconSize: Integer;

    procedure LoadSettings;
    procedure SaveSettings;

  public
    { Public declarations }
    property IconSize: Integer read GetIconSize write SetIconSize;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

{ TForm1 }

procedure TFrmMain.btnExcelClick(Sender: TObject);
begin
  if dlgSaveExcel.Execute then
  begin
    FAppSettings.ExcelDocument := dlgSaveExcel.FileName;
    Excel.Options.ExportImages := True;
    Excel.XLSExport( dlgSaveExcel.FileName );
  end;
end;

procedure TFrmMain.btnLoadFolderClick(Sender: TObject);
begin
  SelectFolder;
end;

procedure TFrmMain.btnLoadZipClick(Sender: TObject);
begin
  dlgOpenZip.FileName := FAppSettings.ZipArchive;
  if dlgOpenZip.Execute then
  begin
      FAppSettings.ZipArchive := dlgOpenZip.FileName;
      LoadZip( dlgOpenZip.FileName );
  end;
end;

procedure TFrmMain.FormAfterMonitorDpiChanged(Sender: TObject; OldDPI,
  NewDPI: Integer);
begin
  UpdateGrid;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FIcons := TIconItemList.Create;
  FAppSettings := TAppSettings.Create;

  LoadSettings;
  InitTrackbar;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  SaveSettings;

  FAppSettings.Free;
  FIcons.Free;
end;

function TFrmMain.GetIconSize: Integer;
begin
  Result := Track.Position;
end;

procedure TFrmMain.InitTrackbar;
begin
  Track.Max := 256;
  Track.Min := 16;
  Track.TickMark.ShowImageAtSteps := 16;
  Track.PageSize := 16;
  IconSize := FAppSettings.IconSize;
end;

procedure TFrmMain.LoadFolder(const AFolderName: String);
var
  LFiles: TArray<string>;
  LFileName: String;
  LVector: TAdvSVGImageCollectionItem;
  LItem: TIconItem;
  LFileStream: TFileStream;

begin
  LFiles := TDirectory.GetFiles( AFolderName, '*.svg' );

  Vectors.Images.Clear;
  FIcons.Clear;

  for LFileName in LFiles do
  begin
    // init a new vector
    LVector := Vectors.Images.Add;

    // store meta info
    LItem := TIconItem.Create;
    LItem.FileName := LFileName;

    // determine file size
    LFileStream := TFile.OpenRead(LFilename);

    try
      LItem.Size :=  LFileStream.Size;
    finally
      LFileStream.Free;
    end;

    // add to image collection
    LVector.Data.LoadFromFile( LFileName );

    // add meta info to list
    FIcons.Add( LItem );
  end;

  UpdateImages;
  UpdateGrid;
end;

procedure TFrmMain.LoadSettings;
begin
  TStoreSettings.LoadFromRegistry(FAppSettings);
end;

procedure TFrmMain.LoadZip(const AZipFileName: String);
var
  LZip: TZipFile;
  LFiles: TArray<string>;
  LFile: String;
  LTmpPath: String;
  LFileNameOnly: String;
  LVector: TAdvSVGImageCollectionItem;
  LItem: TIconItem;
  LFileStream: TFileStream;

begin
  LTmpPath := TAdvUtils.GetTempPath;

  Vectors.Images.BeginUpdate;
  Vectors.Images.Clear;
  FIcons.Clear;

  LZip := TZipFile.Create;
  try
    LZip.Open(AZipFileName, TZipMode.zmRead);
    LFiles := LZip.FileNames;

    for LFile in LFiles do
    begin
      if LFile.ToLower.EndsWith('.svg') then
      begin
        LZip.Extract(LFile, LTmpPath, False);
        LFileNameOnly := TPath.GetFileName(LFile);

        LVector := Vectors.Images.Add;
        LFileStream := TFile.OpenRead( TPath.Combine( LTmpPath, LFileNameOnly ) );

        try
          LVector.Data.LoadFromStream(LFileStream);
          LItem := TIconItem.Create;
          LItem.FileName := LFileNameOnly;
          LItem.Size := LFileStream.Size;

          FIcons.Add(LItem);
        finally
          LFileStream.Free;
          TFile.Delete(TPath.Combine( LTmpPath, LFileNameOnly ));
        end;
      end;
    end;

    UpdateImages;
    UpdateGrid;
  finally
    LZip.Free;
    Vectors.Images.EndUpdate;
  end;
end;

procedure TFrmMain.SaveSettings;
begin
  TStoreSettings.SaveToRegistry(FAppSettings);
end;

procedure TFrmMain.SelectFolder;
begin
  if NOT FAppSettings.SelectedFolder.IsEmpty then
  begin
    dlgFolder.Directory := FAppSettings.SelectedFolder;
  end;

  if dlgFolder.Execute then
  begin
    FAppSettings.SelectedFolder := dlgFolder.Directory;
    LoadFolder( dlgFolder.Directory );
  end;
end;

procedure TFrmMain.SetIconSize(const Value: Integer);
begin
  Track.Position := Value;

  UpdateLabel;
  UpdateGrid;
end;

procedure TFrmMain.TrackChanged(Sender: TObject);
begin
  UpdateLabel;
  UpdateGrid;
end;

procedure TFrmMain.UpdateGrid;
var
  i: Integer;
  LSize: Integer;
  LFactor: Double;
  LRow: Integer;

begin
  Grid.BeginUpdate;

  try
    if Images.Count > 0 then
    begin
      Images.Width := IconSize;
      Images.Height := IconSize;

      Grid.RowCount := Images.Count+1;
      Grid.ColCount := 4;

      Grid.GridImages := Images;

      Grid.FixedCols := 1;
      Grid.FixedRows := 1;

      Grid.Cells[0,0] := '#';
      Grid.Cells[1,0] := 'Icon';
      Grid.Cells[2,0] := 'Filename';
      Grid.Cells[3,0] := 'Size/KB';

      // get display factor
      LFactor := TAdvUtils.GetDPIScale;

      // calculate icon size depending on display
      LSize := trunc( ( IconSize + 4 ) * LFactor );

      // column size needs to be adjusted for DPI
      Grid.ColWidths[1] := LSize;
      for i := 0 to Images.Count - 1 do
      begin
        LRow := i + 1;

        // row index
        Grid.Ints[0, LRow] := LRow;
        Grid.Alignments[0, LRow] := taRightJustify;

        // icon, centered
        Grid.AddImageIdx(1, LRow, i, haCenter, vaCenter );

        // file name
        Grid.Cells[2, LRow] :=  TPath.GetFileName( FIcons[i].FileName );

        // file size
        Grid.Floats[3, LRow] := FIcons[i].SizeKB;

        // set font and alignment
        Grid.FontNames[3, LRow] := 'Droid Sans Mono';
        Grid.FontSizes[3, LRow] := 11;
        Grid.Alignments[3, LRow] := taRightJustify;

        // row height needs to be adjusted for DPI
        Grid.RowHeights[LRow] := LSize;
      end;

      // columns are sized automatically
      Grid.AutoSizeCol( 0, 4 );
      Grid.AutoSizeCol( 2, 4 );
      Grid.AutoSizeCol( 3, 4 );
    end;

    FAppSettings.IconSize := IconSize;

  finally
    Grid.EndUpdate;
  end;
end;

procedure TFrmMain.UpdateImages;
begin
  Images.ImageCollection := nil;
  Images.ImageCollection := Vectors;
end;

procedure TFrmMain.UpdateLabel;
begin
  lblSize.Caption := Format('Icon size: %d x %d', [ Track.Position, Track.Position ]);
end;

end.
