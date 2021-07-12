unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Helper.TAdvStringGrid;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure GridGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
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
  Grid.FixedCols := 0;

  Grid.ColCount := 3;

  Grid.Options := Grid.Options + [goColSizing, goRowSelect];
  Grid.SortSettings.Show := True;
  Grid.ColumnSize.Stretch := True;
  Grid.ColumnSize.StretchAll := True;
  Grid.LoadFromCSVResource('us');
end;

procedure TFrmMain.GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow > 0 then
  begin
    HAlign := taRightJustify;
  end
  else
  begin
    HAlign := taCenter;
  end;

  VAlign := vtaCenter;
end;

procedure TFrmMain.GridGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ARow > 0 then
  begin
    if ACol > 0 then
    begin
      IsFloat := True;
      FloatFormat := '%.0n';
    end;
  end;
end;

end.
