object FrmMain: TFrmMain
  Width = 343
  Height = 371
  Caption = 'Desktop client configuration tool'
  ElementFont = efCSS
  OnCreate = WebFormCreate
  ScreenSnap = True
  object txtDatabasePassword: TWebEdit
    Left = 125
    Top = 112
    Width = 96
    Height = 25
    ChildOrder = 1
    ElementClassName = 'form-control'
    ElementID = 'DatabasePassword'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
  object txtDatabaseName: TWebEdit
    Left = 125
    Top = 64
    Width = 96
    Height = 25
    ChildOrder = 2
    ElementClassName = 'form-control'
    ElementID = 'DatabaseName'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
  object txtBaseUrl: TWebEdit
    Left = 125
    Top = 8
    Width = 96
    Height = 25
    ChildOrder = 3
    ElementClassName = 'form-control'
    ElementID = 'BaseUrl'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
  object txtDatabaseUserName: TWebEdit
    Left = 125
    Top = 152
    Width = 96
    Height = 25
    ChildOrder = 5
    ElementClassName = 'form-control'
    ElementID = 'DatabaseUserName'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
  object btnReload: TWebButton
    Left = 8
    Top = 120
    Width = 96
    Height = 25
    Caption = 'Reload'
    ChildOrder = 4
    ElementClassName = 'btn btn-danger'
    ElementID = 'btnReload'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Visible = False
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
    OnClick = btnReloadClick
  end
  object btnSave: TWebButton
    Left = 8
    Top = 80
    Width = 96
    Height = 25
    Caption = 'Save'
    ChildOrder = 5
    ElementClassName = 'btn btn-primary'
    ElementID = 'btnSave'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Visible = False
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
    OnClick = btnSaveClick
  end
  object txtState: TWebEdit
    Left = 125
    Top = 289
    Width = 96
    Height = 25
    ChildOrder = 6
    ElementClassName = 'form-control'
    ElementID = 'txtState'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    ReadOnly = True
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
  object btnStop: TWebButton
    Left = 8
    Top = 39
    Width = 96
    Height = 25
    Caption = 'Stop'
    ChildOrder = 7
    ElementClassName = 'btn btn-danger'
    ElementID = 'btnStop'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
    OnClick = btnStopClick
  end
  object btnStart: TWebButton
    Left = 8
    Top = 8
    Width = 96
    Height = 25
    Caption = 'Start'
    ChildOrder = 8
    ElementClassName = 'btn btn-success'
    ElementID = 'btnStart'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
    OnClick = btnStartClick
  end
  object txtDatabasePort: TWebEdit
    Left = 125
    Top = 240
    Width = 96
    Height = 25
    ChildOrder = 9
    ElementClassName = 'form-control'
    ElementID = 'DatabasePort'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
  object txtDatabaseServer: TWebEdit
    Left = 125
    Top = 200
    Width = 96
    Height = 25
    ChildOrder = 10
    ElementClassName = 'form-control'
    ElementID = 'DatabaseServer'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
  object btnMonitor: TWebButton
    Left = 8
    Top = 151
    Width = 96
    Height = 25
    Caption = 'Monitor'
    ChildOrder = 11
    ElementClassName = 'btn btn-secondary'
    ElementID = 'btnMonitor'
    HeightPercent = 100.000000000000000000
    Visible = False
    WidthPercent = 100.000000000000000000
    OnClick = btnMonitorClick
  end
  object WMonitor: TMiletusWindow
    Left = 40
    Top = 224
  end
end
