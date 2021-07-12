unit Forms.SelectKeywords;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, Vcl.StdCtrls, AdvEdit,
  advlued;

type
  TFrmSelectKeywords = class(TForm)
    btnCancel: TAdvGlowButton;
    btnOK: TAdvGlowButton;
    txtKeywords: TAdvLUEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetKeywords: String;
    { Private declarations }
  public
    { Public declarations }
    property Keywords: String read GetKeywords;
  end;

var
  FrmSelectKeywords: TFrmSelectKeywords;

implementation

{$R *.dfm}

procedure TFrmSelectKeywords.FormCreate(Sender: TObject);
begin
  self.txtKeywords.Text := '';
end;

procedure TFrmSelectKeywords.FormShow(Sender: TObject);
begin
  self.txtKeywords.SetFocus;
end;

function TFrmSelectKeywords.GetKeywords: String;
begin
  Result := txtKeywords.Text;
end;

end.
