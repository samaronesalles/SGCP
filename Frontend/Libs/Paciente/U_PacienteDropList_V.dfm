inherited frmPacienteDropList_V: TfrmPacienteDropList_V
  Caption = 'Paciente Droplist'
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 16
  inherited Panel2: TPanel
    inherited StringGridMain: TStringGrid
      OnDblClick = StringGridMainDblClick
      ColWidths = (
        95
        286)
    end
  end
end
