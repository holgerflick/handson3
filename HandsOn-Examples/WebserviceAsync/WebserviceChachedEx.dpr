program WebserviceChachedEx;

uses
  JPEG,
  PNGImage,
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  Modules.ServiceController in 'Modules.ServiceController.pas' {ServiceController: TDataModule},
  Classes.PhotoItem in 'Classes.PhotoItem.pas',
  Modules.ImageCache in 'Modules.ImageCache.pas' {ImageCache: TDataModule},
  Forms.SelectKeywords in 'Forms.SelectKeywords.pas' {FrmSelectKeywords};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
