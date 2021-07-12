unit Server.Service;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.IOUtils, System.Win.Registry, Vcl.SvcMgr, Vcl.Dialogs,
  Bcl.Logging,
  uServerContainer;

type
  TServerWinService = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    FServerContainer: TServerContainer;
    function Logger: ILogger;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  ServerWinService: TServerWinService;

implementation


{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ServerWinService.Controller(CtrlCode);
end;

function TServerWinService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function TServerWinService.Logger: ILogger;
begin
  Result := LogManager.GetLogger;
end;

procedure TServerWinService.ServiceAfterInstall(Sender: TService);
var
   Reg: TRegistry; //declared in System.Win.Registry;
begin
   Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, False) then
    begin
      Reg.WriteString('Description', FServerContainer.ServiceDescription);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
  Logger.Debug('ServiceAfterInstall');
end;

procedure TServerWinService.ServiceAfterUninstall(Sender: TService);
begin
  Logger.Debug('ServiceAfterUninstall');
end;

procedure TServerWinService.ServiceBeforeInstall(Sender: TService);
begin
  Logger.Debug('ServiceBeforeInstall');
end;

procedure TServerWinService.ServiceBeforeUninstall(Sender: TService);
begin
  Logger.Debug('ServiceBeforeUninstall');
end;

procedure TServerWinService.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  try
    Logger.Debug('ServiceContinue');
    FServerContainer.StartServer;
  except
    on E: System.SysUtils.Exception do
    begin
      Logger.Error(E.Message);
      raise;
    end;
  end;
end;

procedure TServerWinService.ServiceCreate(Sender: TObject);
begin
  // initialize loggers

  Logger.Debug('ServiceCreate');
  FServerContainer := TServerContainer.Create(nil);
  try
    Self.Name := FServerContainer.ServiceName;
    Self.DisplayName := FServerContainer.ServiceDisplayName;
  except
    on E: System.SysUtils.Exception do
    begin
      Logger.Error(E.Message);
      raise;
    end;
  end;
end;

procedure TServerWinService.ServiceDestroy(Sender: TObject);
begin
  FServerContainer.Free;
  Logger.Debug('ServiceDestroy');
end;

procedure TServerWinService.ServicePause(Sender: TService; var Paused: Boolean);
begin
  try
    Logger.Debug('ServicePause');
    FServerContainer.StopServer;
  except
    on E: System.SysUtils.Exception do
    begin
      Logger.Error(E.Message);
      raise;
    end;
  end;
end;

procedure TServerWinService.ServiceShutdown(Sender: TService);
begin
  Logger.Debug('ServiceShutdown');
end;

procedure TServerWinService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  try
    Logger.Debug('ServiceStart');
    FServerContainer.StartServer;
  except
    on E: System.SysUtils.Exception do
    begin
      Logger.Error(E.Message);
      raise;
    end;
  end;
end;

procedure TServerWinService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  try
    Logger.Debug('ServiceStop');
    FServerContainer.StopServer;
  except
    on E: System.SysUtils.Exception do
    begin
      Logger.Error(E.Message);
      raise;
    end;
  end;
end;

end.
