unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.BaseImageCollection, AdvTypes, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, AdvGlowButton, Vcl.StdCtrls, Vcl.Mask, AdvSpin,
  Vcl.ExtCtrls,
  UITypes;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure GridGetCellCursor(Sender: TObject; ACol, ARow, X, Y: Integer;
      var ACursor: TCursor);
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

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  HAlign := taCenter;
  VAlign := vtaBottom;
end;

procedure TFrmMain.GridGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if not ( gdFixed in AState ) then
  begin
    if ACol MOD 2 = 0 then
    begin
      ABrush.Color := TColors.Red;
    end;
  end;
end;

procedure TFrmMain.GridGetCellCursor(Sender: TObject; ACol, ARow, X, Y: Integer;
  var ACursor: TCursor);
begin
  if ARow = 0 then
  begin
    ACursor := crCross;
  end;
end;

procedure TFrmMain.GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  Value := Format( '%d / %d',
    [ ACol, ARow ] );
end;

procedure TFrmMain.InitGrid;
begin
  Grid.RowCount := 5;
  Grid.ColCount := 6;
end;


end.
