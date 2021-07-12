unit Modules.ImageCache;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
   Graphics, VCL.TMSFNCCloudBase;

type
  TImageCache = class(TDataModule)
    Scripts: TFDScript;
    SQLiteLink: TFDPhysSQLiteDriverLink;
    Manager: TFDManager;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FBase: TTMSFNCCloudBase;

    function GetDatabaseName: String;
    procedure InitDatabase;
    function GetImage( AUrl: String ) : TBitmap;
    procedure AddImage( AUrl: String; ABitmap: TBitmap );
  public
    { Public declarations }
    function GetNewConnection: TFDConnection;

    procedure CancelAllRequests;

    procedure LoadImage<T>(
      ARef: T; AURL: String;
      ANotifyProc: TProc<T, TObject> = nil );

  end;


implementation

uses
  PngImage,
  IOUtils,
  Threading

    ;

const
  CONNECTION_NAME = 'Temp_Def';
  CONNECTION_FILE = 'Flix\pexels_imagecache.db';
  SQL_GET_IMAGE = 'SELECT data FROM images WHERE url = :url';
  SQL_ADD_IMAGE = 'INSERT INTO images ( url, created, data ) ' +
    ' VALUES ( :url, DATETIME(), :data )';

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TImageCache.AddImage(AUrl: String; ABitmap: TBitmap);
var
  LImage: TPngImage;
  LStream: TMemoryStream;
  LCon: TFDConnection;
  LQuery: TFDQuery;

begin
  LCon := GetNewConnection;
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := LCon;
    LQuery.SQL.Text := SQL_ADD_IMAGE;
    LQuery.ParamByName('url').AsString := AUrl;

    LImage := TPngImage.Create;
    LStream := TMemoryStream.Create;
    try
      LImage.Assign( ABitmap );
      LImage.SaveToStream(LStream);
      LStream.Position := 0;
      LQuery.ParamByName('data').LoadFromStream( LStream, ftBlob );

      LQuery.ExecSQL;
    finally
      LStream.Free;
      LImage.Free;
    end;
  finally
    LQuery.Free;
    LCon.Free;
  end;
end;

procedure TImageCache.CancelAllRequests;
begin
end;

procedure TImageCache.DataModuleCreate(Sender: TObject);
begin
  InitDatabase;

  FBase := TTMSFNCCloudBase.Create;
end;

procedure TImageCache.DataModuleDestroy(Sender: TObject);
begin
  FBase.Free;
end;

function TImageCache.GetDatabaseName: String;
begin
  Result := TPath.Combine( TPath.GetHomePath, CONNECTION_FILE );
end;

function TImageCache.GetImage(AUrl: String): TBitmap;
var
  LStream: TMemoryStream;
  LImage: TPngImage;
  LCon: TFDConnection;
  LQuery: TFDQuery;

begin
  Result := nil;

  LCon := GetNewConnection;
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := LCon;
    LQuery.SQL.Text := SQL_GET_IMAGE;
    LQuery.ParamByName('url').AsString := AUrl;

    LQuery.Active := True;

    if not LQuery.eof then
    begin
      Result := TBitmap.Create;

      LImage := TPngImage.Create;
      LImage.CompressionLevel := 9;
      LStream := TMemoryStream.Create;
      try
        TBlobField( LQuery.FieldByName('data') ).SaveToStream(LStream);
        LStream.Position := 0;

        LImage.LoadFromStream( LStream );
        Result.Width := LImage.Width;
        Result.Height := LImage.Height;
        Result.Canvas.Draw(0,0, LImage);

      finally
        LStream.Free;
        LImage.Free;
      end;
    end;
  finally
    LQuery.Free;
    LCon.Free;
  end;
end;

function TImageCache.GetNewConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.ConnectionDefName := CONNECTION_NAME;
end;

procedure TImageCache.InitDatabase;
var
  LFilename: String;
  LDir : String;

  LParams: TStringlist;
  LCon: TFDConnection;

begin
  // set up file system
  LFilename := GetDatabaseName;
  LDir := TPath.GetDirectoryName(LFilename);
  ForceDirectories(LDir);

  LParams := TStringlist.Create;
  try
    LParams.Add( Format( 'Database=%s', [LFilename] ) );
    LParams.Add('Pooled=True');
    LParams.Add('LockingMode=Normal');
    LParams.Add('Synchronous=Full');
    LParams.Add('JournalMode=Off');

    Manager.AddConnectionDef( CONNECTION_NAME, 'SQLite', LParams );
    Manager.Active := True;

    LCon := GetNewConnection;
    try
      Scripts.Connection := LCon;

      Scripts.ValidateAll;
      Scripts.ExecuteAll;
    finally
      LCon.Free;
    end;

  finally
    LParams.Free;
  end;
end;

procedure TImageCache.LoadImage<T>(ARef: T; AURL: String; ANotifyProc: TProc<T, TObject> = nil);
begin
  // start in background
  TTask.Run(
    procedure
    var
      LStream: TMemoryStream;
      LPicture: TPicture;
      LBitmap: TBitmap;


    begin
      // check cache first
      LBitmap := GetImage(AURL);

      // if Bitmap was not in cache, then retrieve
      if not Assigned(LBitmap) then
      begin
        try
          // user agent has to be set
          FBase.Request.Clear;
          FBase.Request.Agent := 'FlixEngineering LLC Example';
          FBase.Request.Host := AURL;
          FBase.Request.ResultType := rrtStream;

          // request is also retrieved in background
          //
          FBase.ExecuteRequest(
            procedure ( const AResult:TTMSFNCCloudBaseRequestResult )
            begin
              // check if response is OK
              if AResult.ResponseCode = 200 then
              begin
                // create new picture
                LPicture := TPicture.Create;
                try
                  // load picture from response
                  AResult.ResultStream.Position := 0;
                  LPicture.LoadFromStream(AResult.ResultStream);

                  // transfer to bitmap
                  LBitmap := TBitmap.Create;
                  LBitmap.Height := LPicture.Graphic.Height;
                  LBitmap.Width := LPicture.Graphic.Width;
                  LBitmap.Canvas.Draw(0,0, LPicture.Graphic);

                  // add bitmap to cache
                  if LBitmap.Width > 50 then
                  begin
                    AddImage( AURL, LBitmap );
                  end;

                  // notify
                  if Assigned( ANotifyProc ) then
                  begin
                    ANotifyProc( ARef, LBitmap );
                  end;

                finally
                  // free picture
                  LPicture.Free;
                end;
              end
              else
              begin
                // invalid request reports back nil
                ANotifyProc( ARef, nil );
              end;
            end
            );
        finally

        end;
      end
      else
      begin
        // return image from cache
        ANotifyProc( ARef, LBitmap );
      end;
    end
  );
end;


end.
