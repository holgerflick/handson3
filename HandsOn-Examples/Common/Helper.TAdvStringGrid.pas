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
    if Assigned( LStream ) then
    begin
      if Assigned( AEncoding ) then
      begin
        LoadFromCSVStream( LStream, AEncoding, MaxRows, IgnoreRows );
      end
      else
      begin
        LoadFromCSVStream( LStream, MaxRows, IgnoreRows );
      end;
    end;

  finally
    LStream.Free;
  end;
end;

end.
