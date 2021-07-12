unit uServiceController;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Modules,
  XData.Web.Connection, XData.Web.Client, System.Generics.Collections;

type
  TProc = reference to procedure;

  TServerStartErrorProc = reference to procedure ( ACode: Integer; AMessage: String );

  TServerOnConnectEvent = procedure ( Success: Boolean ) of object;

type
  TServerSettings= class
  private
    FDatabasePassword: String;
    FBaseUrl: String;
    FDatabaseUsername: String;
    FDatabaseName: String;
    FIsRunning: Boolean;
    FDatabaseServer: String;
    FDatabasePort: String;

  public
    property DatabaseName: String read FDatabaseName write FDatabaseName;

    property DatabaseServer: String read FDatabaseServer write FDatabaseServer;
    property DatabasePort: String read FDatabasePort write FDatabasePort;

    property DatabaseUsername: String read FDatabaseUsername write FDatabaseUsername;
    property DatabasePassword: String read FDatabasePassword write FDatabasePassword;

    property BaseUrl: String read FBaseUrl write FBaseUrl;

    property IsRunning: Boolean read FIsRunning write FIsRunning;
  end;


  TMonitorDiskInfo = class
  strict private
    FName: String;
    FMBytesAvail: Cardinal;
    FMBytesSize: Cardinal;
  private
    function GetPctUsed: Double;

  published
    property Name: String read FName write FName;

    property MBytesAvail: Cardinal read FMBytesAvail write FMBytesAvail;
    property MBytesSize: Cardinal read FMBytesSize write FMBytesSize;

    property PctUsed: Double read GetPctUsed;
  end;

  TMonitorDiskInfos = TObjectList<TMonitorDiskInfo>;

  TMonitorMemoryInfo = class
  strict private
    FMBytesTotal: Cardinal;
    FMBytesAvail: Cardinal;
    FUpdated : Boolean;
  private
    function GetMBytesUsed: Cardinal;

  published
    property Updated: Boolean read FUpdated write FUpdated;
    property MBytesTotal: Cardinal read FMBytesTotal write FMBytesTotal;
    property MBytesAvail: Cardinal read FMBytesAvail write FMBytesAvail;
    property MBytesUsed: Cardinal read GetMBytesUsed;

  end;


type
  TServiceController = class(TWebDataModule)
    Client: TXDataWebClient;
    Connection: TXDataWebConnection;
    procedure WebDataModuleCreate(Sender: TObject);
    procedure WebDataModuleDestroy(Sender: TObject);
    procedure ConnectionConnect(Sender: TObject);
    procedure ConnectionError(Error: TXDataWebConnectionError);
  private
    { Private declarations }
    FSettings: TServerSettings;
    FOnConnect: TServerOnConnectEvent;
    FDiskInfo: TMonitorDiskInfos;
    FMemoryInfo: TMonitorMemoryInfo;

    class var FInstance: TServiceController;

    procedure AddDiskInfo( AValue: JSValue );
    procedure ReadMemoryInfo( AValue: JSValue );

  public
    { Public declarations }
    class function Instance: TServiceController;
    class destructor Destroy;

    procedure Connect;
    function IsConnected: Boolean;


    procedure SaveData( OnComplete: TProc = nil );
    procedure ReloadData( OnCompleteSettings: TProc =nil; OnCompleteServer: TProc = nil );

    procedure GetMonitoringInfo( OnCompleteMonitoring: TProc = nil );

    procedure StartServer( OnComplete: TProc = nil; OnError: TServerStartErrorProc = nil );
    procedure StopServer( OnComplete: TProc = nil );

    property OnConnect: TServerOnConnectEvent read FOnConnect write FOnConnect;
    property Settings: TServerSettings read FSettings write FSettings;

    property MemoryInfo: TMonitorMemoryInfo read FMemoryInfo;
    property StorageInfo: TMonitorDiskInfos read FDiskInfo;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceController.AddDiskInfo(AValue: JSValue);
var
  LValue: TJSObject;
  LDisk: TMonitorDiskInfo;

begin
  LValue := TJSObject( AValue );

  LDisk := TMonitorDiskInfo.Create;
  LDisk.Name :=  string( LValue['Name'] );
  LDisk.MBytesAvail := cardinal( LValue['MBytesAvail'] );
  LDisk.MBytesSize := cardinal( LValue['MBytesSize'] );

  FDiskInfo.Add( LDisk );
end;

procedure TServiceController.Connect;
begin
  Connection.Connected := True;
end;

procedure TServiceController.ConnectionConnect(Sender: TObject);
begin
  if Assigned( FOnConnect ) then
  begin
    FOnConnect( True );
  end;
end;

procedure TServiceController.ConnectionError(Error: TXDataWebConnectionError);
begin
  if Assigned( OnConnect ) then
  begin
    OnConnect( False );
  end;
end;

class destructor TServiceController.Destroy;
begin
  FInstance.Free;
end;

procedure TServiceController.GetMonitoringInfo(OnCompleteMonitoring: TProc);
begin
  Client.RawInvoke( 'IMonitorService.GetAllInfos', [],
    procedure ( Response: TXDataClientResponse )
    var
      LRoot: TJSObject;
      LDiskInfo: TJSObject;
      LMemory: TJSObject;
      LStorage: TJSArray;
      i: Integer;

    begin
      LRoot := TJSObject( Response.Result );

      if Assigned( LRoot ) then
      begin
        FDiskInfo.Clear;
        FMemoryInfo.Updated := False;

        LStorage := TJSArray( LRoot['Storage'] );

        if Assigned( LStorage )  then
        begin
          for i := 0 to LStorage.Length-1 do
          begin
            AddDiskInfo( LStorage[i] );
          end;
        end;

        LMemory := TJSObject( LRoot['Memory'] );
        ReadMemoryInfo( LMemory );

        if Assigned( OnCompleteMonitoring ) then
        begin
          OnCompleteMonitoring;
        end;
      end;
    end
  );
