unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid,
  IOUtils;

type
  TForm1 = class(TForm)
    Grid: TAdvStringGrid;
    procedure GridCellValidate(Sender: TObject; ACol, ARow: Integer;
      var Value: string; var Valid: Boolean);
    procedure GridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.GridCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := False;

  if ACol = 2 then
  begin
    CanEdit := True;
  end;
end;

procedure TForm1.GridCellValidate(Sender: TObject; ACol, ARow: Integer;
  var Value: string; var Valid: Boolean);
begin
  if ACol = 2 then
  begin
    Valid := TFile.Exists( Value );

    if not Valid then
    begin
      Grid.InvalidEntryTitle := 'File not found';
      Grid.InvalidEntryText := 'Please enter a filename that exists.';
    end;
  end;

end;

end.
