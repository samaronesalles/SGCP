inherited frmPacienteDetail_V: TfrmPacienteDetail_V
  Caption = 'Cadastro de paciente'
  ClientHeight = 269
  ClientWidth = 513
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  ExplicitWidth = 525
  ExplicitHeight = 307
  TextHeight = 16
  inherited pnBotoes: TPanel
    Top = 213
    Width = 513
    ExplicitTop = 204
    ExplicitWidth = 507
    inherited ButtonProsseguir: TButton
      Left = 367
      OnClick = ButtonProsseguirClick
      ExplicitLeft = 361
    end
    inherited ButtonCancelar: TButton
      Left = 252
      ExplicitLeft = 246
    end
  end
  inherited pnDetalhe: TPanel
    Width = 513
    Height = 213
    ExplicitWidth = 507
    ExplicitHeight = 204
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 44
      Height = 16
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 16
      Top = 70
      Width = 47
      Height = 16
      Caption = 'Nome: *'
    end
    object Label3: TLabel
      Left = 432
      Top = 70
      Width = 32
      Height = 16
      Caption = 'Ativo:'
    end
    object Label4: TLabel
      Left = 16
      Top = 126
      Width = 50
      Height = 16
      Caption = 'E-mail: *'
    end
    object Label5: TLabel
      Left = 395
      Top = 126
      Width = 53
      Height = 16
      Caption = 'Celular: *'
    end
    object Label_di: TLabel
      Left = 216
      Top = 32
      Width = 10
      Height = 16
      Caption = 'di'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8388863
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object EditCodigo: TEdit
      Left = 16
      Top = 36
      Width = 71
      Height = 24
      TabStop = False
      Enabled = False
      TabOrder = 0
    end
    object EditNome: TEdit
      Left = 16
      Top = 90
      Width = 399
      Height = 24
      TabOrder = 1
    end
    object ComboBoxAtivo: TComboBox
      Left = 432
      Top = 90
      Width = 63
      Height = 24
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'SIM'
      OnKeyDown = ComboBoxAtivoKeyDown
      Items.Strings = (
        'SIM'
        'N'#195'O')
    end
    object EditEmail: TEdit
      Left = 16
      Top = 146
      Width = 359
      Height = 24
      TabOrder = 3
    end
    object MaskEditCelular: TMaskEdit
      Left = 395
      Top = 146
      Width = 102
      Height = 24
      EditMask = '!\(99\) 99999-9999;1;_'
      MaxLength = 15
      TabOrder = 4
      Text = '(  )      -    '
    end
  end
  inherited ImageList_Icons: TImageList
    Top = 225
  end
end
