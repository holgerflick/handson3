program SortingEx;

{$R 'data.res' 'data.rc'}

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  Helper.TAdvStringGrid in '..\..\HandsOn-Examples\Common\Helper.TAdvStringGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
