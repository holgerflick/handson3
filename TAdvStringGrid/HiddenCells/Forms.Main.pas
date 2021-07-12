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
    procedure GridClickCell(Sender: TObject; ARow, ACol: Integer);
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

uses
  UITypes;

{$R *.dfm}


procedure TFrmMain.btnUpdateClick(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.GridClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  ShowMessage( 'Clicked on ' + Grid.Cells[ ACol, ARow ] +
    '. ColCount: ' + Grid.ColCount.ToString + 'AllColCount: ' +
    Grid.AllColCount.ToString );

end;

procedure TFrmMain.GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  if (ACol = 4) and (ARow = 4) then
  begin
    Value := '<i>' + Value + '</i>';
  end;
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
  LRows := 8;
  LCols := 8;

  LFixedRows := 1;
  LFixedCols := 1;

  Grid.RowCount := LRows;
  Grid.ColCount := LCols;
  Grid.DefaultColWidth := Grid.DefaultColWidth + 10;

  Grid.FixedRows := LFixedRows;
  Grid.FixedCols := LFixedCols;

  for LRow := 0 to LRows - 1 do
  begin
    for LCol := 0 to LCols -1 do
    begin
      Grid.Cells[ LCol, LRow ] :=
        Format( '%d / %d', [LCol, LRow] );
    end;
  end;

  Grid.HideColumn(3);
  Grid.HideRow(3);

  Grid.Cells[4,4] := 'Cells';
  Grid.AllCells[4,4] := 'AllCells';
  Grid.RealCells[4,4] := 'RealCells';

  Grid.FontNames[ 4,4 ] := 'Courier New';
  Grid.Colors[4,4] := TColors.Red;
end;


end.
