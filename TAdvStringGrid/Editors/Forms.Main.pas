unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure GridResize(Sender: TObject);
    procedure GridCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
    procedure GridGetEditorType(Sender: TObject; ACol, ARow: Integer; var AEditor: TEditorType);
  private
    { Private declarations }
    procedure BuildGrid;
    procedure Fit;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses TypInfo;

procedure TFrmMain.BuildGrid;
var
  LType: TEditorType;

begin
  Grid.ColCount := 2;

  Grid.RowCount := GetTypeData( TypeInfo( TEditorType ) ).MaxValue;

  Grid.Cells[0,0] := 'Type';
  Grid.Cells[1,0] := 'Test';

  for LType := Low( TEditorType ) to High( TEditorType ) do
  begin
    Grid.Cells[ 0, ORD( LType ) + 1 ] := GetEnumName( TypeInfo( TEditorType ), ORD(LType) );
  end;

  Fit;
end;

procedure TFrmMain.Fit;
begin
  Grid.AutoSizeRows(true,5);
  Grid.AutoFitColumns(true);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  BuildGrid;
end;

procedure TFrmMain.GridCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 1;
end;

procedure TFrmMain.GridGetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
  if ACol = 1 then
  begin
    AEditor := TEditorType( GetEnumValue( TypeInfo(TEditorType),
    (Sender as TAdvStringGrid).Cells[0,ARow] ) );
  end;
end;

procedure TFrmMain.GridResize(Sender: TObject);
begin
  Fit;
end;

end.
