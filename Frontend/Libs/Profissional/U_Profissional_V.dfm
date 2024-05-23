inherited frmProfissionais_V: TfrmProfissionais_V
  Caption = 'Cadastro de profissionais'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitWidth = 1268
  ExplicitHeight = 750
  TextHeight = 16
  inherited PanelButtons: TPanel
    ExplicitTop = 633
    ExplicitWidth = 1250
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
    inherited Panel_btnsRight: TPanel
      Left = 1025
      ExplicitLeft = 1019
      inherited ButtonLimparFiltro: TButton
        OnClick = ButtonLimparFiltroClick
      end
    end
  end
  inherited Panel1: TPanel
    ExplicitWidth = 1250
    ExplicitHeight = 592
    inherited StringGridMain: TStringGrid
      Width = 1254
      Height = 599
      OnDblClick = StringGridMainDblClick
      ExplicitWidth = 1248
      ExplicitHeight = 590
    end
  end
  inherited Panel_TopButtons: TPanel
    ExplicitWidth = 1250
    inherited Panel_TopBtnsRight: TPanel
      Left = 1138
      ExplicitLeft = 1132
    end
  end
  inherited TimerStartUp: TTimer
    Enabled = False
  end
end
