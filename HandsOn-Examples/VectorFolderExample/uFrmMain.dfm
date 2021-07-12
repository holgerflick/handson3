object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Vector Image design-time/run-time demo'
  ClientHeight = 490
  ClientWidth = 905
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Roboto'
  Font.Style = []
  OldCreateOrder = False
  OnAfterMonitorDpiChanged = FormAfterMonitorDpiChanged
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  object lblSize: TLabel
    AlignWithMargins = True
    Left = 15
    Top = 421
    Width = 875
    Height = 19
    Margins.Left = 15
    Margins.Top = 5
    Margins.Right = 15
    Margins.Bottom = 5
    Align = alBottom
    Alignment = taRightJustify
    Caption = 'lblSize'
    ExplicitLeft = 843
    ExplicitWidth = 47
  end
  object Track: TAdvTrackBar
    Left = 0
    Top = 445
    Width = 905
    Height = 45
    Align = alBottom
    BorderColor = clNone
    BorderColorDisabled = clNone
    Buttons.BorderColor = 11250603
    Buttons.BorderColorHot = 15917525
    Buttons.BorderColorDown = 14925219
    Buttons.Color = clWhite
    Buttons.ColorTo = clWhite
    Buttons.ColorHot = 15917525
    Buttons.ColorHotTo = 15917525
    Buttons.ColorDown = 14925219
    Buttons.ColorDownTo = 14925219
    Buttons.ColorMirror = clNone
    Buttons.ColorMirrorTo = clNone
    Buttons.ColorMirrorHot = clNone
    Buttons.ColorMirrorHotTo = clNone
    Buttons.ColorMirrorDown = clNone
    Buttons.ColorMirrorDownTo = clNone
    Buttons.GradientMirror = ggVertical
    ColorTo = clNone
    ColorDisabled = clNone
    ColorDisabledTo = clNone
    Direction = gdHorizontal
    Color = clNone
    Slider.BorderColor = 11250603
    Slider.BorderColorDisabled = clBlack
    Slider.Color = clWhite
    Slider.ColorTo = clBlack
    Slider.ColorDisabled = clBlack
    Slider.ColorDisabledTo = clBlack
    Slider.ColorCompleted = clNone
    Slider.ColorCompletedTo = clNone
    Slider.ColorCompletedDisabled = clNone
    Slider.ColorCompletedDisabledTo = clNone
    Slider.Direction = gdHorizontal
    TabOrder = 0
    Thumb.BorderColor = 11250603
    Thumb.BorderColorHot = 15917525
    Thumb.BorderColorDown = 14925219
    Thumb.BorderColorDisabled = clBlack
    Thumb.Color = clWhite
    Thumb.ColorTo = clWhite
    Thumb.ColorDown = 14925219
    Thumb.ColorDownTo = 14925219
    Thumb.ColorHot = 15917525
    Thumb.ColorHotTo = 15917525
    Thumb.ColorDisabled = clBlack
    Thumb.ColorDisabledTo = clBlack
    Thumb.ColorMirror = clNone
    Thumb.ColorMirrorTo = clNone
    Thumb.ColorMirrorHot = clNone
    Thumb.ColorMirrorHotTo = clNone
    Thumb.ColorMirrorDown = clNone
    Thumb.ColorMirrorDownTo = clNone
    Thumb.ColorMirrorDisabled = clBlack
    Thumb.ColorMirrorDisabledTo = clBlack
    Thumb.Gradient = ggVertical
    Thumb.GradientMirror = ggVertical
    Thumb.Shape = tsPointer
    TickMark.Color = 11250603
    TickMark.ColorDisabled = clBlack
    TickMark.Font.Charset = DEFAULT_CHARSET
    TickMark.Font.Color = 4474440
    TickMark.Font.Height = -11
    TickMark.Font.Name = 'Tahoma'
    TickMark.Font.Style = []
    TickMark.ShowImageAtSteps = 2
    TrackHint = False
    TrackLabel.Font.Charset = DEFAULT_CHARSET
    TrackLabel.Font.Color = 4474440
    TrackLabel.Font.Height = -11
    TrackLabel.Font.Name = 'Tahoma'
    TrackLabel.Font.Style = []
    TrackLabel.Format = 'Pos: %d'
    Version = '1.7.2.3'
    OnChanged = TrackChanged
    UIStyle = tsOffice2019White
  end
  object AdvDockPanel1: TAdvDockPanel
    Left = 0
    Top = 0
    Width = 905
    Height = 59
    MinimumSize = 3
    LockHeight = False
    Persistence.Location = plRegistry
    Persistence.Enabled = False
    ToolBarStyler = AdvToolBarOfficeStyler1
    UseRunTimeHeight = False
    Version = '6.8.0.15'
    object Toolbar: TAdvToolBar
      Left = 3
      Top = 1
      Width = 501
      Height = 44
      UIStyle = tsOffice2019White
      AllowFloating = True
      Caption = 'Untitled'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -16
      CaptionFont.Name = 'Roboto'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowRightHandle = False
      ShowClose = False
      ShowOptionIndicator = False
      FullSize = True
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = AdvToolBarOfficeStyler1
      Images = ToolImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object btnLoadFolder: TAdvGlowButton
        Left = 2
        Top = 2
        Width = 145
        Height = 40
        AutoSize = True
        Caption = 'Load folder...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4474440
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = []
        ImageIndex = 0
        Images = ToolImages
        FocusType = ftHot
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Rounded = False
        TabOrder = 0
        OnClick = btnLoadFolderClick
        Appearance.BorderColor = clWhite
        Appearance.BorderColorHot = 15917525
        Appearance.BorderColorDown = 14925219
        Appearance.BorderColorChecked = 15917525
        Appearance.Color = clWhite
        Appearance.ColorTo = clWhite
        Appearance.ColorChecked = 15917525
        Appearance.ColorCheckedTo = 15917525
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 14925219
        Appearance.ColorDownTo = 14925219
        Appearance.ColorHot = 15917525
        Appearance.ColorHotTo = 15917525
        Appearance.ColorMirror = clWhite
        Appearance.ColorMirrorTo = clWhite
        Appearance.ColorMirrorHot = 15917525
        Appearance.ColorMirrorHotTo = 15917525
        Appearance.ColorMirrorDown = 14925219
        Appearance.ColorMirrorDownTo = 14925219
        Appearance.ColorMirrorChecked = 15917525
        Appearance.ColorMirrorCheckedTo = 15917525
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 3881787
        Appearance.TextColorDown = 4474440
        Appearance.TextColorHot = 4474440
        UIStyle = tsOffice2019White
      end
      object btnLoadZip: TAdvGlowButton
        Left = 147
        Top = 2
        Width = 181
        Height = 40
        AutoSize = True
        Caption = 'Load ZIP Archive...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4474440
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = []
        ImageIndex = 1
        Images = ToolImages
        MarginHorz = 0
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -16
        NotesFont.Name = 'Roboto'
        NotesFont.Style = []
        ParentFont = False
        Rounded = False
        TabOrder = 1
        OnClick = btnLoadZipClick
        Appearance.BorderColor = clWhite
        Appearance.BorderColorHot = 15917525
        Appearance.BorderColorDown = 14925219
        Appearance.BorderColorChecked = 15917525
        Appearance.Color = clWhite
        Appearance.ColorTo = clWhite
        Appearance.ColorChecked = 15917525
        Appearance.ColorCheckedTo = 15917525
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 14925219
        Appearance.ColorDownTo = 14925219
        Appearance.ColorHot = 15917525
        Appearance.ColorHotTo = 15917525
        Appearance.ColorMirror = clWhite
        Appearance.ColorMirrorTo = clWhite
        Appearance.ColorMirrorHot = 15917525
        Appearance.ColorMirrorHotTo = 15917525
        Appearance.ColorMirrorDown = 14925219
        Appearance.ColorMirrorDownTo = 14925219
        Appearance.ColorMirrorChecked = 15917525
        Appearance.ColorMirrorCheckedTo = 15917525
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 3881787
        Appearance.TextColorDown = 4474440
        Appearance.TextColorHot = 4474440
        UIStyle = tsOffice2019White
      end
      object btnExcel: TAdvGlowButton
        Left = 328
        Top = 2
        Width = 169
        Height = 40
        AutoSize = True
        Caption = 'Export to Excel...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4474440
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = []
        ImageIndex = 2
        Images = ToolImages
        FocusType = ftHot
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Rounded = False
        TabOrder = 2
        OnClick = btnExcelClick
        Appearance.BorderColor = clWhite
        Appearance.BorderColorHot = 15917525
        Appearance.BorderColorDown = 14925219
        Appearance.BorderColorChecked = 15917525
        Appearance.Color = clWhite
        Appearance.ColorTo = clWhite
        Appearance.ColorChecked = 15917525
        Appearance.ColorCheckedTo = 15917525
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 14925219
        Appearance.ColorDownTo = 14925219
        Appearance.ColorHot = 15917525
        Appearance.ColorHotTo = 15917525
        Appearance.ColorMirror = clWhite
        Appearance.ColorMirrorTo = clWhite
        Appearance.ColorMirrorHot = 15917525
        Appearance.ColorMirrorHotTo = 15917525
        Appearance.ColorMirrorDown = 14925219
        Appearance.ColorMirrorDownTo = 14925219
        Appearance.ColorMirrorChecked = 15917525
        Appearance.ColorMirrorCheckedTo = 15917525
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 3881787
        Appearance.TextColorDown = 4474440
        Appearance.TextColorHot = 4474440
        UIStyle = tsOffice2019White
      end
    end
  end
  object Grid: TAdvStringGrid
    AlignWithMargins = True
    Left = 5
    Top = 64
    Width = 895
    Height = 347
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    DrawingStyle = gdsClassic
    FixedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Roboto'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    ParentFont = False
    TabOrder = 2
    GridLineColor = 13948116
    GridFixedLineColor = 11250603
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = 4474440
    ActiveCellFont.Height = -15
    ActiveCellFont.Name = 'Roboto'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 11565130
    ActiveCellColorTo = 11565130
    BorderColor = 11250603
    ControlLook.FixedGradientFrom = clWhite
    ControlLook.FixedGradientTo = clWhite
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientHoverMirrorFrom = clWhite
    ControlLook.FixedGradientHoverMirrorTo = clWhite
    ControlLook.FixedGradientHoverBorder = 11645361
    ControlLook.FixedGradientDownFrom = clWhite
    ControlLook.FixedGradientDownTo = clWhite
    ControlLook.FixedGradientDownMirrorFrom = clWhite
    ControlLook.FixedGradientDownMirrorTo = clWhite
    ControlLook.FixedGradientDownBorder = 11250603
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
    FixedFont.Color = 3881787
    FixedFont.Height = -17
    FixedFont.Name = 'Roboto'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    Look = glCustom
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
    SearchFooter.ColorTo = clNone
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
    SelectionColor = 13744549
    SortSettings.HeaderColor = clWhite
    SortSettings.HeaderColorTo = clWhite
    SortSettings.HeaderMirrorColor = clWhite
    SortSettings.HeaderMirrorColorTo = clWhite
    UIStyle = tsOffice2019White
    VAlignment = vtaCenter
    Version = '8.6.5.1'
    WordWrap = False
  end
  object Images: TVirtualImageList
    AutoFill = True
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <>
    ImageCollection = Vectors
    Left = 461
    Top = 151
  end
  object dlgFolder: TFolderDialog
    Options = [fdoNewDialogStyle, fdoNoNewFolderButton, fdoShareable]
    DialogX = 0
    DialogY = 0
    Version = '1.1.4.0'
    Left = 24
    Top = 320
  end
  object ToolImages: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'folder'
        Disabled = False
        Name = 'folder'
      end
      item
        CollectionIndex = 1
        CollectionName = 'zip'
        Disabled = False
        Name = 'zip'
      end
      item
        CollectionIndex = 2
        CollectionName = 'sheet'
        Disabled = False
        Name = 'sheet'
      end>
    ImageCollection = ToolVectors
    Width = 32
    Height = 32
    Left = 461
    Top = 87
  end
  object AdvFormStyler1: TAdvFormStyler
    AppColor = clActiveCaption
    AutoThemeAdapt = True
    Style = tsOffice2019White
    Left = 365
    Top = 248
  end
  object Vectors: TAdvSVGImageCollection
    Images = <>
    Left = 368
    Top = 152
  end
  object ToolVectors: TAdvSVGImageCollection
    Images = <
      item
        Data.Data = {
          0D544164765356474269746D6170810400003C7376672069643D224C61796572
          5F312220656E61626C652D6261636B67726F756E643D226E6577203020302035
          31322035313222206865696768743D22353132222076696577426F783D223020
          302035313220353132222077696474683D223531322220786D6C6E733D226874
          74703A2F2F7777772E77332E6F72672F323030302F737667223E3C673E3C7061
          746820643D226D31323220366833323076343438682D3332307A222066696C6C
          3D2223623963326366222F3E3C7061746820643D226D31323220343338683332
          30763136682D3332307A222066696C6C3D2223393561346236222F3E3C706174
          6820643D226D373020343236762D3336386833323076343438682D3234307A22
          2066696C6C3D2223666666222F3E3C7061746820643D226D3135302034393068
          323430763136682D3234307A222066696C6C3D2223646365316537222F3E3C70
          61746820643D226D373020343236683830763830222066696C6C3D2223393561
          346236222F3E3C673E3C673E3C7061746820643D226D31313820313836683232
          3476313630682D3232347A222066696C6C3D2223646365316537222F3E3C7061
          746820643D226D323632203235302D34302034302D32342D32342D3830203830
          68323234762D31367A222066696C6C3D2223393561346236222F3E3C70617468
          20643D226D33343220333330763136682D3232346C31362D31367A222066696C
          6C3D2223373238363965222F3E3C2F673E3C2F673E3C672066696C6C3D222330
          3132643461223E3C7061746820643D226D3434382030682D333332763532682D
          3532763337362E3438356C38332E3531352038332E353135683234382E343835
          762D35326835327A6D2D333034203439312E3531352D35392E3531352D35392E
          3531356835392E3531357A6D32343020382E343835682D323238762D3830682D
          3830762D333536683330387A6D35322D3532682D3430762D333936682D323638
          762D3430683330387A222F3E3C7061746820643D226D31313820313136683936
          763132682D39367A222F3E3C7061746820643D226D3131382031343868393676
          3132682D39367A222F3E3C7061746820643D226D323436203131366839367631
          32682D39367A222F3E3C7061746820643D226D32343620313438683936763132
          682D39367A222F3E3C7061746820643D226D33343820313830682D3233367631
          3732683233367A6D2D3132203132763132332E3531356C2D37342D37342E3030
          312D34302034302D32342D32342D3734203734762D3133392E3531347A6D2D32
          30332E353135203134382036352E3531352D36352E3531352035312E37353720
          35312E37353720382E3438352D382E3438352D32372E3735372D32372E373537
          2033312E3531352D33312E3531352037342037332E39393976372E3531367A22
          2F3E3C7061746820643D226D3131382033373268323234763132682D3232347A
          222F3E3C7061746820643D226D3138322034303468313630763132682D313630
          7A222F3E3C7061746820643D226D3138322034333668313630763132682D3136
          307A222F3E3C2F673E3C2F673E3C2F7376673E}
        Name = 'folder'
      end
      item
        Data.Data = {
          0D544164765356474269746D6170660500003C7376672069643D224C61796572
          5F312220656E61626C652D6261636B67726F756E643D226E6577203020302035
          31322035313222206865696768743D22353132222076696577426F783D223020
          302035313220353132222077696474683D223531322220786D6C6E733D226874
          74703A2F2F7777772E77332E6F72672F323030302F737667223E3C673E3C7061
          746820643D226D31323220366833323076343438682D3332307A222066696C6C
          3D2223623963326366222F3E3C7061746820643D226D31323220343338683332
          30763136682D3332307A222066696C6C3D2223393561346236222F3E3C706174
          6820643D226D3339302031333876333638682D333230762D343438683234307A
          222066696C6C3D2223666666222F3E3C7061746820643D226D33313020313338
          683830763136682D38307A222066696C6C3D2223646365316537222F3E3C7061
          746820643D226D37302034393068333230763136682D3332307A222066696C6C
          3D2223646365316537222F3E3C672066696C6C3D2223393561346236223E3C70
          61746820643D226D33393020313338682D3830762D3830222F3E3C7061746820
          643D226D31393820313134683332763332682D33327A222F3E3C706174682064
          3D226D32333020313436683332763332682D33327A222F3E3C7061746820643D
          226D31393820313738683332763332682D33327A222F3E3C7061746820643D22
          6D32333020323130683332763332682D33327A222F3E3C7061746820643D226D
          31393820323432683332763332682D33327A22207472616E73666F726D3D226D
          6174726978282D3120302030202D31203432382035313629222F3E3C70617468
          20643D226D32333020323734683332763332682D33327A22207472616E73666F
          726D3D226D6174726978282D3120302030202D31203439322035383029222F3E
          3C7061746820643D226D31393820333036683332763332682D33327A22207472
          616E73666F726D3D226D6174726978282D3120302030202D3120343238203634
          3429222F3E3C2F673E3C7061746820643D226D32353420343530682D3438762D
          35366C32342D32342032342032347A222066696C6C3D2223623963326366222F
          3E3C7061746820643D226D32303620343236683438763234682D34387A222066
          696C6C3D2223666666222F3E3C672066696C6C3D2223303132643461223E3C70
          61746820643D226D3434382030682D333332763532682D353276343630683333
          32762D35326835327A6D2D33373220353030762D343336683232387638306838
          30763335367A6D3234302D3432372E3531352035392E3531352035392E353135
          682D35392E3531357A6D313230203337352E353135682D3430762D3331322E34
          38356C2D38332E3531352D38332E353135682D3138342E343835762D34306833
          30387A222F3E3C7061746820643D226D32333620313038682D34347634346833
          32763230682D3332763434683332763230682D3332763434683332763230682D
          33327634346833327632332E3531356C2D32342032347636342E343835683630
          762D36342E3438356C2D32342D3234762D35352E353135683332762D3434682D
          3332762D3230683332762D3434682D3332762D3230683332762D3434682D3332
          7A6D2D3332203332762D32306832307632307A6D30203634762D323068323076
          32307A6D30203634762D32306832307632307A6D30203634762D323068323076
          32307A6D3820313132762D31326833367631327A6D33362D3234682D3336762D
          32332E3531356C31382D31382031382031387A6D382D313430763230682D3230
          762D32307A6D302D3634763230682D3230762D32307A6D302D3634763230682D
          3230762D32307A222F3E3C2F673E3C2F673E3C2F7376673E}
        Name = 'zip'
      end
      item
        Data.Data = {
          0D544164765356474269746D6170B30500003C7376672069643D224C61796572
          5F312220656E61626C652D6261636B67726F756E643D226E6577203020302035
          31322035313222206865696768743D22353132222076696577426F783D223020
          302035313220353132222077696474683D223531322220786D6C6E733D226874
          74703A2F2F7777772E77332E6F72672F323030302F737667223E3C673E3C7061
          746820643D226D32303820323636762D3236306832353676323630222066696C
          6C3D2223623963326366222F3E3C7061746820643D226D323038203235306832
          3536763136682D3235367A222066696C6C3D2223393561346236222F3E3C7061
          746820643D226D34333220353036682D343030762D3332306831313276333268
          3238387A222066696C6C3D2223393561346236222F3E3C7061746820643D226D
          33322034393068343438763136682D3434387A222066696C6C3D222337323836
          3965222F3E3C7061746820643D226D3433322031313876313438682D32353676
          2D323238683137367A222066696C6C3D2223666666222F3E3C672066696C6C3D
          2223646365316537223E3C7061746820643D226D333532203131386838307631
          36682D38307A222F3E3C7061746820643D226D31373620323530683235367631
          36682D3235367A222F3E3C7061746820643D226D383020323636683430307632
          3430682D3430307A222F3E3C2F673E3C7061746820643D226D38302034393068
          343030763136682D3430307A222066696C6C3D2223623963326366222F3E3C70
          61746820643D226D33363820343432683830763332682D38307A222066696C6C
          3D2223666666222F3E3C7061746820643D226D34333220313138682D3830762D
          3830222066696C6C3D2223393561346236222F3E3C673E3C7061746820643D22
          6D3230382031343468313736763936682D3137367A222066696C6C3D22236666
          66222F3E3C7061746820643D226D32383820313434683936763332682D39367A
          222066696C6C3D2223393561346236222F3E3C7061746820643D226D32303820
          31373668313736763634682D3137367A222066696C6C3D222364636531653722
          2F3E3C7061746820643D226D32303820313736683332763634682D33327A2220
          66696C6C3D2223393561346236222F3E3C672066696C6C3D2223303132643461
          223E3C7061746820643D226D34373020323630762D323630682D323638763332
          682D333276313830682D3230762D3332682D3132347633333268343630762D32
          35327A6D2D3235362D3234386832343476323438682D3230762D3134342E3438
          356C2D38332E3531352D38332E353135682D3134302E3438357A6D3134342034
          302E3438352035392E3531352035392E353135682D35392E3531357A6D2D3132
          2D382E34383576383068383076313336682D323434762D3231367A6D2D323732
          20343536682D3336762D33303868313030763230682D37347631326831303676
          3336682D39367A6D3430302030682D333838762D323238683338387A222F3E3C
          7061746820643D226D34353420343336682D39327634346839327A6D2D313220
          3332682D3638762D32306836387A222F3E3C7061746820643D226D3230382031
          3034683634763132682D36347A222F3E3C7061746820643D226D323038203732
          683936763132682D39367A222F3E3C7061746820643D226D3339302031333868
          2D31383876313038683138387A6D2D3132203332682D3336762D32306833367A
          6D2D313332203132683336763230682D33367A6D2D3132203230682D3230762D
          32306832307A6D3438203132763230682D3336762D32307A6D31322030683336
          763230682D33367A6D302D3132762D32306833367632307A6D302D3332762D32
          306833367632307A6D3438203132683336763230682D33367A6D2D36302D3332
          763230682D3638762D32307A6D2D3638203634683230763230682D32307A6D31
          3238203230762D32306833367632307A222F3E3C2F673E3C2F673E3C2F673E3C
          2F7376673E}
        Name = 'sheet'
      end>
    Left = 373
    Top = 88
  end
  object Excel: TAdvGridExcelIO
    AdvStringGrid = Grid
    Options.ExportOverwrite = omAlways
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    Options.ExportRawRTF = False
    Options.ExportShowInExcel = True
    UseUnicode = False
    GridStartRow = 0
    GridStartCol = 0
    Version = '3.14'
    Left = 80
    Top = 320
  end
  object dlgOpenZip: TFileOpenDialog
    DefaultExtension = 'zip'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'ZIP Archive'
        FileMask = '*.zip'
      end>
    Options = [fdoPathMustExist, fdoFileMustExist]
    Title = 'Open ZIP archive'
    Left = 149
    Top = 320
  end
  object dlgSaveExcel: TFileSaveDialog
    DefaultExtension = 'xls'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Excel Document'
        FileMask = '*.xls'
      end>
    Options = [fdoOverWritePrompt, fdoPathMustExist]
    Left = 213
    Top = 320
  end
  object AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler
    AppColor.AppButtonColor = clActiveCaption
    AppColor.AppButtonHoverColor = 11704706
    AppColor.TextColor = clWhite
    AppColor.HoverColor = 16771783
    AppColor.HoverTextColor = clBlack
    AppColor.HoverBorderColor = 15187578
    AppColor.SelectedColor = 11704706
    AppColor.SelectedTextColor = clBlack
    AppColor.SelectedBorderColor = 15187578
    Style = bsOffice2019White
    AutoThemeAdapt = True
    BorderColor = 12895944
    ButtonAppearance.CaptionTextColor = 4474440
    ButtonAppearance.CaptionTextColorHot = 4474440
    ButtonAppearance.BorderDownColor = clNone
    ButtonAppearance.BorderHotColor = clNone
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -12
    ButtonAppearance.CaptionFont.Name = 'Segoe UI'
    ButtonAppearance.CaptionFont.Style = []
    CaptionAppearance.CaptionColor = clWhite
    CaptionAppearance.CaptionColorTo = clWhite
    CaptionAppearance.CaptionTextColor = 4474440
    CaptionAppearance.CaptionColorHot = 15917525
    CaptionAppearance.CaptionColorHotTo = 15917525
    CaptionAppearance.CaptionTextColorHot = 4474440
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Segoe UI'
    CaptionFont.Style = []
    ContainerAppearance.LineColor = clBtnShadow
    ContainerAppearance.Line3D = True
    Color.Color = clWhite
    Color.ColorTo = clWhite
    Color.Direction = gdVertical
    Color.Mirror.Color = clWhite
    Color.Mirror.ColorTo = clBtnFace
    Color.Mirror.ColorMirror = 15587784
    Color.Mirror.ColorMirrorTo = 16774371
    ColorHot.Color = clNone
    ColorHot.ColorTo = clNone
    ColorHot.Direction = gdHorizontal
    ColorHot.Mirror.Color = clWhite
    ColorHot.Mirror.ColorTo = clBtnFace
    ColorHot.Mirror.ColorMirror = 15587784
    ColorHot.Mirror.ColorMirrorTo = 16774371
    CompactGlowButtonAppearance.Color = clWhite
    CompactGlowButtonAppearance.ColorTo = clWhite
    CompactGlowButtonAppearance.ColorChecked = 16111818
    CompactGlowButtonAppearance.ColorCheckedTo = 16367008
    CompactGlowButtonAppearance.ColorDisabled = 15921906
    CompactGlowButtonAppearance.ColorDisabledTo = 15921906
    CompactGlowButtonAppearance.ColorDown = 16111818
    CompactGlowButtonAppearance.ColorDownTo = 16367008
    CompactGlowButtonAppearance.ColorHot = 16117985
    CompactGlowButtonAppearance.ColorHotTo = 16372402
    CompactGlowButtonAppearance.ColorMirror = clSilver
    CompactGlowButtonAppearance.ColorMirrorTo = clWhite
    CompactGlowButtonAppearance.ColorMirrorHot = 16107693
    CompactGlowButtonAppearance.ColorMirrorHotTo = 16775412
    CompactGlowButtonAppearance.ColorMirrorDown = 16102556
    CompactGlowButtonAppearance.ColorMirrorDownTo = 16768988
    CompactGlowButtonAppearance.ColorMirrorChecked = 16102556
    CompactGlowButtonAppearance.ColorMirrorCheckedTo = 16768988
    CompactGlowButtonAppearance.ColorMirrorDisabled = 11974326
    CompactGlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    DockColor.Color = clWhite
    DockColor.ColorTo = clWhite
    DockColor.Direction = gdHorizontal
    DockColor.Steps = 1
    DragGripStyle = dsNone
    FloatingWindowBorderColor = 7171437
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    GlowButtonAppearance.BorderColor = clWhite
    GlowButtonAppearance.BorderColorHot = 15917525
    GlowButtonAppearance.BorderColorDown = 14925219
    GlowButtonAppearance.BorderColorChecked = 15917525
    GlowButtonAppearance.Color = clWhite
    GlowButtonAppearance.ColorTo = clWhite
    GlowButtonAppearance.ColorChecked = 15917525
    GlowButtonAppearance.ColorCheckedTo = 15917525
    GlowButtonAppearance.ColorDisabled = 15921906
    GlowButtonAppearance.ColorDisabledTo = 15921906
    GlowButtonAppearance.ColorDown = 14925219
    GlowButtonAppearance.ColorDownTo = 14925219
    GlowButtonAppearance.ColorHot = 15917525
    GlowButtonAppearance.ColorHotTo = 15917525
    GlowButtonAppearance.ColorMirror = clWhite
    GlowButtonAppearance.ColorMirrorTo = clWhite
    GlowButtonAppearance.ColorMirrorHot = 15917525
    GlowButtonAppearance.ColorMirrorHotTo = 15917525
    GlowButtonAppearance.ColorMirrorDown = 14925219
    GlowButtonAppearance.ColorMirrorDownTo = 14925219
    GlowButtonAppearance.ColorMirrorChecked = 15917525
    GlowButtonAppearance.ColorMirrorCheckedTo = 15917525
    GlowButtonAppearance.ColorMirrorDisabled = 11974326
    GlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    GlowButtonAppearance.TextColorChecked = 3881787
    GlowButtonAppearance.TextColorDown = 4474440
    GlowButtonAppearance.TextColorHot = 4474440
    GroupAppearance.Background = clInfoBk
    GroupAppearance.BorderColor = 10729644
    GroupAppearance.Color = clWhite
    GroupAppearance.ColorTo = clWhite
    GroupAppearance.ColorMirror = clSilver
    GroupAppearance.ColorMirrorTo = clWhite
    GroupAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.Font.Color = clWindowText
    GroupAppearance.Font.Height = -12
    GroupAppearance.Font.Name = 'Segoe UI'
    GroupAppearance.Font.Style = []
    GroupAppearance.Gradient = ggVertical
    GroupAppearance.GradientMirror = ggVertical
    GroupAppearance.TextColor = clBlue
    GroupAppearance.CaptionAppearance.CaptionColor = clGray
    GroupAppearance.PageAppearance.BorderColor = clGray
    GroupAppearance.PageAppearance.Color = clWhite
    GroupAppearance.PageAppearance.ColorTo = clWhite
    GroupAppearance.PageAppearance.ColorMirror = clSilver
    GroupAppearance.PageAppearance.ColorMirrorTo = clWhite
    GroupAppearance.PageAppearance.Gradient = ggVertical
    GroupAppearance.PageAppearance.GradientMirror = ggVertical
    GroupAppearance.PageAppearance.ShadowColor = 12888726
    GroupAppearance.PageAppearance.HighLightColor = 16644558
    GroupAppearance.TabAppearance.BorderColor = clBtnFace
    GroupAppearance.TabAppearance.BorderColorHot = clBlue
    GroupAppearance.TabAppearance.BorderColorSelected = clBtnFace
    GroupAppearance.TabAppearance.BorderColorSelectedHot = clNone
    GroupAppearance.TabAppearance.BorderColorDisabled = clNone
    GroupAppearance.TabAppearance.BorderColorDown = clNone
    GroupAppearance.TabAppearance.Color = clBtnFace
    GroupAppearance.TabAppearance.ColorTo = clWhite
    GroupAppearance.TabAppearance.ColorSelected = clWhite
    GroupAppearance.TabAppearance.ColorSelectedTo = clBtnFace
    GroupAppearance.TabAppearance.ColorDisabled = clNone
    GroupAppearance.TabAppearance.ColorDisabledTo = clNone
    GroupAppearance.TabAppearance.ColorHot = clYellow
    GroupAppearance.TabAppearance.ColorHotTo = clNone
    GroupAppearance.TabAppearance.ColorMirror = clWhite
    GroupAppearance.TabAppearance.ColorMirrorTo = clWhite
    GroupAppearance.TabAppearance.ColorMirrorHot = clNone
    GroupAppearance.TabAppearance.ColorMirrorHotTo = clNone
    GroupAppearance.TabAppearance.ColorMirrorSelected = clWhite
    GroupAppearance.TabAppearance.ColorMirrorSelectedTo = clWhite
    GroupAppearance.TabAppearance.ColorMirrorDisabled = clNone
    GroupAppearance.TabAppearance.ColorMirrorDisabledTo = clNone
    GroupAppearance.TabAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.TabAppearance.Font.Color = clWindowText
    GroupAppearance.TabAppearance.Font.Height = -11
    GroupAppearance.TabAppearance.Font.Name = 'Segoe UI'
    GroupAppearance.TabAppearance.Font.Style = []
    GroupAppearance.TabAppearance.Gradient = ggVertical
    GroupAppearance.TabAppearance.GradientMirror = ggVertical
    GroupAppearance.TabAppearance.GradientHot = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorHot = ggVertical
    GroupAppearance.TabAppearance.GradientSelected = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorSelected = ggVertical
    GroupAppearance.TabAppearance.GradientDisabled = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorDisabled = ggVertical
    GroupAppearance.TabAppearance.TextColor = clBlue
    GroupAppearance.TabAppearance.TextColorHot = clBlue
    GroupAppearance.TabAppearance.TextColorSelected = clBlue
    GroupAppearance.TabAppearance.TextColorDisabled = clWhite
    GroupAppearance.TabAppearance.ShadowColor = 15255470
    GroupAppearance.TabAppearance.HighLightColor = 16775871
    GroupAppearance.TabAppearance.HighLightColorHot = 16643309
    GroupAppearance.TabAppearance.HighLightColorSelected = 6540536
    GroupAppearance.TabAppearance.HighLightColorSelectedHot = 12451839
    GroupAppearance.TabAppearance.HighLightColorDown = 16776144
    GroupAppearance.ToolBarAppearance.Color.Color = clWhite
    GroupAppearance.ToolBarAppearance.Color.ColorTo = clBtnFace
    GroupAppearance.ToolBarAppearance.Color.Direction = gdHorizontal
    GroupAppearance.ToolBarAppearance.ColorHot.Color = clNone
    GroupAppearance.ToolBarAppearance.ColorHot.ColorTo = clNone
    GroupAppearance.ToolBarAppearance.ColorHot.Direction = gdHorizontal
    PageAppearance.BorderColor = clGray
    PageAppearance.Color = clWhite
    PageAppearance.ColorTo = clWhite
    PageAppearance.ColorMirror = clSilver
    PageAppearance.ColorMirrorTo = clWhite
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    PageAppearance.ShadowColor = 12888726
    PageAppearance.HighLightColor = 16644558
    PagerCaption.BorderColor = clGray
    PagerCaption.Color = clWhite
    PagerCaption.ColorTo = clWhite
    PagerCaption.ColorMirror = clSilver
    PagerCaption.ColorMirrorTo = clWhite
    PagerCaption.Gradient = ggVertical
    PagerCaption.GradientMirror = ggVertical
    PagerCaption.TextColor = clWhite
    PagerCaption.TextColorExtended = clWhite
    PagerCaption.Font.Charset = DEFAULT_CHARSET
    PagerCaption.Font.Color = clWindowText
    PagerCaption.Font.Height = -11
    PagerCaption.Font.Name = 'Segoe UI'
    PagerCaption.Font.Style = []
    QATAppearance.BorderColor = clGray
    QATAppearance.Color = clWhite
    QATAppearance.ColorTo = clSilver
    QATAppearance.FullSizeBorderColor = clBlack
    QATAppearance.FullSizeColor = 12951425
    QATAppearance.FullSizeColorTo = 14922381
    RightHandleColor = clWhite
    RightHandleColorTo = clWhite
    RightHandleColorHot = 15917525
    RightHandleColorHotTo = 15917525
    RightHandleColorDown = 14925219
    RightHandleColorDownTo = 14925219
    TabAppearance.BorderColor = clBtnFace
    TabAppearance.BorderColorHot = clBlue
    TabAppearance.BorderColorSelected = clBtnFace
    TabAppearance.BorderColorSelectedHot = clNone
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = clNone
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = clWhite
    TabAppearance.ColorSelectedTo = clBtnFace
    TabAppearance.ColorDisabled = clNone
    TabAppearance.ColorDisabledTo = clNone
    TabAppearance.ColorHot = clYellow
    TabAppearance.ColorHotTo = clNone
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = clNone
    TabAppearance.ColorMirrorHotTo = clNone
    TabAppearance.ColorMirrorSelected = clWhite
    TabAppearance.ColorMirrorSelectedTo = clWhite
    TabAppearance.ColorMirrorDisabled = clNone
    TabAppearance.ColorMirrorDisabledTo = clNone
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Segoe UI'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggVertical
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = clBlue
    TabAppearance.TextColorHot = clBlue
    TabAppearance.TextColorSelected = clBlue
    TabAppearance.TextColorDisabled = clWhite
    TabAppearance.ShadowColor = 15255470
    TabAppearance.HighLightColor = 16775871
    TabAppearance.HighLightColorHot = 16643309
    TabAppearance.HighLightColorSelected = 6540536
    TabAppearance.HighLightColorSelectedHot = 12451839
    TabAppearance.HighLightColorDown = 16776144
    TabAppearance.BackGround.Color = clWhite
    TabAppearance.BackGround.ColorTo = clBtnFace
    TabAppearance.BackGround.Direction = gdHorizontal
    Left = 592
    Top = 8
  end
end
