program PostalServer;

uses
  Vcl.Forms,
  uServerContainer in 'uServerContainer.pas' {ServerContainer: TDataModule},
  Forms.Main in 'Forms.Main.pas' {MainForm},
  PostalServiceInt in 'PostalServiceInt.pas',
  PostalServiceImpl in 'PostalServiceImpl.pas',
  Entities.PostalItem in 'Entities.PostalItem.pas',
  Modules.DbController in 'Modules.DbController.pas' {DbController: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDbController, DbController);
  Application.Run;
end.
