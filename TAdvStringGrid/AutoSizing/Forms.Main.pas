unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.BaseImageCollection, AdvTypes, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList;

type
  TFrmMain = class(TForm)
    GridA: TAdvStringGrid;
    Vectors: TAdvSVGImageCollection;
    Images: TVirtualImageList;
    procedure FormAfterMonitorDpiChanged(Sender: TObject; OldDPI,
      NewDPI: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure InitGrid;
    procedure InitImages;

    procedure UpdateGridSize;

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}
uses
  AdvUtils,
  Helper.TAdvStringGrid,
  Helper.TAdvSVGImageCollection;

procedure TFrmMain.FormAfterMonitorDpiChanged(Sender: TObject; OldDPI,
  NewDPI: Integer);
begin
  // in case DPI changes, update grid sizes
  UpdateGridSize;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitImages;
  InitGrid;
end;

procedure TFrmMain.InitGrid;
var
  i: Integer;

begin
  // load data from resource
  GridA.LoadFromCSVResource('csv', TEncoding.UTF8);

  // assign image list to grid
  GridA.GridImages := Images;

  // set column 0 as data image column
  for i := 1 to GridA.RowCount-1 do
  begin
    GridA.AddDataImage(0, i, 0, haCenter, vaCenter );
  end;

  // update column and row sizes
  UpdateGridSize;
end;

procedure TFrmMain.InitImages;
begin
  // load vectors into image collection
  Vectors.LoadFromZipResource('people');

  // link image collection to image list
  Images.ImageCollection := Vectors;
end;

procedure TFrmMain.UpdateGridSize;
begin
  // set minimum heights
  GridA.MinRowHeight := Images.Height+4;
  GridA.MinColWidth := Images.Width+4;

  // auto size columns
  GridA.AutoSizeColumns(true);

  // auto size rows
  GridA.AutoSizeRows(true);
end;

end.
