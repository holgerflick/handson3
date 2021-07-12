program XDataWebConfigEx;
uses
  Vcl.Forms,
  uServerContainer in 'uServerContainer.pas' {ServerContainer: TDataModule},
  uFrmMain in 'uFrmMain.pas' {MainForm},
  Server.Runner in '..\Template\Server.Runner.pas',
  Server.Service in '..\Template\Server.Service.pas' {ServerWinService: TService},
  uConfigService in 'uConfigService.pas',
  uConfigServiceImplementation in 'uConfigServiceImplementation.pas',
  uServerSettings in 'uServerSettings.pas',
  uServerStatus in 'uServerStatus.pas',
  uDataServerContainer in 'uDataServerContainer.pas' {DataServerContainer: TDataModule},
  Entities.PostalItem in 'PostalService\Entities.PostalItem.pas',
  uDbController in 'PostalService\uDbController.pas' {DbController: TDataModule},
  PostalServiceImpl in 'PostalService\PostalServiceImpl.pas',
  PostalServiceInt in 'PostalService\PostalServiceInt.pas',
  uMonitorService in 'uMonitorService.pas',
  uMonitorServiceImpl in 'uMonitorServiceImpl.pas',
  uMonitorClasses in 'uMonitorClasses.pas';

{$R *.res}

begin

  {$IFDEF DEBUG}
  Application.StandAlone := True;
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TServerWinService, ServerWinService);
  Application.Run;

end.
