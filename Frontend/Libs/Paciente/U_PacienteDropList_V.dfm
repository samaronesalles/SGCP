inherited frmPacienteDropList_V: TfrmPacienteDropList_V
  Caption = 'Paciente Droplist'
  ClientWidth = 488
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 16
  inherited Panel1: TPanel
    Width = 488
  end
  inherited Panel2: TPanel
    Width = 488
    inherited StringGridMain: TStringGrid
      Height = 426
      OnDblClick = StringGridMainDblClick
      ColWidths = (
        95
        286)
    end
  end
end
