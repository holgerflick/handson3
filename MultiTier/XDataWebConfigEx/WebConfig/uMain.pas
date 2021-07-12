unit uMain;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.StdCtrls, WEBLib.StdCtrls, Vcl.Controls,
  XData.Web.Client, XData.Web.Connection, uServiceController;

type
  TFrmMain = class(TWebForm)
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
    procedure DoMonitor;

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

uses
  uMonitor;

procedure TFrmMain.btnMonitorClick(Sender: TObject);
begin
  DoMonitor;
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

procedure TFrmMain.DoMonitor;
var
  LPopup: TFrmMonitor;
begin
  LPopup := TFrmMonitor.CreateNew(
     // after create
     procedure ( AFrm: TObject )
     var
       LFrm: TFrmMonitor;

     begin
       LFrm := TFrmMonitor( AFrm );
       LFrm.Caption := 'Server Monitoring Dashboard';
     end
   );
   LPopup.Popup := true;
   LPopup.Border := fbDialog;

    LPopup.ShowModal(
    procedure (AResult: Integer )
    begin
      //
    end
   );
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
  LController: TServiceController;

begin
  LController := TServiceController.Instance;

  LController.Settings.BaseUrl := txtBaseUrl.Text;
  LController.Settings.DatabaseName := txtDatabaseName.Text;
  LController.Settings.DatabaseUsername := txtDatabaseUsername.Text;
  LController.Settings.DatabasePassword := txtDatabasePassword.Text;
  LController.Settings.DatabaseServer := txtDatabaseServer.Text;
  LController.Settings.DatabasePort := txtDatabasePort.Text;

  LController.SaveData(
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
  LController: TServiceController;

begin
  LController := TServiceController.Instance;

  txtDatabaseName.Text := LController.Settings.DatabaseName;
  txtDatabaseUserName.Text := LController.Settings.DatabaseUsername;
  txtDatabasePassword.Text := LController.Settings.DatabasePassword;
  txtDatabaseServer.Text := LController.Settings.DatabaseServer;
  txtDatabasePort.Text := LController.Settings.DatabasePort;
  txtBaseUrl.Text := LController.Settings.BaseUrl;
end;

procedure TFrmMain.WebFormCreate(Sender: TObject);
begin
  btnStart.Visible := False;
  btnStop.Visible := False;
  btnMonitor.Visible := False;

  TServiceController.Instance.OnConnect := OnConnect;
  TServiceController.Instance.Connect;
end;

end.
 