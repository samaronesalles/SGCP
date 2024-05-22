object frmConexaoAPI_V: TfrmConexaoAPI_V
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Comunica'#231#227'o com API'
  ClientHeight = 148
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Label_mensagem: TLabel
    Left = 0
    Top = 0
    Width = 509
    Height = 109
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
    Top = 109
    Width = 509
    Height = 39
    Align = alBottom
    Style = pbstMarquee
    TabOrder = 0
  end
  object TimerStartUp: TTimer
    Enabled = False
    OnTimer = TimerStartUpTimer
    Left = 16
    Top = 64
  end
end
