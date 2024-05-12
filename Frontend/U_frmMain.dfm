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
  OnCreate = FormCreate
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
    Top = 73
    Width = 75
    Height = 25
    Caption = 'Testar'
    TabOrder = 1
    OnClick = Button_TesteClick
  end
  object Memo_Teste: TMemo
    Left = 8
    Top = 104
    Width = 721
    Height = 353
    TabOrder = 2
  end
  object MainMenu: TMainMenu
    Left = 56
    Top = 8
    object Cadastros1: TMenuItem
      Caption = '&Cadastros'
      object erapeutas1: TMenuItem
        Caption = '&Profissional'
        ShortCut = 16468
      end
      object Pacientes1: TMenuItem
        Caption = '&Pacientes'
        ShortCut = 16464
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
      end
      object Atendimentos1: TMenuItem
        Caption = 'A&tendimentos'
        ShortCut = 16468
      end
    end
    object Configuraes1: TMenuItem
      Caption = 'Configura'#231#245'es'
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
    Top = 8
  end
end
