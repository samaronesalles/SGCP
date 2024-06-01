object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'SGCP - Sistema gerencial de consult'#243'rios psi'
  ClientHeight = 575
  ClientWidth = 933
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object StatusBar: TStatusBar
    Left = 0
    Top = 556
    Width = 933
    Height = 19
    Panels = <>
    ExplicitTop = 547
    ExplicitWidth = 927
  end
  object Button_Teste: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Teste'
    TabOrder = 1
    Visible = False
  end
  object MainMenu: TMainMenu
    Left = 56
    Top = 48
    object Cadastros1: TMenuItem
      Caption = '&Cadastros'
      object erapeutas1: TMenuItem
        Caption = '&Profissional'
        ShortCut = 16468
        OnClick = erapeutas1Click
      end
      object Pacientes1: TMenuItem
        Caption = '&Pacientes'
        ShortCut = 16464
        OnClick = Pacientes1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = '&Sair'
        ShortCut = 32883
        OnClick = Sair1Click
      end
    end
    object Movimentaes1: TMenuItem
      Caption = '&Movimenta'#231#245'es'
      object Agendamentos1: TMenuItem
        Caption = '&Agendamentos'
        ShortCut = 16449
        OnClick = Agendamentos1Click
      end
      object Atendimentos1: TMenuItem
        Caption = 'A&tendimentos'
        ShortCut = 16468
        OnClick = Atendimentos1Click
      end
    end
    object Configuraes1: TMenuItem
      Caption = 'Configura'#231#245'es'
      Visible = False
      object emas1: TMenuItem
        Caption = 'Temas'
        Hint = 'PROBLEMAS.. NAO USAR'
        Visible = False
        object Windows1: TMenuItem
          AutoCheck = True
          Caption = 'Windows 10'
          RadioItem = True
          OnClick = Windows1Click
        end
        object WindowsDark1: TMenuItem
          AutoCheck = True
          Caption = 'Windows 10 Dark'
          RadioItem = True
          OnClick = WindowsDark1Click
        end
      end
    end
    object Janelas1: TMenuItem
      Caption = 'Janelas'
      Visible = False
    end
    object Sobre1: TMenuItem
      Caption = '&Sobre'
      object Sobre2: TMenuItem
        Caption = 'Sobre...'
      end
    end
  end
  object Timer_login: TTimer
    Interval = 1
    OnTimer = Timer_loginTimer
    Left = 8
    Top = 48
  end
end
