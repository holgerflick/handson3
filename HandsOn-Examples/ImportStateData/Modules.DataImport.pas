unit Modules.DataImport;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.DApt,
  Data.DB, FireDAC.Comp.Client;

type
  TDataImport = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    Connection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function GetDatabaseFilename: String;

    procedure InitDb;
  public
    { Public declarations }
    procedure Import( AFilename: String; AUpdateUIProc : TProc<Integer,Integer> );

    procedure AddDailyNumbers( AUpdateUIProc: TProc<Integer,Integer>);
  end;

var
  DataImport: TDataImport;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.IOUtils,
  FireDAC.Stan.Param;

CONST
  SQL_CREATE = 'CREATE TABLE IF NOT EXISTS states ( day DATE, fips INT, state VARCHAR(50), cases INT, deaths INT, dailyCases INT, dailyDeaths INT  )';
  SQL_INSERT = 'INSERT INTO states VALUES ( :day, :fips, :state, :cases, :deaths, NULL, NULL )';
  SQL_SELECT_NUMBERS = 'SELECT day, fips, cases, deaths FROM states ORDER BY fips, day';
  SQL_UPDATE_DAILY = 'UPDATE states SET dailyCases = :cases, dailyDeaths = :deaths WHERE fips = :fips AND day = :day';

{ TDataImport }

procedure TDataImport.AddDailyNumbers(AUpdateUIProc: TProc<Integer, Integer>);
var
  LUpdate,
  LSelect: TFDQuery;

  LCount,
  LCurrent,
  LLastFips,
  LCurFips: Integer;
  LLastDeaths: Integer;
  LLastCases: Integer;

begin
  self.Connection.Open;

  LUpdate := TFDQuery.Create(nil);
  LUpdate.Connection := self.Connection;

  LSelect := TFDQuery.Create(nil);
  LSelect.Connection := self.Connection;

  LLastFips := 0;

  try
    LSelect.SQL.Text := SQL_SELECT_NUMBERS;
    LSelect.Open;

    LUpdate.SQL.Text := SQL_UPDATE_DAILY;

    LCount := LSelect.RecordCount;
    LCurrent := 0;

    while not LSelect.eof do
    begin
      Inc(LCurrent);

      LCurFips := LSelect.FieldByName('fips').AsInteger;
      if LCurFips <> LLastFips then
      begin
        LLastDeaths := 0;
        LLastCases := 0;
        LLastFips := LCurFips;
      end;

      LUpdate.ParamByName('fips').AsInteger := LCurFips;
      LUpdate.ParamByName('day').AsDate := LSelect.FieldByName('day').AsDateTime;
      LUpdate.ParamByName('cases').AsInteger := LSelect.FieldByName('cases').AsInteger - LLastCases;
      LUpdate.ParamByName('deaths').AsInteger := LSelect.FieldByName('deaths').AsInteger - LLastDeaths;
      LUpdate.ExecSQL;

      if LCurrent MOD 50 = 0 then
      begin
        if Assigned( AUpdateUIProc ) then
        begin
          TThread.Synchronize( nil,
          procedure
          begin
            AUpdateUIProc( LCurrent, LCount );
          end
          );
        end;
      end;

      LLastCases := LSelect.FieldByName('cases').AsInteger;
      LLastDeaths := LSelect.FieldByName('deaths').AsInteger;

      LSelect.Next;
    end;
  finally
    LUpdate.Free;
    LSelect.Free;
  end;
end;

procedure TDataImport.DataModuleCreate(Sender: TObject);
begin
  Connection.Params.DriverID := 'SQLite';
  Connection.Params.Database := self.GetDatabaseFilename;
  Connection.FetchOptions.RecordCountMode := cmTotal;
  Connection.LoginPrompt := False;
end;

procedure TDataImport.DataModuleDestroy(Sender: TObject);
begin
  self.Connection.Close;
end;

function TDataImport.GetDatabaseFilename: String;
begin
  Result := TPath.Combine( TPath.GetHomePath, 'covidex.db' );
end;

procedure TDataImport.Import( AFilename: String; AUpdateUIProc : TProc<Integer,Integer> );
var
  LReader: TStreamReader;
  LLine: String;
  LItems: TArray<string>;

  LNo: Integer;
  LMaxBatch: Integer;

  LQuery: TFDQuery;
  LFormat: TFormatSettings;
  LTotalLines,
  LCurLine : Integer;

begin
  self.InitDb;

  LQuery := TFDQuery.Create(nil);
  LReader := TStreamReader.Create( AFilename );
  try
    LQuery.Connection := self.Connection;

    LQuery.SQL.Text := SQL_INSERT;
    LMaxBatch := 500;
    LQuery.Params.BindMode := pbByNumber;
    LQuery.Params.ArraySize := LMaxBatch;

    LFormat := TFormatSettings.Create;
    LFormat.DateSeparator := '-';
    LFormat.ShortDateFormat := 'yyyy-MM-dd';


    LTotalLines := -1;
    // count lines
    while not LReader.EndOfStream do
    begin
      Inc( LTotalLines );
      LReader.ReadLine;
    end;

    LReader.Rewind;

    // dump first line
    LReader.ReadLine;

    LNo := 0;
    LCurLine := 0;
    while not LReader.EndOfStream do
    begin
      Inc( LCurLine );

      LLine := LReader.ReadLine;
      LItems := LLine.Split([',']);

      LQuery.Params[ 0 ].AsDates[LNo] := StrToDate( LItems[0], LFormat );
      LQuery.Params[ 2 ].AsStrings[LNo] := LItems[1];
      LQuery.Params[ 1 ].AsIntegers[LNo] := LItems[2].ToInteger;
      LQuery.Params[ 3 ].AsIntegers[LNo] := LItems[3].ToInteger;
      LQuery.Params[ 4 ].AsIntegers[LNo] := LItems[4].ToInteger;

      if LCurLine MOD 50 = 0 then
      begin
        if Assigned(AUpdateUIProc) then
        begin
          TThread.Synchronize( nil,
          procedure
          begin
            AUpdateUIProc( LCurLine, LTotalLines );
          end
          );
        end;
      end;

      Inc( LNo );
      if LNo = LMaxBatch then
      begin
        LQuery.Execute( LNo, 0 );
        LNo := 0;
      end;
    end;

    LQuery.Execute( LNo, 0 );
  finally
    LReader.Free;
    LQuery.Free;
  end;

end;

procedure TDataImport.InitDb;
begin
  Connection.Open();

  Connection.ExecSQL( SQL_CREATE );
  Connection.ExecSQL( 'DELETE FROM states' );
end;

end.
