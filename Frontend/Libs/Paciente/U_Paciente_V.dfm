inherited frmPacientes_V: TfrmPacientes_V
  Caption = 'Cadastro de pacientes'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitWidth = 1268
  ExplicitHeight = 750
  TextHeight = 16
  inherited PanelButtons: TPanel
    inherited PanelLegenda: TPanel
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
      inherited ButtonLimparFiltro: TButton
        OnClick = ButtonLimparFiltroClick
      end
    end
  end
  inherited Panel1: TPanel
    inherited StringGridMain: TStringGrid
      Width = 1254
      Height = 599
      OnDblClick = StringGridMainDblClick
    end
  end
  inherited Panel_TopButtons: TPanel
    inherited Panel_TopBtnsRight: TPanel
      Left = 1138
    end
  end
end
