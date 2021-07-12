unit uConfigServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  uServerSettings,
  uServerStatus,
  uConfigService;


type
  [ServiceImplementation]
  TConfigService = class(TInterfacedObject, IConfigService)

    function  GetSettings: TServerSettings;
    procedure UpdateSettings( const ASettings: TServerSettings );

    function GetStatus: TServerStatus;

    function StopServer : Boolean;
    function StartServer: Boolean;
  end;

implementation

uses
  uDataServerContainer;


{ TConfigService }

function TConfigService.GetSettings: TServerSettings;
begin
  Result := TServerSettings.Create;
  Result.LoadFromFile;
end;

function TConfigService.GetStatus: TServerStatus;
begin
  Result := TServerStatus.Create( TDataServerContainer.Instance );
end;

function TConfigService.StartServer: Boolean;
begin
  TDataServerContainer.Instance.StartDataServer;
  Result := TDataServerContainer.Instance.IsDataServiceRunning;
end;

function TConfigService.StopServer: Boolean;
begin
  TDataServerContainer.Instance.StopDataServer;
  Result := TDataServerContainer.Instance.IsDataServiceRunning;
end;

procedure TConfigService.UpdateSettings(const ASettings: TServerSettings);
begin
  if Assigned( ASettings ) then
  begin
    ASettings.SaveToFile;
  end;
end;

initialization
  RegisterServiceType(TConfigService);

end.
