object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'TAdvStringGrid: Coordinates and cell types'
  ClientHeight = 411
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Roboto'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object Grid: TAdvStringGrid
    AlignWithMargins = True
    Left = 5
    Top = 78
    Width = 842
    Height = 328
    Cursor = crDefault
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    DrawingStyle = gdsClassic
    FixedColor = clWhite
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedRowDefAlign]
    ScrollBars = ssBoth
    TabOrder = 0
    GridLineColor = 13948116
    GridFixedLineColor = 13948116
    HoverRowCells = [hcNormal, hcSelected]
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 15658734
    ActiveCellColorTo = 15658734
    BorderColor = 13948116
    ControlLook.FixedGradientMirrorFrom = 15658734
    ControlLook.FixedGradientMirrorTo = 15658734
    ControlLook.FixedGradientHoverFrom = 16576740
    ControlLook.FixedGradientHoverTo = 16576740
    ControlLook.FixedGradientHoverMirrorFrom = 16576740
    ControlLook.FixedGradientHoverMirrorTo = 16576740
    ControlLook.FixedGradientHoverBorder = 15381630
    ControlLook.FixedGradientDownFrom = 16573128
    ControlLook.FixedGradientDownTo = 16573128
    ControlLook.FixedGradientDownMirrorFrom = 16573128
    ControlLook.FixedGradientDownMirrorTo = 16573128
    ControlLook.FixedGradientDownBorder = 15048022
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDown.TextChecked = 'Checked'
    FilterDropDown.TextUnChecked = 'Unchecked'
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Larger than'
      'Smaller than'
      'Clear')
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    Look = glOffice2007
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.Color = 15658734
    SearchFooter.ColorTo = 15658734
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SearchFooter.ResultFormat = '(%d of %d)'
    SelectionColor = 14327846
    SelectionTextColor = clWhite
    SortSettings.DefaultFormat = ssAutomatic
    SortSettings.HeaderColor = 15658734
    SortSettings.HeaderColorTo = 15658734
    SortSettings.HeaderMirrorColor = 15658734
    SortSettings.HeaderMirrorColorTo = 15658734
    UIStyle = tsOffice2013White
    Version = '8.5.9.0'
    ColWidths = (
      64
      64
      64
      64
      64)
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 846
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object txtRows: TAdvSpinEdit
      Left = 24
      Top = 34
      Width = 89
      Height = 27
      Color = clWhite
      Value = 10
      FloatValue = 10.000000000000000000
      TimeValue = 0.416666666666666700
      HexDigits = 0
      HexValue = 0
      FlatLineColor = 11250603
      BorderColor = 11250603
      FocusColor = clNone
      FocusFontColor = 3881787
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Roboto'
      Font.Style = []
      IncrementFloat = 0.100000000000000000
      IncrementFloatPage = 1.000000000000000000
      LabelCaption = 'Rows'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = 4474440
      LabelFont.Height = -16
      LabelFont.Name = 'Roboto'
      LabelFont.Style = [fsBold]
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Visible = True
      Version = '1.9.3.6'
      ButtonColor = clWhite
      ButtonColorHot = 15917525
      ButtonColorDown = 14925219
      ButtonTextColor = 2303013
      ButtonTextColorHot = 2303013
      ButtonTextColorDown = 2303013
    end
    object txtCols: TAdvSpinEdit
      Left = 136
      Top = 34
      Width = 89
      Height = 27
      Color = clWhite
      Value = 5
      FloatValue = 5.000000000000000000
      TimeValue = 0.208333333333333300
      HexDigits = 0
      HexValue = 0
      FlatLineColor = 11250603
      BorderColor = 11250603
      FocusColor = clNone
      FocusFontColor = 3881787
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Roboto'
      Font.Style = []
      IncrementFloat = 0.100000000000000000
      IncrementFloatPage = 1.000000000000000000
      LabelCaption = 'Columns'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = 4474440
      LabelFont.Height = -16
      LabelFont.Name = 'Roboto'
      LabelFont.Style = [fsBold]
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Visible = True
      Version = '1.9.3.6'
      ButtonColor = clWhite
      ButtonColorHot = 15917525
      ButtonColorDown = 14925219
      ButtonTextColor = 2303013
      ButtonTextColorHot = 2303013
      ButtonTextColorDown = 2303013
    end
    object txtFixedRows: TAdvSpinEdit
      Left = 248
      Top = 34
      Width = 89
      Height = 27
      Color = clWhite
      Value = 1
      FloatValue = 1.000000000000000000
      TimeValue = 0.041666666666666660
      HexDigits = 0
      HexValue = 0
      FlatLineColor = 11250603
      BorderColor = 11250603
      FocusColor = clNone
      FocusFontColor = 3881787
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Roboto'
      Font.Style = []
      IncrementFloat = 0.100000000000000000
      IncrementFloatPage = 1.000000000000000000
      LabelCaption = 'Fixed Rows'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = 4474440
      LabelFont.Height = -16
      LabelFont.Name = 'Roboto'
      LabelFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = True
      Version = '1.9.3.6'
      ButtonColor = clWhite
      ButtonColorHot = 15917525
      ButtonColorDown = 14925219
      ButtonTextColor = 2303013
      ButtonTextColorHot = 2303013
      ButtonTextColorDown = 2303013
    end
    object txtFixedCols: TAdvSpinEdit
      Left = 360
      Top = 34
      Width = 89
      Height = 27
      Color = clWhite
      Value = 1
      FloatValue = 1.000000000000000000
      TimeValue = 0.041666666666666660
      HexDigits = 0
      HexValue = 0
      FlatLineColor = 11250603
      BorderColor = 11250603
      FocusColor = clNone
      FocusFontColor = 3881787
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Roboto'
      Font.Style = []
      IncrementFloat = 0.100000000000000000
      IncrementFloatPage = 1.000000000000000000
      LabelCaption = 'Fixed Columns'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = 4474440
      LabelFont.Height = -16
      LabelFont.Name = 'Roboto'
      LabelFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Visible = True
      Version = '1.9.3.6'
      ButtonColor = clWhite
      ButtonColorHot = 15917525
      ButtonColorDown = 14925219
      ButtonTextColor = 2303013
      ButtonTextColorHot = 2303013
      ButtonTextColorDown = 2303013
    end
    object btnUpdate: TAdvGlowButton
      Left = 480
      Top = 34
      Width = 145
      Height = 27
      Caption = 'Update'
      Default = True
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Rounded = True
      TabOrder = 4
      OnClick = btnUpdateClick
      Appearance.BorderColor = 11382963
      Appearance.BorderColorHot = 11565130
      Appearance.BorderColorCheckedHot = 11565130
      Appearance.BorderColorDown = 11565130
      Appearance.BorderColorChecked = 13744549
      Appearance.BorderColorDisabled = 13948116
      Appearance.ColorChecked = 13744549
      Appearance.ColorCheckedTo = 13744549
      Appearance.ColorDisabled = clWhite
      Appearance.ColorDisabledTo = clNone
      Appearance.ColorDown = 11565130
      Appearance.ColorDownTo = 11565130
      Appearance.ColorHot = 16444643
      Appearance.ColorHotTo = 16444643
      Appearance.ColorMirror = clWhite
      Appearance.ColorMirrorTo = clWhite
      Appearance.ColorMirrorHot = 16444643
      Appearance.ColorMirrorHotTo = 16444643
      Appearance.ColorMirrorDown = 11565130
      Appearance.ColorMirrorDownTo = 11565130
      Appearance.ColorMirrorChecked = 13744549
      Appearance.ColorMirrorCheckedTo = 13744549
      Appearance.ColorMirrorDisabled = clWhite
      Appearance.ColorMirrorDisabledTo = clNone
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.TextColorChecked = 3750459
      Appearance.TextColorDown = 2303013
      Appearance.TextColorHot = 2303013
      Appearance.TextColorDisabled = 13948116
    end
    object Button1: TButton
      Left = 680
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
end
