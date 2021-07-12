unit uDataServerContainer;

interface

uses
  System.SysUtils, System.Classes, XData.Server.Module,
  Sparkle.HttpServer.Module, Sparkle.HttpServer.Context, Sparkle.Comp.Server,
  Sparkle.Comp.CorsMiddleware, XData.Comp.Server, Sparkle.Comp.HttpSysDispatcher,
  Sparkle.HttpSys.Config,
  Bcl.Logging;

type
  TDataServerContainer = class(TDataModule)
    DispatcherData: TSparkleHttpSysDispatcher;
    ServerData: TXDataServer;
    ServerDataCORS: TSparkleCorsMiddleware;
  private
    { Private declarations }
    function GetIsDataServiceRunning: Boolean;

    procedure LoadSettings;

    class var FInstance: TDataServerContainer;

//    procedure AddReservation;
//    procedure RemoveReservation;

    function Logger: ILogger;

  public
    { Public declarations }

    // generic call for multiple data servers
    // class function Instance( const AModel, ABaseURL : String ): TDataServerContainer;

    class function Instance: TDataServerContainer;

    class destructor Destroy;

    procedure StartDataServer;
    procedure StopDataServer;

    property IsDataServiceRunning: Boolean read GetIsDataServiceRunning;
  end;


implementation

uses
  uServerSettings;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

//procedure TDataServerContainer.AddReservation;
//var
//LConfig: THttpSysServerConfig;
//
//begin
//  LConfig := THttpSysServerConfig.Create;
//  try
//    if not LConfig.IsUrlReserved( self.ServerData.BaseUrl ) then
//    begin
//      LConfig.ReserveUrl( self.ServerData.BaseUrl, [ TSidType.Everyone ] );
//    end;
//  finally
//    LConfig.Free;
//  end;
//end;

class destructor TDataServerContainer.Destroy;
begin
  FInstance.Free;
end;

function TDataServerContainer.GetIsDataServiceRunning: Boolean;
begin
  Result := DispatcherData.Active;
end;

class function TDataServerContainer.Instance: TDataServerContainer;
begin
  if not Assigned( FInstance ) then
  begin
    FInstance := TDataServerContainer.Create( nil );
  end;

  Result := FInstance;
end;

procedure TDataServerContainer.LoadSettings;
var
  LSettings: TServerSettings;

begin
  LSettings := TServerSettings.Create;
  try
    LSettings.LoadFromFile;

    self.ServerData.BaseUrl := LSettings.BaseUrl;

  finally
    LSettings.Free;
  end;
end;

function TDataServerContainer.Logger: ILogger;
begin
  Result := LogManager.GetLogger;
end;

//procedure TDataServerContainer.RemoveReservation;
//var
//  LConfig: THttpSysServerConfig;
//
//begin
//  LConfig := THttpSysServerConfig.Create;
//  try
//    if LConfig.IsUrlReserved( self.ServerData.BaseUrl ) then
//    begin
//      LConfig.RemoveUrl(self.ServerData.BaseUrl);
//    end;
//  finally
//    LConfig.Free;
//  end;
//end;

procedure TDataServerContainer.StartDataServer;
begin
  if NOT self.IsDataServiceRunning then
  begin
    LoadSettings;

//    AddReservation;
    DispatcherData.Start;
    Logger.Info('Started: Data server');
  end;
end;

procedure TDataServerContainer.StopDataServer;
begin
  DispatcherData.Stop;
  Logger.Info('Stopped: Data server');

//  RemoveReservation;
end;

end.
