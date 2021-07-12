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
    Panel1: TPanel;
    txtRows: TAdvSpinEdit;
    txtCols: TAdvSpinEdit;
    txtFixedRows: TAdvSpinEdit;
    txtFixedCols: TAdvSpinEdit;
    btnUpdate: TAdvGlowButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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


procedure TFrmMain.btnUpdateClick(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  Grid.MergeColumnCells(2, true)
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.InitGrid;
var
  LRow,
  LCol : Integer;

  LRows: Integer;
  LCols: Integer;

  LFixedRows: Integer;
  LFixedCols: Integer;

begin
  LRows := txtRows.Value;
  LCols := txtCols.Value;

  LFixedRows := txtFixedRows.Value;
  LFixedCols := txtFixedCols.Value;

  Grid.RowCount := LRows;
  Grid.ColCount := LCols;

  Grid.FixedRows := LFixedRows;
  Grid.FixedCols := LFixedCols;

  for LRow := 0 to LRows - 1 do
  begin
    for LCol := 0 to LCols -1 do
    begin
      Grid.Cells[ LCol, LRow ] :=
        Format( '%d ', [LCol] );
    end;
  end;
end;


end.
