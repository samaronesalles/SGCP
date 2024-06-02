inherited frmProfissionalDropList_V: TfrmProfissionalDropList_V
  Caption = 'Profissional DropList'
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  ExplicitLeft = 2
  ExplicitTop = 2
  TextHeight = 16
  inherited Panel2: TPanel
    inherited StringGridMain: TStringGrid
      OnDblClick = StringGridMainDblClick
      ColWidths = (
        97
        303)
    end
  end
end
