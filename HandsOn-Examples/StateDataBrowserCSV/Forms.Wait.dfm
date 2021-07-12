object FrmWait: TFrmWait
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Loading data...'
  ClientHeight = 228
  ClientWidth = 176
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Droid Sans'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  StyleElements = [seFont, seClient]
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    AlignWithMargins = True
    Left = 15
    Top = 128
    Width = 158
    Height = 97
    Margins.Left = 15
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Data is read directly from CSV file and TAdvStringGrid  is used ' +
      'to display data in readable format.'
    WordWrap = True
    ExplicitWidth = 235
  end
  object Indicator: TActivityIndicator
    Left = 56
    Top = 24
    Animate = True
    IndicatorSize = aisXLarge
  end
end
