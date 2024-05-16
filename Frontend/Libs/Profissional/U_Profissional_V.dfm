inherited frmProfissionais_V: TfrmProfissionais_V
  Caption = 'Cadastro de profissionais'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 16
  inherited PanelButtons: TPanel
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
  inherited Panel2: TPanel
    inherited SpeedButton_Add: TSpeedButton
      OnClick = SpeedButton_AddClick
    end
  end
  inherited TimerStartUp: TTimer
    Enabled = False
  end
end