end;

class function TServiceController.Instance: TServiceController;
begin
  if not Assigned( FInstance ) then
  begin
    FInstance := TServiceController.Create(nil);
  end;

  Result := FInstance;
end;

function TServiceController.IsConnected: Boolean;
begin
  Result := Connection.Connected;
end;

procedure TServiceController.ReadMemoryInfo(AValue: JSValue);
var
  LValue: TJSObject;

begin
  if Assigned( AValue ) then
  begin
    LValue := TJSObject( AValue );

    FMemoryInfo.Updated := True;
    FMemoryInfo.MBytesTotal := cardinal( LValue['MBytesTotal'] );
    FMemoryInfo.MBytesAvail := cardinal( LValue['MBytesAvail'] );
  end;
end;

procedure TServiceController.ReloadData(OnCompleteSettings:TProc; OnCompleteServer: TProc);
begin
  Client.RawInvoke('IConfigService.GetSettings', [],
    procedure ( Response: TXDataClientResponse )
    var
      LSettings: TJSObject;

    begin
      if Response.StatusCode = 200 then
      begin
        LSettings :=  TJSObject( Response.Result );

        FSettings.BaseUrl := string( LSettings['BaseUrl'] );
        FSettings.DatabaseName := string( LSettings['DatabaseName'] );
        FSettings.DatabaseUsername := string( LSettings['DatabaseUsername'] );
        FSettings.DatabasePassword := string( LSettings['DatabasePassword'] );
        FSettings.DatabasePort := string( LSettings['DatabasePort'] );
        FSettings.DatabaseServer := string( LSettings['DatabaseServer'] );

        if Assigned( OnCompleteSettings ) then
        begin
          OnCompleteSettings;
        end;
      end;

    end
  );

  Client.RawInvoke( 'IConfigService.GetStatus', [],
     procedure ( Response: TXDataClientResponse )
     var
       LState: TJSObject;
       LBool: Boolean;
     begin
      if Response.StatusCode = 200 then
      begin
        LState := TJSObject( Response.Result );

        LBool := boolean( LState['IsRunning'] );

        FSettings.IsRunning := LBool;

        if Assigned( OnCompleteServer ) then
        begin
          OnCompleteServer;
        end;
      end;
     end
  );
end;

procedure TServiceController.SaveData(OnComplete: TProc);
var
  LSettings: TJSObject;

begin
  LSettings := TJSObject.new;
  LSettings['BaseUrl'] := FSettings.BaseUrl;
  LSettings['DatabaseName'] := FSettings.DatabaseName;
  LSettings['DatabaseUsername'] := FSettings.DatabaseUsername;
  LSettings['DatabasePassword'] := FSettings.DatabasePassword;
  LSettings['DatabasePort'] := FSettings.DatabasePort;
  LSettings['DatabaseServer'] := FSettings.DatabaseServer;

  Client.RawInvoke('IConfigService.UpdateSettings', [ LSettings ],
  procedure (R: TXDataClientResponse)
  begin
    if Assigned( OnComplete ) then
    begin
      OnComplete;
    end;
  end
  );
end;

procedure TServiceController.StartServer(OnComplete: TProc; OnError: TServerStartErrorProc);
begin
 Client.RawInvoke('IConfigService.StartServer', [],
    procedure (Response: TXDataClientResponse )
    begin
      if Assigned( OnComplete ) then
      begin
        OnComplete;
      end;
    end,
    procedure (Error: TXDataClientError)
    begin
      if Assigned( OnError ) then
      begin
        OnError( Error.StatusCode, Error.ErrorMessage );
      end;
    end
  );
end;

procedure TServiceController.StopServer(OnComplete: TProc);
begin
 Client.RawInvoke('IConfigService.StopServer', [],
    procedure (Response: TXDataClientResponse )
    begin
      if Assigned( OnComplete ) then
      begin
        OnComplete;
      end;
    end
  );
end;

procedure TServiceController.WebDataModuleCreate(Sender: TObject);
begin
  FSettings := TServerSettings.Create;
  FDiskInfo := TMonitorDiskInfos.Create;
  FMemoryInfo := TMonitorMemoryInfo.Create;
  FMemoryInfo.Updated := False;
end;

procedure TServiceController.WebDataModuleDestroy(Sender: TObject);
begin
  Connection.Close;

  FMemoryInfo.Free;
  FDiskInfo.Free;
  FSettings.Free;
end;


{ TMonitorDiskInfo }

function TMonitorDiskInfo.GetPctUsed: Double;
var
  LUsed: Cardinal;

begin
  Result := 0;
  if self.MBytesSize > 0 then
  begin
    LUsed := self.MBytesSize - self.MBytesAvail;
    Result := LUsed / self.MBytesSize;
  end;

end;

{ TMonitorMemoryInfo }

function TMonitorMemoryInfo.GetMBytesUsed: Cardinal;
begin
  Result := self.MBytesTotal - self.MBytesAvail;
end;

end.
