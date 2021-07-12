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
var
  LDays : Integer;
  LDate : TDateTime;

begin
  // ignore header row
  if ARow > 0 then
  begin
    // only column index 0
    if ACol = 0 then
    begin
      // convert back to date
      LDate := StrToDate( Value );

      // calculate days until date
      LDays := DaysBetween( Today, LDate );

      // set value to number of days
      Value := IntToStr( LDays );
    end;
  end;
end;

procedure TFrmMain.InitGrid;
var
  LRow: Integer;

begin
  // dimensions
  Grid.RowCount := 10;
  Grid.ColCount := 1;

  // column width
  Grid.DefaultColWidth := 85;

  // fixed cells
  Grid.FixedCols := 0;
  Grid.FixedRows := 1;

  // font
  Grid.Font.Name := 'Consolas';
  Grid.Font.Size := 9;

  // header
  Grid.Cells[ 0, 0 ] := 'Days until';

  // set up grid
  // with random dates up to 100 days in the future
  for LRow := 1 to Grid.RowCount-1 do
  begin
    Grid.Dates[ 0, LRow ] := IncDay( Today, RANDOM( 100 ) );
    Grid.Alignments[ 0, LRow ] := taRightJustify;
  end;
end;


end.
