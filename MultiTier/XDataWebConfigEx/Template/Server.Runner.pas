unit Server.Runner;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Forms,
  Vcl.SvcMgr;

type
  TServiceApplicationRunner = class helper for Vcl.SvcMgr.TServiceApplication
  private
    function GetStandAlone: Boolean;
    procedure SetStandAlone(const Value: Boolean);
  public
    procedure Initialize;
    procedure CreateForm(InstanceClass: TComponentClass; var Reference);
    procedure Run;
    function RunningAsService: Boolean;
    property StandAlone: Boolean read GetStandAlone write SetStandAlone;
  end;

  TApplicationRunner = class helper for Vcl.Forms.TApplication
  private
    function GetStandAlone: Boolean;
    procedure SetStandAlone(const Value: Boolean);
  public
    procedure Initialize;
    procedure CreateForm(InstanceClass: TComponentClass; var Reference);
    procedure Run;
    function RunningAsService: Boolean;
    property StandAlone: Boolean read GetStandAlone write SetStandAlone;
  end;

function RunningAsService: Boolean;

implementation

var
  _StandAlone: Boolean = False;

function RunningAsService: Boolean;
begin
  Result := Application.RunningAsService;
end;

{ TServiceApplicationRunner }

procedure TServiceApplicationRunner.CreateForm(InstanceClass: TComponentClass;
  var Reference);
begin
  if (not RunningAsService) and InstanceClass.InheritsFrom(TService) then
    Exit;
  inherited CreateForm(InstanceClass, Reference);
end;

function TServiceApplicationRunner.GetStandAlone: Boolean;
begin
  Result := _StandAlone;
end;

procedure TServiceApplicationRunner.SetStandAlone(const Value: Boolean);
begin
  _StandAlone := Value;
end;

procedure TServiceApplicationRunner.Initialize;
begin
  if not RunningAsService then
    Vcl.Forms.Application.Initialize
  else if not Vcl.SvcMgr.Application.DelayInitialize or Vcl.SvcMgr.Application.Installing then
    inherited Initialize;
end;

procedure TServiceApplicationRunner.Run;
begin
  if not RunningAsService then
    Vcl.Forms.Application.Run
  else
    inherited Run;
end;

function TServiceApplicationRunner.RunningAsService: Boolean;
begin
  Result := not FindCmdLineSwitch('standalone', ['-', '/'], True) and (not StandAlone);
end;

{ TApplicationRunner }

procedure TApplicationRunner.CreateForm(InstanceClass: TComponentClass;
  var Reference);
begin
  if (not RunningAsService) and InstanceClass.InheritsFrom(TService) then
    Exit;
  Vcl.SvcMgr.Application.CreateForm(InstanceClass, Reference);
end;

function TApplicationRunner.GetStandAlone: Boolean;
begin
  Result := _StandAlone;
end;

procedure TApplicationRunner.SetStandAlone(const Value: Boolean);
begin
  _StandAlone := Value;
end;

procedure TApplicationRunner.Initialize;
begin
  if not RunningAsService then
    inherited Initialize
  else if not Vcl.SvcMgr.Application.DelayInitialize or Vcl.SvcMgr.Application.Installing then
    Vcl.SvcMgr.Application.Initialize;
end;

procedure TApplicationRunner.Run;
begin
  if not RunningAsService then
    inherited Run
  else
    Vcl.SvcMgr.Application.Run;
end;

function TApplicationRunner.RunningAsService: Boolean;
begin
  Result := not FindCmdLineSwitch('standalone', ['-', '/'], True) and (not StandAlone);
end;

end.
