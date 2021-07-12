object FrmMonitor: TFrmMonitor
  Width = 805
  Height = 372
  Caption = 'Monitoring'
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  ElementPosition = epRelative
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormContainer = 'body'
  ParentFont = False
  ShowClose = False
  OnCreate = WebFormCreate
  object gaugeMemory: TTMSFNCWidgetGauge
    Left = 8
    Top = 8
    Width = 350
    Height = 350
    ParentDoubleBuffered = False
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    TabOrder = 0
    Border.Kind = gskNone
    Border.Color = 6908265
    Border.Width = 0.000000000000000000
    MaximumValue = 100.000000000000000000
    OuterCircle.Width = 0.030000000000000000
    InnerCircle.Color = 15130800
    OuterRim.Color = 9470064
    OuterRim.Width = 2
    Arc.Width = 0.030000000000000000
    Arc.Threshold.Center = 25.000000000000000000
    Arc.Threshold.EndValue = 100.000000000000000000
    GaugeValuesFormat = '0'
    ValueFont.Charset = DEFAULT_CHARSET
    ValueFont.Color = 5197615
    ValueFont.Height = -16
    ValueFont.Name = 'Tahoma'
    ValueFont.Style = []
    ValueFormat = '#,###'
    Sections = <>
    ValuePosition = vpTop
    ExtraNeedles = <>
  end
  object tblStorage: TWebTableControl
    Left = 364
    Top = 8
    Width = 426
    Height = 303
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderColor = clSilver
    ChildOrder = 1
    ElementFont = efCSS
    ElementHeaderClassName = 'thead-light'
    ElementTableClassName = 'table table-striped table-bordered  table-hover'
    ColCount = 3
  end
  object btnOK: TWebButton
    Left = 648
    Top = 317
    Width = 142
    Height = 25
    Anchors = [akRight, akBottom]
    ButtonType = 'btn btn-success'
    Caption = 'OK'
    ChildOrder = 2
    ElementClassName = 'btn btn-success'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnOKClick
  end
end
