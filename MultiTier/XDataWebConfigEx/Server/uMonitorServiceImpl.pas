unit uMonitorServiceImpl;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  uMonitorService,
  System.Generics.Collections,
  uMonitorClasses;

type
  [ServiceImplementation]
  TMonitorService = class(TInterfacedObject, IMonitorService)

    function GetMemoryInfo: TMonitorMemoryInfo;
    function GetDiskInfos: TMonitorDiskInfos;
    function GetAllInfos: TMonitorInfoDict;
  end;

implementation

{ TMonitorService }



function TMonitorService.GetAllInfos: TMonitorInfoDict;
var
  LController: TMonitorServiceController;
  LMem : TMonitorMemoryInfo;
  LDisk: TMonitorDiskInfos;
begin
  LController := TMonitorServiceController.Create;
  try
    Result := TMonitorInfoDict.Create( [doOwnsValues] );
    LDisk := TMonitorDiskInfos.Create;
    LMem := TMonitorMemoryInfo.Create;

    LController.GetMemoryInfo(LMem);
    LController.GetDiskInfos(LDisk);

    Result.Add( 'Storage', LDisk );
    Result.Add( 'Memory',  LMem );
  finally
    LController.Free;
  end;
end;

function TMonitorService.GetDiskInfos: TMonitorDiskInfos;
var
  LController: TMonitorServiceController;
  LDisk: TMonitorDiskInfos;

begin
  LController := TMonitorServiceController.Create;
  try
    LDisk := TMonitorDiskInfos.Create(true);
    LController.GetDiskInfos(LDisk);
    Result := LDisk;
  finally
    LController.Free;
  end;
end;

function TMonitorService.GetMemoryInfo: TMonitorMemoryInfo;
var
  LController : TMonitorServiceController;
  LMem : TMonitorMemoryInfo;

begin
  LController := TMonitorServiceController.Create;
  try
    LMem := TMonitorMemoryInfo.Create;

    LController.GetMemoryInfo(LMem);
    Result := LMem;
  finally
    LController.Free;
  end;
end;

initialization
  RegisterServiceType(TMonitorService);

end.
