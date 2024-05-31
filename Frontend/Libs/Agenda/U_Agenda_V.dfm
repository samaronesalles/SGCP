object frmAgenda_V: TfrmAgenda_V
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Agenda'
  ClientHeight = 771
  ClientWidth = 1505
  Color = clBtnFace
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  TextHeight = 16
  object Splitter: TSplitter
    Left = 350
    Top = 0
    Width = 2
    Height = 771
    ExplicitLeft = 300
    ExplicitHeight = 759
  end
  object PanelLateralEsquerdo: TPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 771
    Align = alLeft
    Color = clWhite
    Constraints.MinWidth = 300
    ParentBackground = False
    TabOrder = 0
    TabStop = True
    object LabelHoraAtual: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 346
      Width = 342
      Height = 21
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alTop
      Alignment = taCenter
      Caption = 'Hora atual: 21:56:13'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 163
    end
    object CalendarView: TCalendarView
      Left = 1
      Top = 1
      Width = 348
      Align = alTop
      Date = 45439.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -25
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      HeaderInfo.DaysOfWeekFont.Color = clWindowText
      HeaderInfo.DaysOfWeekFont.Height = -17
      HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      HeaderInfo.DaysOfWeekFont.Style = []
      HeaderInfo.Font.Charset = DEFAULT_CHARSET
      HeaderInfo.Font.Color = clWindowText
      HeaderInfo.Font.Height = -25
      HeaderInfo.Font.Name = 'Segoe UI'
      HeaderInfo.Font.Style = []
      OnClick = CalendarViewClick
      ParentFont = False
      TabOrder = 1
      TabStop = False
    end
    object PanelFiltroAgenda: TPanel
      Left = 1
      Top = 375
      Width = 348
      Height = 395
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      TabStop = True
      object LabelTituloFiltro: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 24
        Width = 332
        Height = 16
        Margins.Left = 8
        Margins.Top = 24
        Margins.Right = 8
        Align = alTop
        Caption = 'Exibindo agenda de:'
        ExplicitWidth = 118
      end
      object BevelTituloFiltroAgenda: TBevel
        AlignWithMargins = True
        Left = 8
        Top = 44
        Width = 332
        Height = 2
        Margins.Left = 8
        Margins.Top = 1
        Margins.Right = 8
        Align = alTop
        Shape = bsBottomLine
        ExplicitWidth = 273
      end
      object Label_idProfissional: TLabel
        Left = 43
        Top = 52
        Width = 77
        Height = 16
        Caption = 'idProfissional'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object Label_idPaciente: TLabel
        Left = 188
        Top = 52
        Width = 61
        Height = 16
        Caption = 'idPaciente'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object PanelFiltroProfissional: TPanel
        AlignWithMargins = True
        Left = 8
        Top = 73
        Width = 332
        Height = 32
        Margins.Left = 8
        Margins.Top = 24
        Margins.Right = 8
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        TabStop = True
        DesignSize = (
          332
          32)
        object Label4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 71
          Height = 26
          Align = alLeft
          Caption = 'Profissional:'
          Layout = tlCenter
          ExplicitHeight = 16
        end
        object EditFiltroProfissional: TEdit
          Left = 78
          Top = 4
          Width = 253
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = EditFiltroProfissionalChange
          OnExit = EditFiltroProfissionalExit
        end
      end
      object PanelFiltroPaciente: TPanel
        AlignWithMargins = True
        Left = 8
        Top = 108
        Width = 332
        Height = 32
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 8
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        TabStop = True
        DesignSize = (
          332
          32)
        object Label5: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 55
          Height = 26
          Align = alLeft
          Caption = 'Paciente:'
          Layout = tlCenter
          ExplicitHeight = 16
        end
        object EditFiltroPaciente: TEdit
          Left = 78
          Top = 5
          Width = 253
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = EditFiltroPacienteChange
          OnExit = EditFiltroPacienteExit
        end
      end
    end
  end
  object PanelMain: TPanel
    Left = 352
    Top = 0
    Width = 1153
    Height = 771
    Align = alClient
    Color = clWhite
    Constraints.MinWidth = 750
    ParentBackground = False
    TabOrder = 1
    object PanelButtons: TPanel
      Left = 1
      Top = 700
      Width = 1151
      Height = 70
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object PanelLegenda: TPanel
        AlignWithMargins = True
        Left = 60
        Top = 0
        Width = 288
        Height = 70
        Margins.Left = 60
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 3
          Width = 53
          Height = 16
          Caption = 'Legenda:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = 11
          Top = 19
          Width = 60
          Height = 2
        end
        object Shape_legenda_NaoConfirmados: TShape
          Left = 11
          Top = 31
          Width = 12
          Height = 12
          Brush.Color = clBlack
          Shape = stCircle
        end
        object Shape_legenda_Confirmados: TShape
          Left = 11
          Top = 49
          Width = 12
          Height = 12
          Brush.Color = clRed
          Shape = stCircle
        end
        object Label2: TLabel
          Left = 29
          Top = 29
          Width = 95
          Height = 15
          Caption = 'N'#227'o confirmados'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 29
          Top = 47
          Width = 72
          Height = 15
          Caption = 'Confirmados'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel_btnsRight: TPanel
        Left = 921
        Top = 0
        Width = 230
        Height = 70
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object ButtonSair: TButton
          Left = 129
          Top = 21
          Width = 85
          Height = 30
          BiDiMode = bdLeftToRight
          Caption = '&Fechar'
          ImageIndex = 3
          Images = ImageList_Icons
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = ButtonSairClick
        end
      end
    end
    object PanelTop: TPanel
      Left = 1
      Top = 1
      Width = 1151
      Height = 88
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 16
        Top = 63
        Width = 444
        Height = 2
        Margins.Left = 8
        Margins.Top = 1
        Margins.Right = 8
        Shape = bsTopLine
      end
      object LabelSemanaSelecionada: TLabel
        Left = 16
        Top = 39
        Width = 424
        Height = 26
        Caption = 'Compromissos da semana: 00/00 a 00/00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Panel_TopBtnsRight: TPanel
        Left = 1031
        Top = 0
        Width = 120
        Height = 88
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          120
          88)
        object SpeedButton_Delete: TSpeedButton
          Left = 66
          Top = 36
          Width = 42
          Height = 42
          Hint = 'Excluir evento selecionado'
          Anchors = [akRight, akBottom]
          ImageIndex = 1
          Images = ImageListIcons_42x42
          ParentShowHint = False
          ShowHint = True
          ExplicitTop = 52
        end
        object SpeedButton_Incluir: TSpeedButton
          Left = 15
          Top = 36
          Width = 42
          Height = 42
          Hint = 'Incluir novo evento'
          Anchors = [akRight, akBottom]
          ImageIndex = 0
          Images = ImageListIcons_42x42
          ParentShowHint = False
          ShowHint = True
          ExplicitTop = 52
        end
      end
    end
    object ScrollBoxMain: TScrollBox
      Left = 1
      Top = 89
      Width = 1151
      Height = 611
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      ParentColor = False
      TabOrder = 2
      object PanelConteudoAgenda: TPanel
        Left = 0
        Top = 0
        Width = 1127
        Height = 1260
        ParentCustomHint = False
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        Color = clWhite
        Ctl3D = True
        DoubleBuffered = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentBiDiMode = False
        ParentBackground = False
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentFont = False
        ParentShowHint = False
        ShowCaption = False
        ShowHint = False
        TabOrder = 0
        object PanelIntervaloHoras: TPanel
          Left = 0
          Top = 0
          Width = 70
          Height = 1260
          Align = alLeft
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object Label_0500: TLabel
            Left = 33
            Top = 50
            Width = 32
            Height = 16
            Caption = '05:00'
          end
          object Label_0600: TLabel
            Left = 33
            Top = 112
            Width = 32
            Height = 16
            Caption = '06:00'
          end
          object Label_0800: TLabel
            Left = 33
            Top = 234
            Width = 32
            Height = 16
            Caption = '08:00'
          end
          object Label_0700: TLabel
            Left = 33
            Top = 173
            Width = 32
            Height = 16
            Caption = '07:00'
          end
          object Label_1200: TLabel
            Left = 33
            Top = 478
            Width = 32
            Height = 16
            Caption = '12:00'
          end
          object Label_1100: TLabel
            Left = 33
            Top = 417
            Width = 31
            Height = 16
            Caption = '11:00'
          end
          object Label_1000: TLabel
            Left = 33
            Top = 356
            Width = 32
            Height = 16
            Caption = '10:00'
          end
          object Label_0900: TLabel
            Left = 33
            Top = 295
            Width = 32
            Height = 16
            Caption = '09:00'
          end
          object Label_1600: TLabel
            Left = 33
            Top = 722
            Width = 32
            Height = 16
            Caption = '16:00'
          end
          object Label_1500: TLabel
            Left = 33
            Top = 661
            Width = 32
            Height = 16
            Caption = '15:00'
          end
          object Label_1400: TLabel
            Left = 33
            Top = 600
            Width = 32
            Height = 16
            Caption = '14:00'
          end
          object Label_1300: TLabel
            Left = 33
            Top = 539
            Width = 32
            Height = 16
            Caption = '13:00'
          end
          object Label_2100: TLabel
            Left = 33
            Top = 1027
            Width = 32
            Height = 16
            Caption = '21:00'
          end
          object Label_2000: TLabel
            Left = 33
            Top = 966
            Width = 32
            Height = 16
            Caption = '20:00'
          end
          object Label_1900: TLabel
            Left = 33
            Top = 905
            Width = 32
            Height = 16
            Caption = '19:00'
          end
          object Label_1800: TLabel
            Left = 33
            Top = 844
            Width = 32
            Height = 16
            Caption = '18:00'
          end
          object Label_1700: TLabel
            Left = 33
            Top = 783
            Width = 32
            Height = 16
            Caption = '17:00'
          end
          object Label_0000: TLabel
            Left = 33
            Top = 1210
            Width = 32
            Height = 16
            Caption = '00:00'
          end
          object Label_2300: TLabel
            Left = 33
            Top = 1149
            Width = 32
            Height = 16
            Caption = '23:00'
          end
          object Label_2200: TLabel
            Left = 33
            Top = 1088
            Width = 32
            Height = 16
            Caption = '22:00'
          end
        end
        object DrawGridEventos: TDrawGrid
          Left = 70
          Top = 0
          Width = 1057
          Height = 1260
          ParentCustomHint = False
          TabStop = False
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWhite
          ColCount = 7
          Ctl3D = False
          DefaultColWidth = 150
          DefaultRowHeight = 60
          FixedCols = 0
          RowCount = 20
          FixedRows = 0
          Options = [goVertLine, goHorzLine]
          ParentCtl3D = False
          ScrollBars = ssNone
          TabOrder = 1
          OnDrawCell = DrawGridEventosDrawCell
          OnSelectCell = DrawGridEventosSelectCell
        end
        object Panel_HoraAnalogica_Atual: TPanel
          Left = 70
          Top = 130
          Width = 1060
          Height = 3
          ParentCustomHint = False
          BevelOuter = bvNone
          BiDiMode = bdLeftToRight
          Color = clRed
          Ctl3D = True
          DoubleBuffered = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentBiDiMode = False
          ParentBackground = False
          ParentCtl3D = False
          ParentDoubleBuffered = False
          ParentFont = False
          ParentShowHint = False
          ShowCaption = False
          ShowHint = False
          TabOrder = 2
          Visible = False
        end
        object Panel_Titulo_DOM: TPanel
          Left = 75
          Top = 7
          Width = 140
          Height = 45
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 3
          DesignSize = (
            140
            45)
          object ShapeDiaAtual_DOM: TShape
            Left = 46
            Top = 3
            Width = 48
            Height = 40
            Cursor = crHandPoint
            Anchors = [akLeft, akTop, akRight, akBottom]
            Brush.Color = 10997435
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 49
            ExplicitHeight = 46
          end
          object Label_DOM: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 8
            Width = 134
            Height = 34
            Cursor = crHandPoint
            Hint = 'Data atual'
            Margins.Top = 8
            Align = alClient
            Alignment = taCenter
            Caption = 'DOM'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 30
            ExplicitHeight = 16
          end
        end
        object Panel_Titulo_QUA: TPanel
          Left = 528
          Top = 7
          Width = 140
          Height = 45
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 4
          DesignSize = (
            140
            45)
          object ShapeDiaAtual_QUA: TShape
            Left = 46
            Top = 3
            Width = 48
            Height = 40
            Cursor = crHandPoint
            Anchors = [akLeft, akTop, akRight, akBottom]
            Brush.Color = 10997435
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 49
            ExplicitHeight = 46
          end
          object Label_QUA: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 8
            Width = 134
            Height = 34
            Cursor = crHandPoint
            Hint = 'Data atual'
            Margins.Top = 8
            Align = alClient
            Alignment = taCenter
            Caption = 'QUA'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 28
            ExplicitHeight = 16
          end
        end
        object Panel_Titulo_QUI: TPanel
          Left = 679
          Top = 7
          Width = 140
          Height = 45
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 5
          DesignSize = (
            140
            45)
          object ShapeDiaAtual_QUI: TShape
            Left = 46
            Top = 3
            Width = 48
            Height = 40
            Cursor = crHandPoint
            Anchors = [akLeft, akTop, akRight, akBottom]
            Brush.Color = 10997435
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 49
            ExplicitHeight = 46
          end
          object Label_QUI: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 8
            Width = 134
            Height = 34
            Cursor = crHandPoint
            Hint = 'Data atual'
            Margins.Top = 8
            Align = alClient
            Alignment = taCenter
            Caption = 'QUI'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 23
            ExplicitHeight = 16
          end
        end
        object Panel_Titulo_SAB: TPanel
          Left = 981
          Top = 7
          Width = 140
          Height = 45
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 6
          DesignSize = (
            140
            45)
          object ShapeDiaAtual_SAB: TShape
            Left = 46
            Top = 3
            Width = 48
            Height = 40
            Cursor = crHandPoint
            Anchors = [akLeft, akTop, akRight, akBottom]
            Brush.Color = 10997435
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 49
            ExplicitHeight = 46
          end
          object Label_SAB: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 8
            Width = 134
            Height = 34
            Cursor = crHandPoint
            Hint = 'Data atual'
            Margins.Top = 8
            Align = alClient
            Alignment = taCenter
            Caption = 'SAB'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 27
            ExplicitHeight = 16
          end
        end
        object Panel_Titulo_SEG: TPanel
          Left = 226
          Top = 7
          Width = 140
          Height = 45
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 7
          DesignSize = (
            140
            45)
          object ShapeDiaAtual_SEG: TShape
            Left = 46
            Top = 3
            Width = 48
            Height = 40
            Cursor = crHandPoint
            Anchors = [akLeft, akTop, akRight, akBottom]
            Brush.Color = 10997435
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 49
            ExplicitHeight = 46
          end
          object Label_SEG: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 8
            Width = 134
            Height = 34
            Cursor = crHandPoint
            Hint = 'Data atual'
            Margins.Top = 8
            Align = alClient
            Alignment = taCenter
            Caption = 'SEG'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 27
            ExplicitHeight = 16
          end
        end
        object Panel_Titulo_SEX: TPanel
          Left = 830
          Top = 7
          Width = 140
          Height = 45
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 8
          DesignSize = (
            140
            45)
          object ShapeDiaAtual_SEX: TShape
            Left = 46
            Top = 3
            Width = 48
            Height = 40
            Cursor = crHandPoint
            Anchors = [akLeft, akTop, akRight, akBottom]
            Brush.Color = 10997435
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 49
            ExplicitHeight = 46
          end
          object Label_SEX: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 8
            Width = 134
            Height = 34
            Cursor = crHandPoint
            Hint = 'Data atual'
            Margins.Top = 8
            Align = alClient
            Alignment = taCenter
            Caption = 'SEX'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 26
            ExplicitHeight = 16
          end
        end
        object Panel_Titulo_TER: TPanel
          Left = 377
          Top = 7
          Width = 140
          Height = 45
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 9
          DesignSize = (
            140
            45)
          object ShapeDiaAtual_TER: TShape
            Left = 46
            Top = 3
            Width = 48
            Height = 40
            Cursor = crHandPoint
            Anchors = [akLeft, akTop, akRight, akBottom]
            Brush.Color = 10997435
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 49
            ExplicitHeight = 46
          end
          object Label_TER: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 8
            Width = 134
            Height = 34
            Cursor = crHandPoint
            Hint = 'Data atual'
            Margins.Top = 8
            Align = alClient
            Alignment = taCenter
            Caption = 'TER'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 25
            ExplicitHeight = 16
          end
        end
      end
    end
  end
  object ImageList_Icons: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 24
    Width = 24
    Left = 10
    Top = 592
    Bitmap = {
      494C010107000800040018001800FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000600000003000000001002000000000000048
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000010003203D2DF2FF3D2DF2FF3D2D
      F2FF3D2DF2FF3D2DF2FF3D2DF2FF0F0B3B7F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C17106059A777FF59A7
      77FF59A777FF59A777FF44805BDF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000010320304BBDFF304BBDFF304BBDFF03040B40000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000010003203D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2D
      F2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000016291D7F59A777FF59A777FF59A777FF59A7
      77FF59A777FF59A777FF59A777FF59A777FF59A777FF315D43BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000253990DF304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B122E7F0000000000000000000000000000000000000000000000000000
      0000000000000F0B3B7F3D2DF2FF3D2DF2FF3D2DF2FF00000000000000000000
      0000000000000000000000000000010003203D2DF2FF3D2DF2FF3D2DF2FF0806
      2260000000000000000000000000000000000000000000000000000000000000
      0000000000000102012059A777FF59A777FF44805BDF00000000000000000000
      00000000000000000000000000000102012059A777FF59A777FF59A777FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B12
      2E7F304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF2539
      90DF000000000000000000000000000000000000000000000000000000000000
      0000304BBDFF253990DF00000000000000000000000000000000000000000000
      0000000000003D2DF2FF3D2DF2FF3D2DF2FF0000000000000000000000000000
      000000000000000000000000000000000000000000003D2DF2FF3D2DF2FF3D2D
      F2FF000000000000000000000000000000000000000000000000000000000000
      00000000000059A777FF59A777FF44805BDF0000000000000000000000000000
      0000000000000000000000000000000000000000000059A777FF59A777FF59A7
      77FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000304B
      BDFF304BBDFF131D499F00010320304BBDFF000103200B122E7F304BBDFF304B
      BDFF0000000000000000000000000000000000000000000000000B122E7F304B
      BDFF304BBDFF0000000000000000000000000000000000000000000000000000
      00003D2DF2FF3D2DF2FF0F0B3B7F000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003D2DF2FF3D2D
      F2FF3D2DF2FF0000000000000000000000000000000000000000000000000000
      0000315D43BF59A777FF050A0740000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000059A777FF59A7
      77FF22402E9F0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000304B
      BDFF304BBDFF304BBDFF03040B400000000000010320304BBDFF304BBDFF304B
      BDFF00000000000000000000000000000000000000000B122E7F304BBDFF304B
      BDFF000000000000000000000000000000000000000000000000000000002F22
      B9DF3D2DF2FF3D2DF2FF00000000000000003D2DF2FF2F22B9DF000000000000
      00000000000000000000000000003D2DF2FF3D2DF2FF00000000000000003D2D
      F2FF3D2DF2FF000000000000000000000000000000000000000000000000050A
      074059A777FF44805BDF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000059A7
      77FF59A777FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000304B
      BDFF304BBDFF304BBDFF000103200000000000010320304BBDFF304BBDFF304B
      BDFF0000000000000000000000000000000000000000304BBDFF304BBDFF060A
      1A60000000000000000000000000000000000000000000000000000000003D2D
      F2FF3D2DF2FF04030F4000000000000000003D2DF2FF3D2DF2FF2F22B9DF0000
      000000000000000000002F22B9DF3D2DF2FF3D2DF2FF00000000000000000403
      0F403D2DF2FF18125E9F000000000000000000000000000000000000000059A7
      77FF59A777FF000000000000000000000000000000000000000000000000315D
      43BF000000000000000000000000000000000000000000000000000000000000
      000059A777FF0102012000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000304B
      BDFF304BBDFF1B2A6ABF00010320304BBDFF03040B400B122E7F304BBDFF304B
      BDFF0000000000000000000000000B122E7F304BBDFF304BBDFF000000000000
      0000000000000000000000000000000000000000000000000000000000003D2D
      F2FF3D2DF2FF000000000000000000000000000000003D2DF2FF3D2DF2FF2F22
      B9DF000000002F22B9DF3D2DF2FF2F22B9DF0000000000000000000000000000
      00003D2DF2FF3D2DF2FF000000000000000000000000000000000000000059A7
      77FF59A777FF0000000000000000000000000000000016291D7F59A777FF59A7
      77FF315D43BF0000000000000000000000000000000000000000000000000000
      000059A777FF59A777FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B12
      2E7F304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF2539
      90DF00000000000000000B122E7F304BBDFF304BBDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000003D2D
      F2FF3D2DF2FF00000000000000000000000000000000000000003D2DF2FF3D2D
      F2FF3D2DF2FF3D2DF2FF2F22B9DF000000000000000000000000000000000000
      00003D2DF2FF3D2DF2FF000000000000000000000000000000000000000059A7
      77FF59A777FF00000000000000000000000016291D7F59A777FF59A777FF59A7
      77FF59A777FF59A777FF00000000000000000000000000000000000000000000
      000059A777FF59A777FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001B2A6ABF304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF304BBDFF0000
      00000000000000000000304BBDFF304BBDFF060A1A6000000000000000000000
      0000000000000000000000000000000000000000000000000000010003203D2D
      F2FF3D2DF2FF0000000000000000000000000000000000000000000000003D2D
      F2FF3D2DF2FF3D2DF2FF00000000000000000000000000000000000000000000
      00003D2DF2FF3D2DF2FF010003200000000000000000000000000000000059A7
      77FF59A777FF00000000000000000000000059A777FF59A777FF16291D7F0000
      000059A777FF59A777FF315D43BF000000000000000000000000000000000000
      000059A777FF59A777FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000253990DF304BBDFF304BBDFF00010320000000000000
      000000000000000000001B2A6ABF304BBDFF253990DF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000003D2D
      F2FF3D2DF2FF00000000000000000000000000000000000000002F22B9DF3D2D
      F2FF3D2DF2FF3D2DF2FF2F22B9DF000000000000000000000000000000000000
      00003D2DF2FF3D2DF2FF000000000000000000000000000000000000000059A7
      77FF59A777FF0000000000000000000000000000000000000000000000000000
      00000000000059A777FF59A777FF315D43BF0000000000000000000000000000
      000059A777FF59A777FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000304BBDFF304BBDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000003D2D
      F2FF3D2DF2FF000000000000000000000000000000003D2DF2FF3D2DF2FF2F22
      B9DF000000003D2DF2FF3D2DF2FF2F22B9DF0000000000000000000000000000
      00003D2DF2FF3D2DF2FF000000000000000000000000000000000000000059A7
      77FF59A777FF0000000000000000000000000000000000000000000000000000
      0000000000000000000059A777FF59A777FF59A777FF00000000000000000000
      000059A777FF44805BDF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000304BBDFF060A1A60000000000000000000000000000000000000
      0000000000000000000000000000304BBDFF304BBDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000003D2D
      F2FF3D2DF2FF0000000000000000000000002F22B9DF3D2DF2FF3D2DF2FF0000
      000000000000000000003D2DF2FF3D2DF2FF2F22B9DF00000000000000000000
      00003D2DF2FF2F22B9DF000000000000000000000000000000000000000059A7
      77FF59A777FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000059A777FF44805BDF00000000000000000000
      000059A777FF050A074000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000304BBDFF304BBDFF000000000000000000000000000000000000
      0000000000000000000000000000304BBDFF304BBDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000002F22
      B9DF3D2DF2FF3D2DF2FF00000000000000003D2DF2FF2F22B9DF000000000000
      00000000000000000000000000003D2DF2FF3D2DF2FF00000000000000003D2D
      F2FF3D2DF2FF0000000000000000000000000000000000000000000000000C17
      106059A777FF59A777FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000059A7
      77FF59A777FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001B2A6ABF304BBDFF060A1A600000000000000000000000000000
      0000000000000000000000000000304BBDFF304BBDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003D2DF2FF3D2DF2FF0F0B3B7F000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003D2DF2FF3D2D
      F2FF3D2DF2FF0000000000000000000000000000000000000000000000000000
      0000315D43BF59A777FF050A0740000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000059A777FF59A7
      77FF315D43BF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000010320304BBDFF304BBDFF0000000000000000000000000000
      0000000000000000000000000000304BBDFF304BBDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000010003203D2DF2FF3D2DF2FF0F0B3B7F0000000000000000000000000000
      000000000000000000000000000000000000000000000F0B3B7F3D2DF2FF3D2D
      F2FF010003200000000000000000000000000000000000000000000000000000
      00000000000059A777FF59A777FF050A07400000000000000000000000000000
      000000000000000000000000000000000000000000000102012059A777FF59A7
      77FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000304BBDFF304BBDFF304BBDFF00000000000000000000
      00000000000000000000304BBDFF304BBDFF0001032000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000080622603D2DF2FF3D2DF2FF3D2DF2FF00000000000000000000
      0000000000000000000000000000010003203D2DF2FF3D2DF2FF3D2DF2FF0F0B
      3B7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000059A777FF59A777FF59A777FF00000000000000000000
      00000000000000000000000000000102012059A777FF59A777FF59A777FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001B2A6ABF304BBDFF304BBDFF304BBDFF304B
      BDFF304BBDFF304BBDFF304BBDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000010003203D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2D
      F2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000022402E9F59A777FF59A777FF59A777FF59A7
      77FF59A777FF59A777FF59A777FF59A777FF59A777FF22402E9F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001B2A6ABF304BBDFF304BBDFF304B
      BDFF304BBDFF304BBDFF00010320000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003D2DF2FF3D2DF2FF3D2DF2FF3D2D
      F2FF3D2DF2FF3D2DF2FF3D2DF2FF3D2DF2FF2F22B9DF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000050A074059A777FF59A777FF59A7
      77FF59A777FF59A777FF59A777FF44805BDF0C17106000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000010003200000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000002012121FFF12121FFF1212
      1FFF12121FFF12121FFF12121FFF0404077F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000002012121FFF12121FFF12121FFF12121FFF1212
      1FFF12121FFF12121FFF12121FFF12121FFF12121FFF12121FFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000102201A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71
      B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      1FFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000404077F12121FFF12121FFF12121FFF00000000000000000000
      00000000000000000000000000000000002012121FFF12121FFF12121FFF0202
      0460000000000000000000000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71
      B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF0A2C469F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012121FFF1212
      1FFF0E0E18DF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000012121FFF12121FFF12121FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000012121FFF12121FFF1212
      1FFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF0000000000000000000000000000
      000000000000000000000000000000000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012121FFF12121FFF1212
      1FFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012121FFF12121FFF0404077F000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012121FFF1212
      1FFF12121FFF0000000000000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF0000000000000000000000000000
      000000000000000000000000000000000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000012121FFF12121FFF0E0E18DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000404077F12121FFF12121FFF00000000000000000000
      00000000000000000000000000000000000012121FFF12121FFF000000000000
      0000000000000000000000000000000000000000000000000000000000000E0E
      18DF12121FFF12121FFF00000000000000000000000000000000000000000404
      077F12121FFF0404077F00000000000000000000000000000000000000001212
      1FFF12121FFF0000000000000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF00000000000000001A71B7FF1A71
      B7FF000000001A71B7FF1A71B7FF00000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012121FFF12121FFF0E0E18DF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012121FFF12121FFF12121FFF000000000000
      000000000000000000000000000012121FFF12121FFF12121FFF000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      1FFF12121FFF0101024000000000000000000000000000000000000000000404
      077F12121FFF0404077F00000000000000000000000000000000000000000101
      024012121FFF07070C9F00000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF00000000000000001A71B7FF1A71
      B7FF000000001A71B7FF1A71B7FF00000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000404077F12121FFF12121FFF12121FFF1212
      1FFF000000200000000012121FFF12121FFF12121FFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000012121FFF12121FFF12121FFF0000
      0000000000000000000012121FFF12121FFF12121FFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      1FFF12121FFF0000000000000000000000000000000000000000000000000404
      077F12121FFF0404077F00000000000000000000000000000000000000000000
      000012121FFF12121FFF00000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF00000000000000001A71B7FF1A71
      B7FF000000001A71B7FF1A71B7FF00000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000002012121FFF12121FFF12121FFF12121FFF12121FFF1212
      1FFF12121FFF12121FFF12121FFF0E0E18DF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012121FFF12121FFF1212
      1FFF0000000012121FFF12121FFF12121FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      1FFF12121FFF0000000000000000000000000404077F0404077F0404077F0A0A
      11BF12121FFF0A0A11BF0404077F0404077F0404077F00000000000000000000
      000012121FFF12121FFF00000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF00000000000000001A71B7FF1A71
      B7FF000000001A71B7FF1A71B7FF00000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000012121FFF12121FFF12121FFF0000000000000000000000000000
      000012121FFF12121FFF12121FFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012121FFF1212
      1FFF12121FFF12121FFF12121FFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000201212
      1FFF12121FFF00000000000000000000000012121FFF12121FFF12121FFF1212
      1FFF12121FFF12121FFF12121FFF12121FFF12121FFF00000000000000000000
      000012121FFF12121FFF00000020000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF00000000000000001A71B7FF1A71
      B7FF000000001A71B7FF1A71B7FF00000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000202046012121FFF12121FFF000000000000000000000000000000000000
      00000000000012121FFF12121FFF000000200000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      1FFF12121FFF12121FFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      1FFF12121FFF0000000000000000000000000404077F0404077F0404077F0A0A
      11BF12121FFF0A0A11BF0404077F0404077F0404077F00000000000000000000
      000012121FFF12121FFF00000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF00000000000000001A71B7FF1A71
      B7FF000000001A71B7FF1A71B7FF00000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000012121FFF12121FFF00000000000000000000000000000000000000000000
      0000000000000000000012121FFF12121FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012121FFF1212
      1FFF12121FFF12121FFF12121FFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      1FFF12121FFF0000000000000000000000000000000000000000000000000404
      077F12121FFF0404077F00000000000000000000000000000000000000000000
      000012121FFF12121FFF00000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF00000000000000001A71B7FF1A71
      B7FF000000001A71B7FF1A71B7FF00000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000012121FFF12121FFF00000000000000000000000000000000000000000000
      0000000000000000000012121FFF12121FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012121FFF12121FFF1212
      1FFF0000000012121FFF12121FFF12121FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      1FFF12121FFF0000000000000000000000000000000000000000000000000404
      077F12121FFF0404077F00000000000000000000000000000000000000000000
      000012121FFF0E0E18DF00000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF00000000000000001A71B7FF1A71
      B7FF000000001A71B7FF1A71B7FF00000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000012121FFF12121FFF00000000000000000000000000000000000000000000
      0000000000000000000012121FFF12121FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000012121FFF12121FFF12121FFF0000
      0000000000000000000012121FFF12121FFF12121FFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000E0E
      18DF12121FFF12121FFF00000000000000000000000000000000000000000404
      077F12121FFF0404077F00000000000000000000000000000000000000001212
      1FFF12121FFF0000000000000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF0000000000000000000000000000
      000000000000000000000000000000000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000012121FFF12121FFF00000000000000000000000000000000000000000000
      0000000000000000000012121FFF12121FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012121FFF12121FFF12121FFF000000000000
      000000000000000000000000000012121FFF12121FFF12121FFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012121FFF12121FFF0404077F000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012121FFF1212
      1FFF12121FFF0000000000000000000000000000000000000000000000000000
      000000000000000000001A71B7FF1A71B7FF0000000000000000000000000000
      000000000000000000000000000000000000000000001A71B7FF14578CDF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000101024012121FFF12121FFF000000000000000000000000000000000000
      00000000000012121FFF12121FFF010102400000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000007070C9F12121FFF12121FFF00000000000000000000
      00000000000000000000000000000000000012121FFF12121FFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000002012121FFF12121FFF0404077F0000000000000000000000000000
      000000000000000000000000000000000000000000000404077F12121FFF1212
      1FFF000000200000000000000000000000000000000000000000000000000000
      0000000000001A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71
      B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71
      B7FF000000000000000000000000000000000000000000000000000000000000
      00000000000012121FFF12121FFF12121FFF0000000000000000000000000000
      000012121FFF12121FFF12121FFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000007070C9F0000000000000000000000000000
      000000000000000000000000000000000000000000000404077F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000202046012121FFF12121FFF12121FFF00000000000000000000
      00000000000000000000000000000000002012121FFF12121FFF12121FFF0404
      077F000000000000000000000000000000000000000000000000000000000000
      0000000000001A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71
      B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71B7FF1A71
      B7FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000012121FFF12121FFF12121FFF12121FFF12121FFF1212
      1FFF12121FFF12121FFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000002012121FFF12121FFF12121FFF12121FFF1212
      1FFF12121FFF12121FFF12121FFF12121FFF12121FFF12121FFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001A71B7FF1A71
      B7FF1A71B7FF1A71B7FF1A71B7FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000002012121FFF12121FFF12121FFF1212
      1FFF010102400000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000012121FFF12121FFF12121FFF1212
      1FFF12121FFF12121FFF12121FFF12121FFF0E0E18DF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000031019600310
      1960031019600310196003101960000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000200000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000300000000100010000000000400200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object TimerStartUp: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimerStartUpTimer
    Left = 74
    Top = 592
  end
  object TimerClock: TTimer
    OnTimer = TimerClockTimer
    Left = 10
    Top = 344
  end
  object ImageListIcons_42x42: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 44
    Width = 44
    Left = 42
    Top = 592
    Bitmap = {
      494C01010200080004002C002C00FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000B00000002C00000001002000000000000079
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000D273B7F389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      000000000000389EF1FF389EF1FF389EF1FF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000002B79B8DF2B79B8DF2B79B8DF0000000000000000000000000000
      0000000000002B79B8DF2B79B8DF2B79B8DF0000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000D273B7F0D273B7F389EF1FF389EF1FF389EF1FF0D273B7F0D273B7F0D27
      3B7F0D273B7F0D273B7F0D273B7F0D273B7F0D273B7F0D273B7F0D273B7F0D27
      3B7F0D273B7F0D273B7F0D273B7F0D273B7F0D273B7F0D273B7F0D273B7F0D27
      3B7F389EF1FF389EF1FF389EF1FF0D273B7F0D273B7F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000203200002032000020320000203200002032000020320000203200002
      032007162260389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF0D273B7F00020320000203200002
      0320000203200002032000020320000203200002032000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000007162260389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389EF1FF389E
      F1FF389EF1FF389EF1FF389EF1FF389EF1FF0716226000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000B00000002C0000000100010000000000200400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
