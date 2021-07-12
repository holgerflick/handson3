unit Modules.ServiceController;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,
  Classes.PhotoItem,
  System.Generics.Collections;

type
  TServiceController = class(TDataModule)
    Client: TRESTClient;
    ReqCurated: TRESTRequest;
    RespCurated: TRESTResponse;
    ReqKeywords: TRESTRequest;
    RespKeywords: TRESTResponse;
  private
    { Private declarations }

  public
    { Public declarations }
    procedure GetCuratedPhotos( ACompleteHandler:  TProc<TPhotoItemList> );

    procedure GetPhotoByKeywords( AKeywords: String; ACompleteHandler : TProc<TPhotoItemList> );

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.Threading,
  System.JSON,
  Graphics
  ;

{ TServiceController }

const
  API_KEY = '563492ad6f91700001000001ddd8ae381caf402d85b58eaed3e523c3';

procedure TServiceController.GetCuratedPhotos( ACompleteHandler: TProc<TPhotoItemList> );
begin
  if Assigned( ACompleteHandler ) then
  begin
    ReqCurated.Params.ParameterByName('Authorization').Value := API_KEY;
    ReqCurated.ExecuteAsync(
      procedure
      var
        i : Integer;
        LObj: TJSONObject;

        LArray: TJSONArray;
        LPhotoJSON: TJSONObject;
        LPhoto: TPhotoItem;

        LList: TPhotoItemList;


      begin
        if RespCurated.StatusCode = 200 then
        begin
          LObj := RespCurated.JSONValue as TJSONObject;
          LArray := LObj.Values['photos'] as TJSONArray;

          LList := TPhotoItemList.Create;
          LList.ReadFromJSONArray(LArray);

          ACompleteHandler( LList );
        end
        else
        begin
          raise ERESTException.Create('Error contacting web service.');
        end;
      end,
       True );
  end
  else
  begin
    raise EArgumentNilException.Create('List for photos cannot be nil.');
  end;
end;

procedure TServiceController.GetPhotoByKeywords(AKeywords: String;
  ACompleteHandler: TProc<TPhotoItemList>);
begin
  if Assigned( ACompleteHandler ) then
  begin
    ReqKeywords.Params.ParameterByName('Authorization').Value := API_KEY;
    ReqKeywords.Params.ParameterByName('query').Value := AKeywords;

    ReqKeywords.ExecuteAsync(
      procedure
      var
        i : Integer;
        LObj: TJSONObject;

        LArray: TJSONArray;
        LPhotoJSON: TJSONObject;
        LPhoto: TPhotoItem;

        LList: TPhotoItemList;

      begin
        if RespKeywords.StatusCode = 200 then
        begin
          LObj := RespKeywords.JSONValue as TJSONObject;

          LArray := LObj.Values['photos'] as TJSONArray;
          LList := TPhotoItemList.Create;

          LList.ReadFromJSONArray(LArray, True);

          ACompleteHandler( LList );
        end
        else
        begin
          raise ERESTException.Create('Error contacting web service.');
        end;
      end,
       True );
  end
  else
  begin
    raise EArgumentNilException.Create('List for photos cannot be nil.');
  end;
end;

end.
