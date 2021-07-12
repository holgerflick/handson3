unit uServerStatus;
{$M+}

interface

uses
  uDataServerContainer;

type
  TServerStatus = class
  private
    FIsRunning: Boolean;
    FBaseUrl: String;

  public
    constructor Create( ACont: TDataServerContainer );

  published
    property IsRunning: Boolean read FIsRunning write FIsRunning;
    property BaseUrl: String read FBaseUrl write FBaseUrl;
  end;

implementation

{ TServerStatus }

constructor TServerStatus.Create(ACont: TDataServerContainer);
begin
  IsRunning := ACont.IsDataServiceRunning;
  BaseUrl := ACont.ServerData.BaseUrl;
end;

end.
