unit uServerSettings;
{$M+}

interface

uses
  System.Types, System.SysUtils;

type
  TServerSettings = class
  private
    FDatabaseName: String;
    FDatabaseUsername: String;
    FDatabasePassword: String;
    FBaseUrl: String;
    FDatabaseServer: String;
    FDatabasePort: String;

    function GetFilename: String;
  public
    procedure LoadFromFile;
    procedure SaveToFile;


  published
    property DatabaseServer: String read FDatabaseServer write FDatabaseServer;
    property DatabasePort: String read FDatabasePort write FDatabasePort;
    property DatabaseName: String read FDatabaseName write FDatabaseName;

    property DatabaseUsername: String read FDatabaseUsername write FDatabaseUsername;
    property DatabasePassword: String read FDatabasePassword write FDatabasePassword;

    property BaseUrl: String read FBaseUrl write FBaseUrl;

    property Filename: String read GetFilename;
  end;


implementation

{ TServerSettings }
uses
  System.IOUtils,
  IniFiles,
  AdvUtils
  ;

const
  APP_NAME = 'XDataWebConfig';
  INI_DB = 'Database';
  INI_SERVER = 'PostalService';

function TServerSettings.GetFilename: String;
var
  LRoot: String;

begin
  LRoot :=  TPath.Combine( TPath.GetHomePath,  APP_NAME );
  Result := TPath.Combine( LRoot, 'server.ini' );
end;

procedure TServerSettings.LoadFromFile;
var
  LIni: TIniFile;

begin
  if TFile.Exists( Filename ) then
  begin
    LIni := TIniFile.Create( Filename );
    try
      self.DatabaseServer := LIni.ReadString( INI_DB, 'Server', '' );
      self.DatabasePort := LIni.ReadString( INI_DB, 'Port', '3306' );
      self.DatabaseName := LIni.ReadString( INI_DB, 'Name', 'postal' );
      self.DatabaseUsername := LIni.ReadString( INI_DB, 'Username', 'sysdba' );
      self.DatabasePassword :=  TAdvUtils.EnDeCrypt(
        LIni.ReadString( INI_DB, 'Password', '' )
        );

      self.BaseUrl := LIni.ReadString( INI_SERVER, 'BaseUrl', 'http://+:2001' );
    finally
      LIni.Free;
    end;
  end;
end;

procedure TServerSettings.SaveToFile;
var
  LIni: TIniFile;
  LDir: String;
begin
  LDir := TPath.GetDirectoryName(Filename);

  if not TDirectory.Exists(LDir) then
  begin
    TDirectory.CreateDirectory( LDir );
  end;

  LIni := TIniFile.Create(Filename);
  try
    LIni.WriteString( INI_DB, 'Server', self.DatabaseServer );
    LIni.WriteString( INI_DB, 'Port', self.DatabasePort );
    LIni.WriteString( INI_DB, 'Name', self.DatabaseName );
    LIni.WriteString( INI_DB, 'Username', self.DatabaseUsername );
    LIni.WriteString( INI_DB, 'Password',
      TAdvUtils.EnDeCrypt( self.DatabasePassword )
      );

    LIni.WriteString( INI_SERVER, 'BaseUrl', self.BaseUrl );
  finally
    LIni.Free;
  end;
end;

end.
