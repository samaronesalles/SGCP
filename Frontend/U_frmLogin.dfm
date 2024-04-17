object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Login'
  ClientHeight = 207
  ClientWidth = 326
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    326
    207)
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 17
    Width = 53
    Height = 20
    Caption = 'Usu'#225'rio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 81
    Width = 43
    Height = 20
    Caption = 'Senha:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Button_Sair: TButton
    Left = 16
    Top = 159
    Width = 100
    Height = 30
    Anchors = [akLeft, akBottom]
    Caption = '&Sair'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TabStop = False
    OnClick = Button_SairClick
  end
  object Button_Entrar: TButton
    Left = 210
    Top = 159
    Width = 100
    Height = 30
    Anchors = [akRight, akBottom]
    Caption = '&Entrar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TabStop = False
    OnClick = Button_EntrarClick
  end
  object Edit_Usuario: TEdit
    Left = 16
    Top = 43
    Width = 294
    Height = 28
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'admin'
  end
  object Edit_Senha: TEdit
    Left = 16
    Top = 107
    Width = 294
    Height = 28
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    Text = '123'
  end
end
