unit Helper.TAdvStringGrid;

interface

uses
  AdvGrid,
  SysUtils,
  Classes;

type
  TAdvStringGridHelper = class helper for TAdvStringGrid

    procedure LoadFromCSVResource(
      AResourceName: String;
      AEncoding: TEncoding = nil;
      MaxRows: Integer = -1;
      IgnoreRows: Integer = -1
    );

    procedure LoadFromCSVStream(
      AStream: TStream;
      AEncoding: TEncoding;
      MaxRows : Integer = -1;
      IgnoreRows : Integer = -1
    ); overload;

  end;

implementation

{ TAdvStringGridHelper }

uses
  AdvUtils
  ;

procedure TAdvStringGridHelper.LoadFromCSVResource(AResourceName: String;
  AEncoding: TEncoding; MaxRows, IgnoreRows: Integer);
var
  LStream: TResourceStream;

begin
  LStream := TAdvUtils.GetResourceStream(AResourceName);
  try
    if Assigned( AEncoding ) then
    begin
      LoadFromCSVStream( LStream, AEncoding, MaxRows, IgnoreRows );
    end
    else
    begin
      LoadFromCSVStream( LStream, MaxRows, IgnoreRows );
    end;

  finally
    LStream.Free;
  end;
end;

procedure TAdvStringGridHelper.LoadFromCSVStream(
  AStream: TStream;
  AEncoding: TEncoding;
  MaxRows : Integer = -1;
  IgnoreRows : Integer = -1
  );
var
  LList: TStringlist;
  LMem: TMemoryStream;

begin
  LMem := TMemoryStream.Create;
  LList := TStringlist.Create;
  try
    AStream.Position := 0;
    LList.LoadFromStream(AStream, AEncoding);

    LList.SaveToStream(LMem);
    LMem.Position := 0;

    LoadFromCSVStream( LMem, MaxRows, IgnoreRows );

  finally
    LMem.Free;
    LList.Free;
  end;
end;

end.
