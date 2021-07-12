unit uConfigService;

interface

uses
  Aurelius.Mapping.Attributes,
  XData.Service.Common,
  uServerSettings,
  uServerStatus
  ;

type
  [ServiceContract]
  [Model('modConfig')]
  IConfigService = interface(IInvokable)
    ['{76B37A65-4758-4B39-A846-98815B82D931}']

    [HttpGet]
    function GetSettings: TServerSettings;

    [HttpPost]
    procedure UpdateSettings( const ASettings: TServerSettings );

    [HttpGet]
    function GetStatus: TServerStatus;

    [HttpGet]
    function StopServer : Boolean;

    [HttpGet]
    function StartServer: Boolean;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IConfigService));

end.
