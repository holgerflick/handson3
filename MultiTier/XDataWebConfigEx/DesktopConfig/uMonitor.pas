unit uMonitor;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, DB, WEBLib.Grids, Vcl.Controls,
  VCL.TMSFNCCustomControl, VCL.TMSFNCWidgetGauge, uServiceController,
  Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TFrmMonitor = class(TMiletusForm)
    gaugeMemory: TTMSFNCWidgetGauge;
    tblStorage: TWebTableControl;
    btnOK: TWebButton;
    procedure btnOKClick(Sender: TObject);
    procedure WebButton1Click(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
  private

    { Private declarations }
    procedure UpdateValues;
    procedure OnConnect( Success: Boolean );
    procedure InitGauge(AMin, AMax, ACurrent: Double;
                        AControl: TTMSFNCWidgetGauge; const ATitle: String);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrmMonitor }

procedure TFrmMonitor.btnOKClick(Sender: TObject);
begin
   self.Close;
end;

procedure TFrmMonitor.InitGauge(AMin, AMax, ACurrent: Double;
  AControl: TTMSFNCWidgetGauge; const ATitle: String);
var
  LSection: TTMSFNCWidgetGaugeSection;
  LSegSize: Double;

begin
  LSegSize := AMax / 3;

  AControl.MinimumValue := 0;
  AControl.MaximumValue := AMax;
  AControl.Value := ACurrent;
  AControl.OuterCircle.Color := gcDarkslategray;
  AControl.InnerCircle.Color := gcLightgray;
  AControl.OuterRim.Color := gcLightgray;
  AControl.Arc.Color := gcMedGray;
  AControl.Arc.Threshold.Color := gcMedGray;
  AControl.Digit.BackGroundColor := gcLightGray;
  AControl.Font.Name := 'Roboto';
  AControl.Font.Size := 12;
  AControl.ValueFont.Name := 'Roboto';
  AControl.ValueFont.Size := 9;
  AControl.Font.Color := gcBlack;
  AControl.Animation := false;
  AControl.ValueFormat := ',#';
  AControl.GaugeValuesFormat := ',#';
  AControl.DialText := ATitle;

  AControl.Sections.BeginUpdate;
  try
    AControl.Sections.Clear;

    LSection := AControl.Sections.Add;
    LSection.StartValue := 0;
    LSection.EndValue := LSegSize;
    LSection.Color := gcLime;
    LSection.SectionType := stBorder;

    LSection := AControl.Sections.Add;
    LSection.StartValue := LSegSize;
    LSection.EndValue := 2 * LSegSize;
    LSection.Color := gcGold;
    LSection.SectionType := stBorder;

    LSection := AControl.Sections.Add;
    LSection.StartValue := 2 * LSegSize;
    LSection.EndValue := AMax;
    LSection.Color := gcOrangeRed;
    LSection.SectionType := stBorder;
  finally
    AControl.Sections.EndUpdate;
  end;
end;


procedure TFrmMonitor.MiletusFormCreate(Sender: TObject);
begin
  TServiceController.Instance.OnConnect := OnConnect;
  TServiceController.Instance.Connect;
end;

procedure TFrmMonitor.OnConnect(Success: Boolean);
begin
  UpdateValues;
end;

procedure TFrmMonitor.UpdateValues;
var
  LService: TServiceController;
begin
  LService := TServiceController.Instance;


  LService.GetMonitoringInfo(
    // when complete
    procedure
    var
      c: Integer;
      i: Integer;
      r: Integer;
      LEl : TJSHTMLElement;
      LDisk: TMonitorDiskInfo;
      LMem: TMonitorMemoryInfo;

    begin
      // init table
      tblStorage.ColCount := 4;
      tblStorage.RowCount := LService.StorageInfo.Count + 1;

      // set header rows
      tblStorage.Cells[0,0] := 'Drive';
      tblStorage.Cells[1,0] := 'Total/MB';
      tblStorage.Cells[2,0] := 'Available/MB';
      tblStorage.Cells[3,0] := '% Used';

      // iterate all storage devices
      for i := 0 to LService.StorageInfo.Count-1 do
      begin
        r := i + 1;
        LDisk := LService.StorageInfo[i];
        tblStorage.Cells[0, r] := LDisk.Name;
        LEl := tblStorage.CellElements[0, r];
        LEl['class'] := 'text-center';
        tblStorage.Cells[1, r] := Format( '%.0n', [LDisk.MBytesSize/1] );
        tblStorage.Cells[2, r] := Format( '%.0n', [LDisk.MBytesAvail/1] );
        tblStorage.Cells[3, r] := Format( '%.2f', [LDisk.PctUsed*100] );

        for c := 1 to 3 do
        begin
          tblStorage.CellElements[c, r].className := 'text-right';
        end;

      end;

      // display memory usage in gauge
      LMem := LService.MemoryInfo;

      // only if values have been retrieved
      gaugeMemory.Visible := LMem.Updated;
      if LMem.Updated then
      begin
        InitGauge(0, LMem.MBytesTotal, LMem.MBytesUsed,
          gaugeMemory, 'Memory Usage' + #10 + '(MB)')
      end;
    end
  );
end;

procedure TFrmMonitor.WebButton1Click(Sender: TObject);
begin
  UpdateValues;
end;

initialization
  RegisterClass(TFrmMonitor);

end.
