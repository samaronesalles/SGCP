inherited frmAtendimentoFiltro_V: TfrmAtendimentoFiltro_V
  ClientHeight = 218
  ClientWidth = 539
  ExplicitWidth = 551
  ExplicitHeight = 256
  TextHeight = 16
  inherited Panel1: TPanel
    Top = 155
    Width = 539
    ExplicitTop = 146
    ExplicitWidth = 533
    inherited Panel3: TPanel
      Left = 289
      ExplicitLeft = 283
      inherited ButtonFiltrar: TButton
        OnClick = ButtonFiltrarClick
      end
    end
  end
  inherited Panel2: TPanel
    Width = 539
    Height = 155
    ExplicitWidth = 533
    ExplicitHeight = 146
    object Label1: TLabel
      Left = 16
      Top = 22
      Width = 42
      Height = 16
      Caption = 'Status:'
    end
    object Label2: TLabel
      Left = 16
      Top = 60
      Width = 71
      Height = 16
      Caption = 'Profissional:'
    end
    object Label3: TLabel
      Left = 16
      Top = 102
      Width = 55
      Height = 16
      Caption = 'Paciente:'
    end
    object Label_idProfissional: TLabel
      Left = 445
      Top = 41
      Width = 77
      Height = 16
      Caption = 'idProfissional'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label_idPaciente: TLabel
      Left = 461
      Top = 83
      Width = 61
      Height = 16
      Caption = 'idPaciente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object ComboBox_FiltroStatus: TComboBox
      Left = 120
      Top = 19
      Width = 220
      Height = 24
      Style = csDropDownList
      TabOrder = 0
      Items.Strings = (
        'Todos'
        'Pendentes de confirma'#231#227'o'
        'Cancelados'
        'Confirmados e n'#227'o realizados'
        'Realizados')
    end
    object Edit_FiltroProfissional: TEdit
      Left = 120
      Top = 57
      Width = 402
      Height = 24
      TabOrder = 1
      OnChange = Edit_FiltroProfissionalChange
      OnExit = Edit_FiltroProfissionalExit
    end
    object Edit_FiltroPaciente: TEdit
      Left = 120
      Top = 99
      Width = 402
      Height = 24
      TabOrder = 2
      OnChange = Edit_FiltroPacienteChange
    end
  end
end
