unit Classes.Meta;

interface
uses
 System.Generics.Collections;

type
 TIconItem = class
  private
    FFileName: String;
    FSize: Integer;
    function GetSizeKB: Double;
 public
    property FileName: String read FFileName write FFileName;
    property Size: Integer read FSize write FSize;
    property SizeKB: Double read GetSizeKB;
 end;


 TIconItemList = TObjectList<TIconItem>;

implementation

{ TIconItem }

function TIconItem.GetSizeKB: Double;
begin
  Result := Size / 1024;
end;

end.
