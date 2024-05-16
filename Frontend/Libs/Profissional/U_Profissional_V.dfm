inherited frmProfissionais_V: TfrmProfissionais_V
  Caption = 'Cadastro de profissionais'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 16
  inherited PanelButtons: TPanel
    inherited ButtonSair: TButton
      Left = 1142
      ExplicitLeft = 1136
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
  end
  inherited Panel1: TPanel
    inherited StringGridMain: TStringGrid
      OnDblClick = StringGridMainDblClick
    end
  end
  inherited Panel2: TPanel
    inherited SpeedButton_Add: TSpeedButton
      Left = 1147
      OnClick = SpeedButton_AddClick
      ExplicitLeft = 1153
    end
    inherited SpeedButton_Search: TSpeedButton
      Left = 1177
      ExplicitLeft = 1183
    end
    inherited SpeedButton_Delete: TSpeedButton
      Left = 1207
      ExplicitLeft = 1213
    end
  end
  inherited TimerStartUp: TTimer
    Enabled = False
  end
end
