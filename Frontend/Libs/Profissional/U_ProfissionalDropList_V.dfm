inherited frmProfissionalDropList_V: TfrmProfissionalDropList_V
  Caption = 'Profissional DropList'
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  ExplicitWidth = 494
  ExplicitHeight = 491
  TextHeight = 16
  inherited Panel1: TPanel
    ExplicitTop = 419
    ExplicitWidth = 476
  end
  inherited Panel2: TPanel
    ExplicitWidth = 476
    ExplicitHeight = 419
    inherited StringGridMain: TStringGrid
      Width = 480
      Height = 426
      OnDblClick = StringGridMainDblClick
      ExplicitWidth = 480
      ExplicitHeight = 435
      ColWidths = (
        97
        303)
    end
  end
end
