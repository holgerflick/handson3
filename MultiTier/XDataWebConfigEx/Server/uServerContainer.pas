unit uServerContainer;

interface

uses
  System.SysUtils, System.Classes, Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context, Sparkle.Comp.Server,
  Sparkle.Comp.HttpSysDispatcher, Aurelius.Drivers.Interfaces,
  Aurelius.Comp.Connection, XData.Comp.ConnectionPool, XData.Server.Module,
  XData.Comp.Server, Sparkle.Comp.CorsMiddleware, Sparkle.Module.Static,
  Sparkle.Comp.StaticServer,
  Bcl.Logging, TMSLoggingEventLogOutputHandler, Bcl.TMSLogging, TMSLoggingBrowserOutputHandler,
  TMSLoggingCore;

type
  TServerContainer = class(TDataModule)
    DispatcherConfig: TSparkleHttpSysDispatcher;
    ServerConfig: TXDataServer;
    ServerConfigCORS: TSparkleCorsMiddleware;
    WebServer: TSparkleStaticServer;
    DispatcherWeb: TSparkleHttpSysDispatcher;
    procedure DataModuleCreate(Sender: TObject);
  private
    function GetIsConfigServerRunning: Boolean;
    function GetWebServerBaseUrl: String;

    function Logger: ILogger;
    function GetServiceDescription: String;
    function GetServiceDisplayName: String;
    function GetServiceName: String;

  public
    procedure StartServer;
    procedure StopServer;

    property IsServerRunning: Boolean read GetIsConfigServerRunning;

    property ServiceDescription: String read GetServiceDescription;
    property ServiceName: String read GetServiceName;
    property ServiceDisplayName: String read GetServiceDisplayName;

    property WebServerBaseUrl: String read GetWebServerBaseUrl;
  end;

implementation

uses

 System.IOUtils;

resourcestring
  CServiceDescription =
    'This service shows how you can implement a Web client' +
    'application to administrate your XData Web service.';

  CServiceName =
    'XDataWebAdmin';

  CServiceDisplayName =
    'XData Web Administration Example';

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServerContainer }

procedure TServerContainer.DataModuleCreate(Sender: TObject);
begin
  RegisterTMSLogger;

  TMSDefaultLogger.RegisterOutputHandlerClass(TTMSLoggerEventLogOutputHandler, [ 'XData Web Config Example' ]);

  Logger.Info( 'Init: Config Server' );

  {$IFDEF DEBUG}
    WebServer.RootDir := TPath.Combine( TPath.GetLibraryPath, 'web' ) ;
  {$ENDIF}
end;

function TServerContainer.GetIsConfigServerRunning: Boolean;
begin
  Result := DispatcherConfig.Active;
end;

function TServerContainer.GetServiceDescription: String;
begin
  Result := CServiceDescription;
end;

function TServerContainer.GetServiceDisplayName: String;
begin
  Result := CServiceDisplayName;
end;

function TServerContainer.GetServiceName: String;
begin
  Result := CServiceName;
end;

function TServerContainer.GetWebServerBaseUrl: String;
begin
  Result := StringReplace( WebServer.BaseUrl, '+', 'localhost', [] )
end;

function TServerContainer.Logger: ILogger;
begin
  Result := LogManager.GetLogger;
end;

procedure TServerContainer.StartServer;
begin
  DispatcherConfig.Start;
  Logger.Info( 'Started: Config server' );
  {$IFDEF DEBUG}
    DispatcherWeb.Start;
    Logger.Info( 'Started: Web server' );
  {$ENDIF}
end;


procedure TServerContainer.StopServer;
begin
  DispatcherConfig.Stop;
  Logger.Info( 'Stopped: Config server' );

  {$IFDEF DEBUG}
    DispatcherWeb.Stop;
    Logger.Info( 'Stopped: Web server' );
  {$ENDIF}
end;


end.
