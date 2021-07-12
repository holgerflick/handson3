object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'TAdvStringGrid: Dynamic properties'
  ClientHeight = 314
  ClientWidth = 493
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
    Top = 5
    Width = 483
    Height = 304
    Cursor = crDefault
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Color = clWhite
    DrawingStyle = gdsClassic
    FixedColor = clWhite
    FixedCols = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Roboto'
    Font.Style = []
    Options = [goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedRowDefAlign]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    GridLineColor = 13948116
    GridFixedLineColor = 13948116
    HoverRowCells = [hcNormal, hcSelected]
    OnGetDisplText = GridGetDisplText
    OnGetCellColor = GridGetCellColor
    OnGetCellCursor = GridGetCellCursor
    OnGetAlignment = GridGetAlignment
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
    Version = '8.5.7.2'
    ExplicitTop = 78
    ExplicitWidth = 842
    ExplicitHeight = 328
    ColWidths = (
      64
      64
      64
      64
      64)
  end
end
