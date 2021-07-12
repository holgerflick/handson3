program PostalVCL;

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  Entities.PostalItem in '..\Server\Entities.PostalItem.pas',
  PostalServiceInt in '..\Server\PostalServiceInt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
