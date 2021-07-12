unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, uServerContainer, Vcl.BaseImageCollection, AdvTypes,
  AdvGlowButton, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.VirtualImage,   Vcl.TMSFNCTypes, AdvStyleIF, AdvAppStyler;

type
  TMainForm = class(TForm)
    mmInfo: TMemo;
    Vectors: TAdvSVGImageCollection;
    Images: TVirtualImageList;
    btStart: TAdvGlowButton;
    btStop: TAdvGlowButton;
    btConfig: TAdvGlowButton;
    imgWeb: TVirtualImage;
    imgConfigAPI: TVirtualImage;
    txtPortWeb: TLabel;
    txtPortConfigAPI: TLabel;
    Images_Disabled: TVirtualImageList;
    AdvFormStyler1: TAdvFormStyler;
    procedure btStartClick(ASender: TObject);
    procedure btStopClick(ASender: TObject);
    procedure FormCreate(ASender: TObject);
    procedure btConfigClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FServerContainer: TServerContainer;

    procedure Log( AString: String );
    procedure UpdateGUI;
    function ExtractPort( AUrl: String ): String;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 ShellAPI,
  IOUtils;


resourcestring
  SServerStopped = 'Servers stopped.';
  SServerStarted = 'Servers started.';

{ TMainForm }

procedure TMainForm.btConfigClick(Sender: TObject);
begin
  ShellExecute( self.Handle, 'open',
    pChar(
       FServerContainer.WebServerBaseUrl ), '', '', 0 );
end;

procedure TMainForm.btStartClick(ASender: TObject);
begin
  FServerContainer.StartServer;
  UpdateGUI;
end;

procedure TMainForm.btStopClick(ASender: TObject);
begin
  FServerContainer.StopServer;
  UpdateGUI;
end;

function TMainForm.ExtractPort(AUrl: String): String;
var
  LP: Integer;
  LE: Integer;
begin
  AUrl := StringReplace( AUrl, 'http://', '', [rfIgnoreCase] );
  LP := POS( ':', AUrl );
  LE := POS( '/', AUrl, LP );
  Result := COPY( AUrl, LP + 1, LE - LP - 1 );
end;

procedure TMainForm.FormCreate(ASender: TObject);
begin
  mmInfo.Lines.Clear;

  FServerContainer := TServerContainer.Create(nil);

  UpdateGUI;

  {$IFNDEF DEBUG}
   imgWeb.Visible := False;
   txtPortWeb.Visible := False;
  {$ENDIF}
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FServerContainer.Free;
end;

procedure TMainForm.Log(AString: String);
begin
  mmInfo.Lines.Add(AString);
end;

procedure TMainForm.UpdateGUI;
const
  cHttp = 'http://+';
  cHttpLocalhost = 'http://localhost';
begin
  btStart.Enabled := not FServerContainer.IsServerRunning;
  btStop.Enabled := not btStart.Enabled;

  {$IFDEF DEBUG}
   btConfig.Enabled := not btStart.Enabled;
  {$ELSE}
   btConfig.Enabled := False;
  {$ENDIF}

  if FServerContainer.IsServerRunning then
  begin
    Log(SServerStarted );
  end
  else
  begin
    Log(SServerStopped);
  end;

  txtPortConfigAPI.Caption := 'Port ' + ExtractPort( FServerContainer.ServerConfig.BaseUrl );
  txtPortWeb.Caption := 'Port ' + ExtractPort( FServerContainer.WebServer.BaseUrl );
end;


end.

