unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.StdCtrls, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Grid.RowCount := 5;
  Grid.ColCount := 5;
  Grid.FixedCols := 1;
  Grid.FixedRows := 1;

  Grid.DefaultRowHeight := 25;
  Grid.RowHeights[0] := 50;

  Grid.DefaultColWidth := 50;
  Grid.ColWidths[0] := 10;

  Grid.Options := Grid.Options + [goRowSizing, goColSizing];

  Grid.LinearFill(False);
end;

end.
