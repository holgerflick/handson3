unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid;

type
  TForm1 = class(TForm)
    Grid: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Grid.DefaultColWidth := 200;
  Grid.DefaultRowHeight := 200;
  Grid.ColCount := 3;
  Grid.RowCount := 2;

  Grid.Cells[0,0] := '<IMG src="res://LOGO" width="150" height="150">';
end;

end.
