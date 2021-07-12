unit Classes.AppSettings;

interface
uses
  Classes;

type
  TAppSettings = class
  private
    FSelectedFolder: String;
    FZipArchive: String;
    FExcelDocument: String;
    FIconSize: Integer;

  published
    property SelectedFolder: String read FSelectedFolder write FSelectedFolder;
    property ZipArchive: String read FZipArchive write FZipArchive;
    property ExcelDocument: String read FExcelDocument write FExcelDocument;
    property IconSize: Integer read FIconSize write FIconSize;
  end;

  TStoreSettings = class
    class procedure SaveToRegistry( const ASettings: TAppSettings );
    class procedure LoadFromRegistry( ASettings: TAppSettings );
  end;

implementation

uses
  TMSFNCTypes,
  Registry,
  SysUtils;


{ TStoreSettings }

CONST
  REG_KEY = 'Software\FlixEngineering\VectorFolderEx';
  KEY_SETTINGS = 'Settings';

class procedure TStoreSettings.LoadFromRegistry(ASettings: TAppSettings);
var
  LReg: TRegistry;
  LSettings: String;

begin
  LReg := TRegistry.Create;

  try
    if LReg.OpenKeyReadOnly(REG_KEY) then
    begin
      LSettings := LReg.ReadString( KEY_SETTINGS );
      if NOT LSettings.IsEmpty then
      begin
        ASettings.FromJSON( LSettings );
      end;
    end;

  finally
    LReg.Free;
  end;
end;

class procedure TStoreSettings.SaveToRegistry(const ASettings: TAppSettings);
var
  LReg : TRegistry;

begin
  LReg := TRegistry.Create;

  try
    if LReg.OpenKey( REG_KEY, True ) then
    begin
      LReg.WriteString( KEY_SETTINGS, ASettings.TOJSON );
    end;

  finally
    LReg.Free;
  end;
end;

end.
