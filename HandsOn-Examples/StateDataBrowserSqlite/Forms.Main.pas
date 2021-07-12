unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Data.DB, Modules.DBController,
  FireDAC.Comp.Client;

type
  TFrmMain = class(TForm)
    Grid: TDBAdvGrid;
    dsStates: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FDBController: TDBController;

    procedure AddColumnToGrid( AGrid: TDBAdvGrid;
      AFieldName: String;
      ACaption: String);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}


procedure TFrmMain.AddColumnToGrid(AGrid: TDBAdvGrid; AFieldName,
  ACaption: String);
var
  LColumn: TDBGridColumnItem;
begin
  // add new columns
  LColumn := AGrid.Columns.Add;

  // set field and header
  LColumn.FieldName := AFieldName;
  LColumn.Header := ACaption;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FDBController := TDBController.Create(self);

  Grid.BeginUpdate;
  try
    // nothing is created automatically
    Grid.AutoCreateColumns := False;
    Grid.AutoRemoveColumns := False;

    // clear columns
    Grid.Columns.Clear;

    // add 1 empty column
    Grid.ColCount := 1;

    // row selection
    Grid.Options := Grid.Options + [ goRowSelect, goColSizing ];

    // no page mode
    Grid.PageMode := False;

    // add columns
    AddColumnToGrid( Grid, 'state', 'State' );
    AddColumnToGrid( Grid, 'day', 'Date' );
    AddColumnToGrid( Grid, 'cases', '# Cases');
    AddColumnToGrid( Grid, 'deaths', '# Deaths' );
    AddColumnToGrid( Grid, 'dailyCases', '# Daily Cases' );
    AddColumnToGrid( Grid, 'dailyDeaths', '# Daily Deaths' );


    // setup datasource
    dsStates.DataSet := FDBController.GetSelectQuery;
    dsStates.DataSet.Active := True;

    // set datasource
    Grid.DataSource := dsStates;

    // first column is fixed
    Grid.FixedCols := 1;

    // do not sort, query handles that
    Grid.SortSettings.AutoSortForGrouping := False;
    Grid.Group(1);

    // size columns according to their width
    Grid.AutoSizeColumns(True, 4);

    // contract all groups
    Grid.ContractAll;
  finally
    Grid.EndUpdate;
  end;
end;

end.
