inherited frmProfissionalDropList_V: TfrmProfissionalDropList_V
  Caption = 'Profissional DropList'
  ClientWidth = 495
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 507
  TextHeight = 16
  inherited Panel1: TPanel
    Width = 495
  end
  inherited Panel2: TPanel
    Width = 495
    inherited StringGridMain: TStringGrid
      Width = 493
      ColCount = 2
      OnDblClick = StringGridMainDblClick
      ColWidths = (
        97
        303)
    end
  end
  inherited TimerStartUp: TTimer
    OnTimer = TimerStartUpTimer
  end
end
