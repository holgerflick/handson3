unit Modules.DBController;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.DApt,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, Data.DB, FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TDBController = class(TDataModule)
    Connection: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    function GetDatabaseFilename:String;
  public
    { Public declarations }
    procedure GetStates( AList: TStrings );
    function GetSelectQuery(AState:String): TFDQuery;
  end;

var
  DBController: TDBController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.IOUtils;


procedure TDBController.DataModuleCreate(Sender: TObject);
begin
  Connection.Params.DriverID := 'SQLite';
  Connection.Params.Database := self.GetDatabaseFilename;
  Connection.FetchOptions.RecordCountMode := cmTotal;
  Connection.LoginPrompt := False;
end;

function TDBController.GetDatabaseFilename: String;
begin
  Result := TPath.Combine( TPath.GetHomePath, 'covidex.db' );
end;

function TDBController.GetSelectQuery(AState:String): TFDQuery;
begin
  Result := TFDQuery.Create(self);

  Result.Connection := self.Connection;
  Result.SQL.Text := 'SELECT * FROM states WHERE state = :state ORDER BY day DESC';
  Result.ParamByName('state').AsString := AState;
end;

procedure TDBController.GetStates(AList: TStrings);
var
  LQuery: TFDQuery;

begin
  if Assigned( AList ) then
  begin
    LQuery := TFDQuery.Create(nil);
    try
      LQuery.Connection := self.Connection;

      LQuery.SQL.Text := 'SELECT DISTINCT state FROM states ORDER BY state';
      LQuery.Open;

      AList.Clear;
      while not LQuery.Eof do
      begin
        AList.Add( LQuery.FieldByName('state').AsString );
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
  end;
end;

end.
