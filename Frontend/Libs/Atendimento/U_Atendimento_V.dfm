inherited frmAtendimentos_V: TfrmAtendimentos_V
  Caption = 'Atendimentos'
  ClientHeight = 730
  ClientWidth = 1262
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitHeight = 768
  TextHeight = 16
  inherited PanelButtons: TPanel
    Top = 660
    Width = 1262
    ExplicitTop = 651
    inherited PanelLegenda: TPanel
      Width = 608
      ExplicitWidth = 608
      inherited Shape2: TShape
        Left = 203
        ExplicitLeft = 203
      end
      inherited Label2: TLabel
        Top = 35
        Width = 154
        Caption = 'Pendentes de confirma'#231#227'o'
        ExplicitTop = 35
        ExplicitWidth = 154
      end
      inherited Label3: TLabel
        Left = 224
        Top = 35
        Width = 68
        Caption = 'Cancelados'
        ExplicitLeft = 224
        ExplicitTop = 35
        ExplicitWidth = 68
      end
      object Label4: TLabel
        Left = 336
        Top = 35
        Width = 160
        Height = 16
        Caption = 'Confirmados n'#227'o realizados'
      end
      object Shape3: TShape
        Left = 315
        Top = 36
        Width = 15
        Height = 15
        Brush.Color = 16744448
        Shape = stCircle
      end
      object Label5: TLabel
        Left = 536
        Top = 35
        Width = 64
        Height = 16
        Caption = 'Realizados'
      end
      object Shape4: TShape
        Left = 515
        Top = 36
        Width = 15
        Height = 15
        Brush.Color = 4491264
        Shape = stCircle
      end
    end
    inherited Panel_btnsRight: TPanel
      inherited ButtonLimparFiltro: TButton
        OnClick = ButtonLimparFiltroClick
      end
    end
  end
  inherited Panel1: TPanel
    Width = 1262
    Height = 619
    ExplicitHeight = 610
    inherited StringGridMain: TStringGrid
      Height = 617
      ColCount = 6
      OnDblClick = StringGridMainDblClick
      ExplicitHeight = 608
      ColWidths = (
        130
        130
        128
        128
        167
        64)
    end
  end
  inherited Panel_TopButtons: TPanel
    Width = 1262
    inherited Panel_TopBtnsRight: TPanel
      inherited SpeedButton_Add: TSpeedButton
        Visible = False
      end
      inherited SpeedButton_Delete: TSpeedButton
        Hint = 'Cancelar o atendimento selecionado'
        ImageIndex = 5
      end
    end
  end
end
