program PostalFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  Forms.Main in 'Forms.Main.pas' {Form1},
  Entities.PostalItem in '..\Server\Entities.PostalItem.pas',
  PostalServiceInt in '..\Server\PostalServiceInt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
