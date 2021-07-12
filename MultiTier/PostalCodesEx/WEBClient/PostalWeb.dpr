program PostalWeb;

uses
  Vcl.Forms,
  WEBLib.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain: TWebForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
