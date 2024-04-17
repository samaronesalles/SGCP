object frmTemplateForm_Main: TfrmTemplateForm_Main
  Left = 0
  Top = 0
  Caption = 'frmTemplateForm_Main'
  ClientHeight = 730
  ClientWidth = 1268
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 780
  DefaultMonitor = dmMainForm
  ParentFont = True
  FormStyle = fsMDIChild
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  TextHeight = 20
  object PanelButtons: TPanel
    Left = 0
    Top = 680
    Width = 1268
    Height = 50
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 671
    ExplicitWidth = 1262
    DesignSize = (
      1268
      50)
    object ButtonSair: TButton
      Left = 1158
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Sair'
      TabOrder = 0
      ExplicitLeft = 1152
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 1268
    Height = 639
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 1262
    ExplicitHeight = 630
    object StringGridMain: TStringGrid
      Left = 1
      Top = 1
      Width = 1266
      Height = 637
      Align = alClient
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = True
      FixedColor = clGray
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
      ParentCtl3D = False
      TabOrder = 0
      OnDrawCell = StringGridMainDrawCell
      ExplicitWidth = 1260
      ExplicitHeight = 628
      ColWidths = (
        130
        130
        128
        128
        167)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1268
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 1262
  end
end
