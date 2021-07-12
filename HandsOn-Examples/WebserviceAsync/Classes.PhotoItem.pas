unit Classes.PhotoItem;

interface

uses
  System.Generics.Collections,
  SysUtils,
  JSON,
  Modules.ImageCache;

type
  TPhotographer = class;

  TSourceData = class;

  TSourceDict = TDictionary<string, TSourceData>;

  TPhotoItem = class
  private
    FId: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FUrl: String;
    FPhotographer: TPhotographer;
    FSourceDict: TSourceDict;
    FLiked: Boolean;
    FImageCache: TImageCache;

    procedure LoadSourcesFromJSONObject( AObj: TJSONObject );

    property Sources: TSourceDict read FSourceDict;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromJSONObject( AObj: TJSONObject );
    function GetImageUrl( ASize: String ): String;
    function GetSizes: TArray<string>;

    property ImageCache: TImageCache read FImageCache write FImageCache;

    procedure LoadImage<T>( ARef:T; ASize: String; ANotifyProc: TProc<T, TObject> );

    property Id: Integer read FId write FId;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property Url: String read FUrl write FUrl;
    property Photographer: TPhotographer read FPhotographer write FPhotographer;

    property Liked: Boolean read FLiked write FLiked;
  end;


  TPhotographer = class
  private
    FId: Integer;
    FName: String;
    FUrl: String;
  public
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property Url: String read FUrl write FUrl;
  end;

  TSourceData = class
  private
    FUrl: String;
    FSize: String;
    FData: TBytes;
  public
    property Size: String read FSize write FSize;
    property Url: String read FUrl write FUrl;
    property Data: TBytes read FData write FData;
  end;

  TPhotoItemList = class( TObjectList<TPhotoItem> )

  public
    procedure ReadFromJSONArray( AArray: TJSONArray; DoClear: Boolean = True );

  end;

implementation

{ TPhotoItem }

uses Modules.ServiceController
  ;

constructor TPhotoItem.Create;
begin
  FPhotographer := TPhotographer.Create;
  FSourceDict := TSourceDict.Create;
end;

destructor TPhotoItem.Destroy;
var
  LKey: String;
begin
  FPhotographer.Free;

  for LKey in FSourceDict.Keys do
  begin
    FSourceDict[LKey].Free;
  end;

  FSourceDict.Free;
  inherited;
end;

function TPhotoItem.GetImageUrl(ASize: String): String;
begin
  if Sources.ContainsKey(ASize) then
  begin
    Result := Sources[ ASize ].Url;
  end
  else
  begin
    raise EArgumentNilException.CreateFmt('Image size not found (%s).', [ASize]);
  end;
end;

function TPhotoItem.GetSizes: TArray<string>;
begin
  Result := Sources.Keys.ToArray;
end;

procedure TPhotoItem.LoadFromJSONObject(AObj: TJSONObject);
begin
  self.Id := AObj.Values['id'].AsType<Integer>;
  self.Width := AObj.Values['width'].AsType<Integer>;
  self.Height := AObj.Values['height'].AsType<Integer>;
  self.Url := AObj.Values['url'].AsType<string>;

  self.Photographer.Name := AObj.Values['photographer'].AsType<string>;
  self.Photographer.Url := AObj.Values['photographer_url'].AsType<string>;
  self.Photographer.Id := AObj.Values['photographer_id'].AsType<integer>;

  self.Liked := AObj.Values['liked'].AsType<boolean>;

  self.LoadSourcesFromJSONObject( AObj.Values['src'] as TJSONObject );
end;

procedure TPhotoItem.LoadImage<T>(ARef:T; ASize: String; ANotifyProc: TProc<T,TObject>);
begin
  ImageCache.LoadImage<T>( ARef, Sources[ASize].Url,
    procedure( ARef: T; ABitmap: TObject )
    begin
      ANotifyProc( ARef, ABitmap );
    end
  );
end;

procedure TPhotoItem.LoadSourcesFromJSONObject(AObj: TJSONObject);
var
  LSrc : TSourceData;
  i: Integer;
  LPair: TJSONPair;

begin
  self.Sources.Clear;

  for i := 0 to AObj.Count-1 do
  begin
    LSrc := TSourceData.Create;
    LPair := AObj.Pairs[i];
    LSrc.Url := LPair.JsonValue.Value;
    LSrc.Size := LPair.JsonString.Value;

    self.Sources.Add( LSrc.Size, LSrc );
  end;
end;

{ TPhotoItemList }

procedure TPhotoItemList.ReadFromJSONArray(AArray: TJSONArray;
  DoClear: Boolean = True);
var
  i: Integer;
  LObj: TJSONObject;
  LPhoto : TPhotoItem;

begin
  if Assigned( AArray ) then
  begin

    if DoClear then
    begin
      self.Clear;
    end;

    for i := 0 to AArray.Count-1 do
    begin
      LObj := AArray[i] as TJSONObject;

      LPhoto := TPhotoItem.Create;
      LPhoto.LoadFromJSONObject( LObj );
      self.Add(LPhoto);
    end;
  end;
end;

end.
