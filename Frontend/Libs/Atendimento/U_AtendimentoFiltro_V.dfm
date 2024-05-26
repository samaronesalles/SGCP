inherited frmAtendimentoFiltro_V: TfrmAtendimentoFiltro_V
  ClientHeight = 265
  ClientWidth = 539
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 551
  ExplicitHeight = 303
  TextHeight = 16
  inherited Panel1: TPanel
    Top = 202
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
    Height = 202
    ExplicitTop = -5
    ExplicitWidth = 539
    ExplicitHeight = 223
    object Label1: TLabel
      Left = 16
      Top = 22
      Width = 42
      Height = 16
      Caption = 'Status:'
    end
    object Label2: TLabel
      Left = 16
      Top = 104
      Width = 71
      Height = 16
      Caption = 'Profissional:'
    end
    object Label3: TLabel
      Left = 16
      Top = 146
      Width = 55
      Height = 16
      Caption = 'Paciente:'
    end
    object Label_idProfissional: TLabel
      Left = 445
      Top = 85
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
      Top = 127
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
    object Label4: TLabel
      Left = 16
      Top = 64
      Width = 102
      Height = 16
      Caption = 'Agendados entre:'
    end
    object Label5: TLabel
      Left = 263
      Top = 64
      Width = 20
      Height = 16
      Caption = 'At'#233
    end
    object ComboBox_FiltroStatus: TComboBox
      Left = 134
      Top = 19
      Width = 207
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
      Left = 134
      Top = 101
      Width = 389
      Height = 24
      TabOrder = 5
      OnChange = Edit_FiltroProfissionalChange
      OnExit = Edit_FiltroProfissionalExit
    end
    object Edit_FiltroPaciente: TEdit
      Left = 134
      Top = 143
      Width = 389
      Height = 24
      TabOrder = 6
      OnChange = Edit_FiltroPacienteChange
      OnExit = Edit_FiltroPacienteExit
    end
    object MaskEdit_Data_InicioDe: TMaskEdit
      Left = 134
      Top = 61
      Width = 75
      Height = 24
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnExit = MaskEdit_Data_InicioDeExit
    end
    object MaskEdit_Data_InicioAte: TMaskEdit
      Left = 289
      Top = 61
      Width = 75
      Height = 24
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      OnExit = MaskEdit_Data_InicioAteExit
    end
    object MaskEdit_Hora_InicioDe: TMaskEdit
      Left = 215
      Top = 61
      Width = 42
      Height = 24
      EditMask = '!99:99;1;_'
      MaxLength = 5
      TabOrder = 2
      Text = '  :  '
      OnExit = MaskEdit_Hora_InicioDeExit
    end
    object MaskEdit_Hora_InicioAte: TMaskEdit
      Left = 370
      Top = 61
      Width = 42
      Height = 24
      EditMask = '!99:99;1;_'
      MaxLength = 5
      TabOrder = 4
      Text = '  :  '
      OnExit = MaskEdit_Hora_InicioAteExit
    end
  end
end
