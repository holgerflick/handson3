program AutoSizing;

{$R *.dres}

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  Helper.TAdvSVGImageCollection in 'Helper.TAdvSVGImageCollection.pas',
  Helper.TAdvStringGrid in 'Helper.TAdvStringGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
