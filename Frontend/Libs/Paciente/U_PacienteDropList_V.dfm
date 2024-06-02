inherited frmPacienteDropList_V: TfrmPacienteDropList_V
  Caption = 'Paciente Droplist'
  ClientHeight = 462
  ClientWidth = 488
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 16
  inherited Panel1: TPanel
    Top = 437
    Width = 488
    ExplicitTop = 428
    ExplicitWidth = 482
  end
  inherited Panel2: TPanel
    Width = 488
    Height = 437
    ExplicitWidth = 482
    ExplicitHeight = 428
    inherited StringGridMain: TStringGrid
      OnDblClick = StringGridMainDblClick
      ExplicitWidth = 480
      ExplicitHeight = 426
      ColWidths = (
        95
        286)
    end
  end
  inherited TimerStartUp: TTimer
    Interval = 50
  end
end
