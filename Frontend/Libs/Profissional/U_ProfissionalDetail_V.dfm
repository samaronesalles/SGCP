inherited frmProfissionalDetail_V: TfrmProfissionalDetail_V
  Caption = 'Cadastro de profissional'
  ClientHeight = 409
  ClientWidth = 513
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  ExplicitWidth = 525
  ExplicitHeight = 447
  TextHeight = 16
  inherited pnBotoes: TPanel
    Top = 353
    Width = 513
    ExplicitTop = 344
    ExplicitWidth = 507
    DesignSize = (
      513
      56)
    inherited ButtonProsseguir: TButton
      Left = 386
      OnClick = ButtonProsseguirClick
      ExplicitLeft = 380
    end
    inherited ButtonCancelar: TButton
      Left = 271
      ExplicitLeft = 265
    end
  end
  inherited pnDetalhe: TPanel
    Width = 513
    Height = 353
    ExplicitWidth = 507
    ExplicitHeight = 344
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
    object Bevel1: TBevel
      Left = 8
      Top = 205
      Width = 497
      Height = 1
    end
    object Label6: TLabel
      Left = 16
      Top = 186
      Width = 119
      Height = 16
      Caption = 'Informa'#231#245'es de login'
    end
    object Label7: TLabel
      Left = 16
      Top = 222
      Width = 48
      Height = 16
      Caption = 'Usu'#225'rio:'
    end
    object Label8: TLabel
      Left = 16
      Top = 278
      Width = 41
      Height = 16
      Caption = 'Senha:'
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
      Width = 73
      Height = 24
      TabStop = False
      Enabled = False
      TabOrder = 0
    end
    object EditNome: TEdit
      Left = 16
      Top = 90
      Width = 401
      Height = 24
      TabOrder = 1
    end
    object ComboBoxAtivo: TComboBox
      Left = 432
      Top = 90
      Width = 65
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
      Width = 361
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
    object EditUsuario: TEdit
      Left = 16
      Top = 242
      Width = 217
      Height = 24
      TabOrder = 5
    end
    object EditSenha: TEdit
      Left = 16
      Top = 298
      Width = 217
      Height = 24
      PasswordChar = '*'
      TabOrder = 6
    end
  end
  inherited ImageList_Icons: TImageList
    Top = 369
  end
end
