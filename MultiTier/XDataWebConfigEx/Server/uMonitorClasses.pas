unit uMonitorClasses;
{$M+}


interface
uses
  System.Generics.Collections,
  Bcl.Collections;


type
  TMonitorDiskInfo = class
  strict private
    FName: String;
    FMBytesAvail: Cardinal;
    FMBytesSize: Cardinal;

  published
    property Name: String read FName write FName;

    property MBytesAvail: Cardinal read FMBytesAvail write FMBytesAvail;
    property MBytesSize: Cardinal read FMBytesSize write FMBytesSize;
  end;

  TMonitorDiskInfos = TObjectList<TMonitorDiskInfo>;

  TMonitorMemoryInfo = class
  strict private
    FMBytesTotal: Cardinal;
    FMBytesAvail: Cardinal;

  published
    property MBytesTotal: Cardinal read FMBytesTotal write FMBytesTotal;
    property MBytesAvail: Cardinal read FMBytesAvail write FMBytesAvail;
  end;


  TMonitorServiceController = class

  public
    procedure GetMemoryInfo( AInfo : TMonitorMemoryInfo );
    procedure GetDiskInfos( AInfo: TMonitorDiskInfos );

  end;

  TMonitorInfoDict = TOrderedObjectDictionary< string, TObject >;


implementation

{ TMonitorServiceController }

uses
  Windows,
  ActiveX,
  Classes,
  System.SysUtils,
  OverbyteIcsWmi;

const
  BytesToMB = 1024 * 1024;


procedure TMonitorServiceController.GetDiskInfos( AInfo: TMonitorDiskInfos );
var
  LWmiData: T2DimStrArray;

  LNoInst,
  LNoRows: Integer;

  LIdxName,
  LIdxType,
  LIdxAvail,
  LIdxSize: Integer;

begin
  if Assigned( AInfo ) then
  begin
    CoInitialize(nil);
    try
      LNoRows := IcsWmiGetInfo('', RootNameSpace, '', '',
        'Win32_LogicalDisk', LWmiData, LNoInst );

      // rows contain values for all intances, property name is in element 0
      // first row contains the names of the instances

      var LNames := TStringlist.Create;
      LNames.Add('---'); // offset
      try
        for var r := 1 to LNoRows do
        begin
          LNames.Add( LWmiData[ 0, r ] );
        end;

        LIdxName  := LNames.IndexOf('Name');
        LIdxType  := LNames.IndexOf('DriveType');
        LIdxAvail := LNames.IndexOf('FreeSpace');
        LIdxSize  := LNames.IndexOf('Size');

      finally
        LNames.Free;
      end;

      AInfo.Clear;
      for var i := 1 to LNoInst do
      begin
        if LWmiData[ i, LIdxType ] = '3' then
        begin
          var LDisk := TMonitorDiskInfo.Create;
          LDisk.Name := LWmiData[ i, LIdxName ];
          LDisk.MBytesAvail := LWmiData[ i, LIdxAvail ].ToInt64 DIV BytesToMB;
          LDisk.MBytesSize := LWmiData[ i, LIdxSize ].ToInt64 DIV BytesToMB;

          AInfo.Add(LDisk);
        end;
      end;

    finally
      CoUninitialize;
    end;
  end;
end;

procedure TMonitorServiceController.GetMemoryInfo( AInfo: TMonitorMemoryInfo );
var
  LStatus: TMemoryStatusEx;
begin
  LStatus.dwLength:=SizeOf(LStatus);
  GlobalMemoryStatusEx(LStatus);

  if Assigned( AInfo ) then
  begin
    AInfo.MBytesTotal := LStatus.ullTotalPhys DIV BytesToMB;
    AInfo.MBytesAvail := LStatus.ullAvailPhys DIV BytesToMB;
  end;
end;



end.
