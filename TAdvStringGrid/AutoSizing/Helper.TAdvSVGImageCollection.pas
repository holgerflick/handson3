unit Helper.TAdvSVGImageCollection;

interface

uses
  AdvTypes;

type
  TAdvSVGImageCollectionHelper = class helper for TAdvSVGImageCollection
    procedure LoadFromFolder( AFolder: String );
    procedure LoadfromZip( AZipFileName: String );
    procedure LoadFromZipResource( AResourceName : String );
  end;

implementation

{ TAdvSVGImageCollectionHelper }

uses
  AdvUtils,
  System.Classes,
  System.Generics.Collections,
  System.Zip,
  System.IOUtils,
  System.SysUtils
  ;

procedure TAdvSVGImageCollectionHelper.LoadFromFolder(AFolder: String);
var
  LFiles: TArray<string>;
  LFileName: String;
  LVector: TAdvSVGImageCollectionItem;
  LFileStream: TFileStream;

begin
  LFiles := TDirectory.GetFiles( AFolder, '*.svg' );

  self.Images.BeginUpdate;
  try
    self.Images.Clear;

    for LFileName in LFiles do
    begin
      // init a new vector
      LVector := self.Images.Add;

      // add to image collection
      LVector.Data.LoadFromFile( LFileName );
    end;

  finally
    self.Images.EndUpdate;
  end;
end;

procedure TAdvSVGImageCollectionHelper.LoadfromZip(AZipFileName: String);
var
  LZip: TZipFile;
  LFiles: TArray<string>;
  LFile: String;
  LTmpPath: String;
  LFileNameOnly: String;
  LVector: TAdvSVGImageCollectionItem;
  LFileStream: TFileStream;

begin
  LTmpPath := TAdvUtils.GetTempPath;

  self.Images.BeginUpdate;
  self.Images.Clear;

  LZip := TZipFile.Create;
  try
    LZip.Open(AZipFileName, TZipMode.zmRead);
    LFiles := LZip.FileNames;

    for LFile in LFiles do
    begin
      if LFile.ToLower.EndsWith('.svg') then
      begin
        LZip.Extract(LFile, LTmpPath, False);
        LFileNameOnly := TPath.GetFileName(LFile);

        LVector := self.Images.Add;
        LFileStream := TFile.OpenRead(
          TPath.Combine(
            LTmpPath, LFileNameOnly
          )
        );

        try
          LVector.Data.LoadFromStream(LFileStream);
        finally
          LFileStream.Free;
          if TFile.Exists(TPath.Combine( LTmpPath, LFileNameOnly )) then
          begin
            TFile.Delete(TPath.Combine( LTmpPath, LFileNameOnly ));
          end;
        end;
      end;
    end;
  finally
    LZip.Free;
    self.Images.EndUpdate;
  end;
end;

procedure TAdvSVGImageCollectionHelper.LoadFromZipResource(
  AResourceName: String);
var
  LTmpName: String;
  LStream: TResourceStream;

begin
  LTmpName := TPath.GetTempFileName;
  try
    LStream := TAdvUtils.GetResourceStream(AResourceName);
    if Assigned( LStream ) then
    begin
      LStream.SaveToFile(LTmpName);
      LoadfromZip(LTmpName);
    end
    else
    begin
      raise EResNotFound.CreateFmt('Resource %s not found', [AResourceName]);
    end;
  finally
    LStream.Free;
    if TFile.Exists(LTmpName) then
    begin
      TFile.Delete(LTmpName);
    end;
  end;

end;

end.
