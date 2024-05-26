inherited frmProfissionalDropList_V: TfrmProfissionalDropList_V
  Caption = 'Profissional DropList'
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 16
  inherited Panel1: TPanel
    ExplicitTop = 399
    ExplicitWidth = 489
  end
  inherited Panel2: TPanel
    ExplicitWidth = 489
    ExplicitHeight = 399
    inherited StringGridMain: TStringGrid
      OnDblClick = StringGridMainDblClick
      ExplicitWidth = 487
      ExplicitHeight = 397
      ColWidths = (
        97
        303)
    end
  end
end
