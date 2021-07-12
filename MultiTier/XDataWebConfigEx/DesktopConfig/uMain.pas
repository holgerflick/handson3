unit uMain;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, Vcl.StdCtrls, WEBLib.StdCtrls,
  Vcl.Controls, uServiceController;

type
  TFrmMain = class(TMiletusForm)
    txtDatabasePassword: TWebEdit;
    txtDatabaseName: TWebEdit;
    txtBaseUrl: TWebEdit;
    txtDatabaseUserName: TWebEdit;
    btnReload: TWebButton;
    btnSave: TWebButton;
    txtState: TWebEdit;
    btnStop: TWebButton;
    btnStart: TWebButton;
    txtDatabasePort: TWebEdit;
    txtDatabaseServer: TWebEdit;
    btnMonitor: TWebButton;
    WMonitor: TMiletusWindow;

    procedure btnReloadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);

    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    procedure btnMonitorClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoSave;
    procedure DoReload;

    procedure DoStart;
    procedure DoStop;

    procedure OnConnect( Success: Boolean );
    procedure UpdateSettings;
    procedure UpdateServerStatus;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses uMonitor;

procedure TFrmMain.btnMonitorClick(Sender: TObject);
begin
  WMonitor.Show;
end;

procedure TFrmMain.btnReloadClick(Sender: TObject);
begin
  DoReload;
end;

procedure TFrmMain.btnSaveClick(Sender: TObject);
begin
  DoSave;
end;

procedure TFrmMain.btnStartClick(Sender: TObject);
begin
  DoStart;
end;

procedure TFrmMain.btnStopClick(Sender: TObject);
begin
  DoStop;
end;

procedure TFrmMain.DoReload;
begin
  TServiceController.Instance.ReloadData(
    procedure
    begin
      UpdateSettings;
    end,
    procedure
    begin
      UpdateServerStatus;
    end
  );
end;


procedure TFrmMain.DoSave;
var
  LSettings: TServerSettings;

begin
  LSettings := TServiceController.Instance.Settings;
  LSettings.BaseUrl := txtBaseUrl.Text;
  LSettings.DatabaseName := txtDatabaseName.Text;
  LSettings.DatabaseUsername := txtDatabaseUsername.Text;
  LSettings.DatabasePassword := txtDatabasePassword.Text;
  LSettings.DatabaseServer := txtDatabaseServer.Text;
  LSettings.DatabasePort := txtDatabasePort.Text;

  TServiceController.Instance.SaveData(
   procedure
   begin
    ShowMessage( 'Data has been saved.' );
   end
  );
end;

procedure TFrmMain.DoStart;
begin
  TServiceController.Instance.StartServer(
    procedure
    begin
      DoReload;
    end,
    procedure ( AStatusCode: Integer; AMessage: String )
    begin
      MessageDlg( Format( 'Starting server failed.<br/>%s', [AMessage] ),
        mtError, [mbOK] );
    end
  );
end;

procedure TFrmMain.DoStop;
begin
  TServiceController.Instance.StopServer(
    procedure
    begin
      DoReload;
    end
  );
end;

procedure TFrmMain.OnConnect(Success: Boolean);
begin
  if Success then
  begin
    btnSave.Visible := True;
    btnReload.Visible := True;
    btnMonitor.Visible := True;
    DoReload;
  end
  else
  begin
    ShowMessage( 'Could not connect to the configuration service.' );
  end;
end;

procedure TFrmMain.UpdateServerStatus;
begin
  if TServiceController.Instance.Settings.IsRunning then
  begin
    txtState.Text := 'Running.';
  end
  else
  begin
    txtState.Text := 'Stopped.';
  end;

  btnStop.Visible := TServiceController.Instance.Settings.IsRunning;
  btnStart.Visible := NOT btnStop.Visible;
end;

procedure TFrmMain.UpdateSettings;
var
  LSettings: TServerSettings;

begin
  LSettings := TServiceController.Instance.Settings;

  txtDatabaseName.Text := LSettings.DatabaseName;
  txtDatabaseUserName.Text := LSettings.DatabaseUsername;
  txtDatabasePassword.Text := LSettings.DatabasePassword;
  txtDatabaseServer.Text := LSettings.DatabaseServer;
  txtDatabasePort.Text := LSettings.DatabasePort;
  txtBaseUrl.Text := LSettings.BaseUrl;
end;

procedure TFrmMain.WebFormCreate(Sender: TObject);
begin
  // assign form class to monitor window component
  WMonitor.FormClass := TFrmMonitor;

  btnStart.Visible := False;
  btnStop.Visible := False;

  TServiceController.Instance.OnConnect := self.OnConnect;
  TServiceController.Instance.Connect;

  ClientHeight := 1035;
end;

initialization
  RegisterClass(TFrmMain);

end.