inherited frmProfissionais_V: TfrmProfissionais_V
  Caption = 'Cadastro de profissionais'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 20
  inherited Panel1: TPanel
    inherited StringGridMain: TStringGrid
      ExplicitLeft = 2
      ExplicitTop = -3
      ExplicitWidth = 1266
      ExplicitHeight = 637
    end
  end
  inherited TimerStartUp: TTimer
    Enabled = False
  end
end
