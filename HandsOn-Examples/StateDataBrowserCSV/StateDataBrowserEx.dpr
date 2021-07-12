program StateDataBrowserEx;

{$R 'CsvResource.res' 'CsvResource.rc'}

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  Forms.Wait in 'Forms.Wait.pas' {FrmWait},
  Helper.TAdvStringGrid in '..\Common\Helper.TAdvStringGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
