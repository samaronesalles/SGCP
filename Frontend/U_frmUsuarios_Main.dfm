inherited frmUsuarios_Main: TfrmUsuarios_Main
  Caption = 'Cadastro de usu'#225'rios'
  ClientWidth = 1268
  OnShow = FormShow
  TextHeight = 20
  inherited PanelButtons: TPanel
    Width = 1268
    ExplicitTop = 671
    inherited ButtonSair: TButton
      OnClick = ButtonSairClick
    end
  end
  inherited Panel1: TPanel
    Width = 1268
    inherited StringGridMain: TStringGrid
      Height = 628
      ColCount = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect, goFixedRowDefAlign]
      ColWidths = (
        130)
    end
  end
  inherited Panel2: TPanel
    Width = 1268
  end
end
