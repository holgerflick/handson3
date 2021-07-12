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
    btnLinear: TAdvGlowButton;
    btnRandom: TAdvGlowButton;
    btnText: TAdvGlowButton;
    btnFormat: TAdvGlowButton;
    cbFixed: TCheckBox;
    procedure FormCreate(Sender: TObject);

    procedure btnSelectedCellClick(Sender: TObject);
    procedure btnLinearClick(Sender: TObject);
    procedure btnRandomClick(Sender: TObject);
    procedure btnTextClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
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


procedure TFrmMain.btnFormatClick(Sender: TObject);
begin
  Grid.FormatFill( cbFixed.Checked, 'c: %d, r: %d' );
end;

procedure TFrmMain.btnLinearClick(Sender: TObject);
begin
  Grid.LinearFill(cbFixed.Checked);
end;

procedure TFrmMain.btnRandomClick(Sender: TObject);
begin
  Grid.RandomFill(cbFixed.Checked, 50);
end;

procedure TFrmMain.btnSelectedCellClick(Sender: TObject);
var
  LCoord : TGridCoord;

begin
  if Grid.SelectedCellsCount > 0 then
  begin
    LCoord := Grid.SelectedCell[0];
    ShowMessage( LCoord.X.ToString + '/'+ LCoord.Y.ToString );
  end;
end;

procedure TFrmMain.btnTextClick(Sender: TObject);
begin
  Grid.TextFill(cbFixed.Checked, 'Text');
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.InitGrid;
begin
  Grid.DefaultColWidth := 80;
  Grid.ColCount := 8;
  Grid.RowCount := 9;
  Grid.FixedCols := 1;
  Grid.FixedRows := 1;
  Grid.Font.Name := 'Consolas';
  Grid.Font.Size := 9;
end;


end.
