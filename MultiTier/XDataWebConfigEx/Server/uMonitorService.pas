unit uMonitorService;

interface

uses
  Aurelius.Mapping.Attributes,
  uMonitorClasses,
  System.Generics.Collections,
  XData.Service.Common;

type
  [ServiceContract]
  [Model('modConfig')]
  IMonitorService = interface(IInvokable)
    ['{FA982FA1-0B21-4DDB-AC92-EEBB4A28CA46}']

    [HttpGet]
    function GetMemoryInfo : TMonitorMemoryInfo;

    [HttpGet]
    function GetDiskInfos: TMonitorDiskInfos;

    [HttpGet]
    function GetAllInfos: TMonitorInfoDict;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IMonitorService));

end.
