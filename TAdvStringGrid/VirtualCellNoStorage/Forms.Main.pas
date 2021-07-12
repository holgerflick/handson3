unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.BaseImageCollection, AdvTypes, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, AdvGlowButton, Vcl.StdCtrls, Vcl.Mask, AdvSpin,
  Vcl.ExtCtrls;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
  private
    { Private declarations }
    procedure InitGrid;

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses System.DateUtils;

procedure TFrmMain.btnUpdateClick(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  // set column value to bold column index and
  // italic row index
  Value := Format(
    '<b>%d</b>/<i>%d</i>',
    [ACol, ARow] );
end;

procedure TFrmMain.InitGrid;
begin
  // dimensions
  Grid.RowCount := 10;
  Grid.ColCount := 6;

  // column width
  Grid.DefaultColWidth := 85;

  // fixed cells
  Grid.FixedCols := 0;
  Grid.FixedRows := 1;

  // font
  Grid.Font.Name := 'Consolas';
  Grid.Font.Size := 9;
end;


end.
