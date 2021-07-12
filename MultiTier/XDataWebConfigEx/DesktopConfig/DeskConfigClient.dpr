program DeskConfigClient;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  uMain in 'uMain.pas' {FrmMain: TMiletusForm} {*.html},
  uServiceController in 'uServiceController.pas' {ServiceController: TWebDataModule},
  uMonitor in 'uMonitor.pas' {FrmMonitor: TWebForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.AutoFormRoute := True;
  Application.MainFormOnTaskbar := True;
  if not Application.NeedsFormRouting then
  begin
    Application.CreateForm(TFrmMain, FrmMain);
  end;
  Application.Run;
end.
