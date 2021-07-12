unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Data.DB, Modules.DBController, Vcl.StdCtrls;

type
  TFrmMain = class(TForm)
    Grid: TDBAdvGrid;
    dsStates: TDataSource;
    cbStates: TComboBox;
    btnDisplay: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnDisplayClick(Sender: TObject);
    procedure cbStatesClick(Sender: TObject);
    procedure GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
  private
    { Private declarations }
    FDBController: TDBController;

    procedure InitGrid;
    procedure InitStates;
    procedure SelectedState(AState:String);
    procedure AddColumnToGrid(
      AGrid: TDBAdvGrid;
      AFieldName: String;
      ACaption: String);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  System.Generics.Collections;

procedure TFrmMain.AddColumnToGrid(AGrid: TDBAdvGrid; AFieldName,
  ACaption: String);
var
  LColumn: TDBGridColumnItem;
begin
  LColumn := AGrid.Columns.Add;
  LColumn.FieldName := AFieldName;
  LColumn.Header := ACaption;
end;

procedure TFrmMain.btnDisplayClick(Sender: TObject);
begin
  SelectedState(cbStates.Text);
end;

procedure TFrmMain.cbStatesClick(Sender: TObject);
begin
  btnDisplay.Enabled := (cbStates.Text <> String.Empty);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FDBController := TDBController.Create(self);

  InitGrid;
  InitStates;
end;

procedure TFrmMain.GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ARow > 0) AND (ACol > 1) then
  begin
    HAlign := taRightJustify;
  end;
end;

procedure TFrmMain.GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);

begin
  if (ARow > 0) then
  begin
    if (ACol > 1) then
    begin
      Value := Format( '%.0n', [Value.ToDouble] );
    end;
  end;
end;

procedure TFrmMain.InitGrid;
begin
  Grid.BeginUpdate;
  try
    Grid.AutoCreateColumns := False;
    Grid.AutoRemoveColumns := False;

    Grid.Columns.Clear;
    Grid.ColCount := 1;

    Grid.Options := Grid.Options + [ goRowSelect ];
    Grid.PageMode := True;

    AddColumnToGrid( Grid, 'day', 'Date' );
    AddColumnToGrid( Grid, 'cases', '# Cases');
    AddColumnToGrid( Grid, 'deaths', '# Deaths' );
    AddColumnToGrid( Grid, 'dailyCases', '# Daily Cases' );
    AddColumnToGrid( Grid, 'dailyDeaths', '# Daily Deaths' );

    Grid.Visible := False;

  finally
    Grid.EndUpdate;
  end;
end;

procedure TFrmMain.InitStates;
var
  LList: TStringList;
  i: Integer;

begin
  LList := TStringList.Create;
  try
    FDBController.GetStates( LList );

    if LList.Count > 0 then
    begin
      cbStates.Items.Assign( LList );
      cbStates.ItemIndex := 0;
    end;
  finally
    LList.Free;
  end;
end;

procedure TFrmMain.SelectedState(AState:String);
begin
  Grid.BeginUpdate;
  try
    Grid.DataSource := dsStates;

    if Assigned( dsStates.DataSet ) then
    begin
      dsStates.DataSet.Close;
      dsStates.DataSet.Free;
    end;

    dsStates.DataSet := FDBController.GetSelectQuery(AState);
    dsStates.DataSet.Active := True;
    Grid.FixedCols := 1;

    Grid.AutoSizeColumns(False, 4);

    Grid.Visible := True;
  finally
    Grid.EndUpdate;
  end;
end;

end.
