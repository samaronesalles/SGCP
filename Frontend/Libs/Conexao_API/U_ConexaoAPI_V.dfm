object frmConexaoAPI_V: TfrmConexaoAPI_V
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Comunica'#231#227'o com API'
  ClientHeight = 157
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label_mensagem: TLabel
    Left = 0
    Top = 0
    Width = 515
    Height = 118
    Align = alClient
    Alignment = taCenter
    Caption = 'Salvando informa'#231#245'es. Aguarde!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitWidth = 463
    ExplicitHeight = 38
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 118
    Width = 515
    Height = 39
    Align = alBottom
    Style = pbstMarquee
    TabOrder = 0
  end
  object TimerStartUp: TTimer
    OnTimer = TimerStartUpTimer
    Left = 16
    Top = 64
  end
end
