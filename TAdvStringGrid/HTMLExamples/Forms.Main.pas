unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.BaseImageCollection, AdvTypes, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, AdvGlowButton, Vcl.StdCtrls, Vcl.Mask, AdvSpin,
  Vcl.ExtCtrls, PictureContainer;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    PictureContainer1: TPictureContainer;
    procedure FormCreate(Sender: TObject);
    procedure GridAnchorClick(Sender: TObject; ARow, ACol: Integer;
      Anchor: string; var AutoHandle: Boolean);
    procedure GridAnchorHint(Sender: TObject; ARow, ACol: Integer;
      var Anchor: string);
    procedure GridAnchorEnter(Sender: TObject; ARow, ACol: Integer;
      Anchor: string);
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

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitGrid;
end;

procedure TFrmMain.GridAnchorClick(Sender: TObject; ARow, ACol: Integer;
  Anchor: string; var AutoHandle: Boolean);
begin
  // only show message box for custom anchor
  if Anchor = 'message' then
  begin
    ShowMessage( 'That works!' );
  end;
end;

procedure TFrmMain.GridAnchorEnter(Sender: TObject; ARow, ACol: Integer;
  Anchor: string);
begin
  // add info to grid
  Grid.Cells[1,10] := DateTimeToStr( Now ) + ': Enter ' + Anchor;
end;

procedure TFrmMain.GridAnchorHint(Sender: TObject; ARow, ACol: Integer;
  var Anchor: string);
begin
  // only handle custom anchor
  if Anchor = 'message' then
  begin
    // add info to grid
    Grid.Cells[1,11] := DateTimeToStr( Now ) + ': Hint!';
  end;
end;

procedure TFrmMain.InitGrid;
begin
  // dimensions
  Grid.RowCount := 12;
  Grid.ColCount := 2;

  // fixed cells
  Grid.FixedCols := 1;
  Grid.FixedRows := 1;

  // font
  Grid.Font.Name := 'Consolas';
  Grid.Font.Size := 9;

  // HTML font example
  Grid.Cells[1,1] := 'This is written in ' +
   '<FONT face="Arial" size="12" color="clRed">red</FONT>';

  Grid.Cells[1,2] := 'This is written in ' +
   '<FONT face="Arial" size="12" color="#FF0000">red</FONT>';

  // handling Anchors
  Grid.Cells[1,3] := 'Open <A href="https://www.tmssoftware.com">webpage</A>.';
  Grid.Cells[1,4] := 'Show a <A href="message">messagebox</A>.';

  // simple formula
  Grid.Cells[1,5] := 'x<SUB>1</SUB> + x<SUB>2</SUB> = y<SUP>2</SUP>';

  Grid.Cells[1,6] := 'Look! A <SHAD>shadow</SHAD>';

  Grid.Cells[1,7] := 'That''s the <HI>highlight</HI> of the show!';
  Grid.Cells[1,8] := '<UL><LI type="image" name="TEST">My logo!</UL>';
end;


end.
