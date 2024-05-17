inherited frmProfissionais_V: TfrmProfissionais_V
  Caption = 'Cadastro de profissionais'
  ClientWidth = 1262
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 16
  inherited PanelButtons: TPanel
    Width = 1262
    ExplicitTop = 642
    ExplicitWidth = 1256
    inherited ButtonSair: TButton
      Left = 1155
      ExplicitLeft = 1149
    end
    inherited PanelLegenda: TPanel
      Width = 184
      ExplicitWidth = 184
      inherited Shape2: TShape
        Left = 99
        ExplicitLeft = 99
      end
      inherited Label2: TLabel
        Width = 35
        Caption = 'Ativos'
        ExplicitWidth = 35
      end
      inherited Label3: TLabel
        Left = 120
        Width = 43
        Caption = 'Inativos'
        ExplicitLeft = 120
        ExplicitWidth = 43
      end
    end
    inherited ButtonLimparFiltro: TButton
      Left = 1030
      OnClick = ButtonLimparFiltroClick
      ExplicitLeft = 1024
    end
  end
  inherited Panel1: TPanel
    Width = 1262
    inherited StringGridMain: TStringGrid
      Height = 599
      OnDblClick = StringGridMainDblClick
    end
  end
  inherited Panel2: TPanel
    Width = 1262
    ExplicitWidth = 1256
    inherited SpeedButton_Add: TSpeedButton
      Left = 1155
      ExplicitLeft = 1161
    end
    inherited SpeedButton_Search: TSpeedButton
      Left = 1185
      ExplicitLeft = 1191
    end
    inherited SpeedButton_Delete: TSpeedButton
      Left = 1215
      ExplicitLeft = 1221
    end
  end
  inherited TimerStartUp: TTimer
    Enabled = False
  end
end
