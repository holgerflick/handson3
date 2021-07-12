object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Reading CSV data into SQLite database'
  ClientHeight = 128
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Roboto'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    435
    128)
  PixelsPerInch = 96
  TextHeight = 18
  object txtFilename: TAdvEditBtn
    Left = 8
    Top = 16
    Width = 419
    Height = 26
    BorderColor = 11250603
    EmptyTextStyle = []
    FlatLineColor = 11250603
    FocusColor = clWindow
    FocusFontColor = 3881787
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Anchors = [akLeft, akTop, akRight]
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = 4474440
    Font.Height = -15
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    ShortCut = 0
    TabOrder = 0
    Text = 'D:\data\covid-19-data\us-states.csv'
    Visible = True
    Version = '1.7.0.0'
    ButtonStyle = bsButton
    ButtonWidth = 16
    Flat = False
    Etched = False
    ButtonCaption = '...'
    ReadOnly = False
    ButtonColor = clWhite
    ButtonColorHot = 15917525
    ButtonColorDown = 14925219
    ButtonTextColor = 4474440
    ButtonTextColorHot = 2303013
    ButtonTextColorDown = 2303013
    ExplicitWidth = 836
  end
  object btnImport: TButton
    Left = 8
    Top = 48
    Width = 201
    Height = 25
    Caption = 'Import data'
    TabOrder = 1
    OnClick = btnImportClick
  end
  object Progress: TProgressBar
    Left = 0
    Top = 101
    Width = 435
    Height = 27
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 125
    ExplicitWidth = 852
  end
  object btnUpdateDaily: TButton
    Left = 224
    Top = 48
    Width = 201
    Height = 25
    Caption = 'Update daily numbers'
    TabOrder = 3
    OnClick = btnUpdateDailyClick
  end
end
