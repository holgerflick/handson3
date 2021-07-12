unit Modules.DBController;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.DApt,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TDBController = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FConnection: TFDConnection;

    function GetDatabaseFilename:String;
  public
    { Public declarations }
    function GetSelectQuery: TFDQuery;

    property Connection: TFDConnection read FConnection write FConnection;
  end;

var
  DBController: TDBController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.IOUtils, DateUtils;

procedure TDBController.DataModuleCreate(Sender: TObject);
begin
  Connection := TFDConnection.Create(self);
  Connection.Params.DriverID := 'SQLite';
  Connection.Params.Database := self.GetDatabaseFilename;
  Connection.FetchOptions.RecordCountMode := cmTotal;
  Connection.LoginPrompt := False;
end;

function TDBController.GetDatabaseFilename: String;
begin
  Result := TPath.Combine( TPath.GetHomePath, 'covidex.db' );
end;

function TDBController.GetSelectQuery: TFDQuery;
var
  LCutOffDate: TDateTime;
  LFormat: TFormatSettings;

begin
  // just display last 90 days
  LCutOffDate := Incday( Now, - 90 );

  Result := TFDQuery.Create(self);
  Result.Connection := self.Connection;
  Result.SQL.Text := 'SELECT * FROM states '+
    'WHERE ( DATE(day) >  DATE(:cutoff) ) ' +
    'ORDER by state, DATE(day) DESC';

  // prepare formatting
  LFormat := TFormatSettings.Create;
  LFormat.ShortDateFormat := 'YYYY-MM-dd';

  // assign parameter
  Result.Params.ParamByName('cutoff').AsString :=
    DateToStr( LCutOffDate, LFormat );
end;

end.
