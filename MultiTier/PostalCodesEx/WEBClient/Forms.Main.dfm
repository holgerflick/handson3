object FrmMain: TFrmMain
  Width = 640
  Height = 480
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  OnCreate = WebFormCreate
  object txtPostalCode: TWebEdit
    Left = 8
    Top = 16
    Width = 313
    Height = 22
    ElementClassName = 'form-control'
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Text = 'txtPostalCode'
    WidthPercent = 100.000000000000000000
  end
  object btnSearch: TWebButton
    Left = 327
    Top = 14
    Width = 114
    Height = 25
    Caption = 'Search'
    ChildOrder = 1
    ElementClassName = 'btn btn-success'
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnSearchClick
  end
  object Table: TWebTableControl
    Left = 8
    Top = 72
    Width = 609
    Height = 393
    ElementClassName = 'text'
    HeightStyle = ssAuto
    WidthStyle = ssPercent
    HeightPercent = 100.000000000000000000
    WidthPercent = 70.000000000000000000
    BorderColor = clSilver
    ChildOrder = 2
    ColHeader = False
    ElementTableClassName = 'table table-striped  table-hover'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object XConnection: TXDataWebConnection
    URL = 'http://localhost:80'
    OnConnect = XConnectionConnect
    Left = 464
    Top = 16
  end
  object XClient: TXDataWebClient
    Connection = XConnection
    OnLoad = XClientLoad
    Left = 552
    Top = 16
  end
end
