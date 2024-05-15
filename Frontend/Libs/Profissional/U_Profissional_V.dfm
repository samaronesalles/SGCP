inherited frmProfissionais_V: TfrmProfissionais_V
  Caption = 'Cadastro de profissionais'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitWidth = 1274
  ExplicitHeight = 759
  TextHeight = 17
  inherited Panel1: TPanel
    inherited StringGridMain: TStringGrid
      Width = 1260
      Height = 608
      ExplicitHeight = 617
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
