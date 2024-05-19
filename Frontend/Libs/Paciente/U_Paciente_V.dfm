inherited frmPacientes_V: TfrmPacientes_V
  Caption = 'Cadastro de pacientes'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
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
      inherited ButtonLimparFiltro: TButton
        OnClick = ButtonLimparFiltroClick
      end
    end
  end
  inherited Panel1: TPanel
    inherited StringGridMain: TStringGrid
      OnDblClick = StringGridMainDblClick
    end
  end
end
