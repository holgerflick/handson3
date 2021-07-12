unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvEdit, AdvEdBtn,
  Vcl.ComCtrls;

type
  TFrmMain = class(TForm)
    txtFilename: TAdvEditBtn;
    btnImport: TButton;
    Progress: TProgressBar;
    btnUpdateDaily: TButton;
    procedure btnImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateDailyClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateProgress( ACurrent, AMax: Integer );
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  Modules.DataImport;

procedure TFrmMain.btnImportClick(Sender: TObject);
begin
  btnImport.Enabled := False;
  Progress.Visible := True;
  DataImport.Import( txtFilename.Text, self.UpdateProgress );

  Progress.Visible := False;
  ShowMessage( 'Done. Created ' + DataImport.Connection.Params.Database + '.' );
  btnImport.Enabled := True;
end;

procedure TFrmMain.btnUpdateDailyClick(Sender: TObject);
begin
  btnImport.Enabled := False;
  Progress.Visible := True;

  DataImport.AddDailyNumbers( self.UpdateProgress );

  Progress.Visible := False;
  ShowMessage( 'Done.' );
  btnImport.Enabled := True;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Progress.Visible := False;
end;

procedure TFrmMain.UpdateProgress(ACurrent, AMax: Integer);
begin
   Progress.Max := AMax;
   Progress.Position := ACurrent;
end;

end.
