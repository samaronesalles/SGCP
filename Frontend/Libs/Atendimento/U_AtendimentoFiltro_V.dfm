inherited frmAtendimentoFiltro_V: TfrmAtendimentoFiltro_V
  ClientHeight = 218
  ClientWidth = 539
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 551
  ExplicitHeight = 256
  TextHeight = 16
  inherited Panel1: TPanel
    Top = 155
    Width = 539
    inherited Panel3: TPanel
      Left = 289
      inherited ButtonFiltrar: TButton
        OnClick = ButtonFiltrarClick
      end
    end
  end
  inherited Panel2: TPanel
    Width = 539
    Height = 155
    ExplicitLeft = -1
    ExplicitTop = -5
    ExplicitWidth = 640
    ExplicitHeight = 248
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
    object ComboBox_FiltroProfissional: TComboBox
      Left = 120
      Top = 57
      Width = 400
      Height = 24
      Style = csDropDownList
      TabOrder = 1
    end
    object ComboBox_FiltroPaciente: TComboBox
      Left = 120
      Top = 99
      Width = 400
      Height = 24
      Style = csDropDownList
      TabOrder = 2
    end
  end
end
