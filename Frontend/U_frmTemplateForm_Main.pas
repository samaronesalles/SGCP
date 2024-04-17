unit U_frmTemplateForm_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids;

type
  TfrmTemplateForm_Main = class(TForm)
    PanelButtons: TPanel;
    ButtonSair: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    StringGridMain: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTemplateForm_Main: TfrmTemplateForm_Main;

implementation

{$R *.dfm}


procedure TfrmTemplateForm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfrmTemplateForm_Main.StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  CorFonteLinhaPar               = clBlack;
  CorLinhaPar                    = $00EAEAEA;

  CorFonteLinhaImpar             = clBlack;
  CorLinhaImpar                  = clWhite;

var
  yCalc                                                                 : integer;
  Texto                                                                 : String;
  lCanvas                                                               : TCanvas;

begin

  { Salva em variáveis locais por questão de clareza do código }
  texto:= TStringGrid(Sender).Cells[ACol, ARow];
  lCanvas:= TStringGrid(Sender).Canvas;

  if gdFixed in State then begin
    { Cor do fonte e de fundo para linhas e colunas fixas }
    lCanvas.Font.Color:= clWhite;
    lCanvas.Font.Style:= [TFontStyle.fsBold];

    lCanvas.Brush.Color:= TStringGrid(Sender).FixedColor;
  end else begin
    if gdSelected in State then begin
      { Cor do fonte e de fundo para linhas e colunas selecionadas }
      lCanvas.Font.Color:= clWhite;
      lCanvas.Brush.Color:= clHighlight;
    end else begin
//      { Cor do fonte e de fundo para linhas e colunas com dados }
//      if ACol mod 2 = 0 then
//        lCanvas.Font.Color:= clBlue
//      else
//        lCanvas.Font.Color:= clRed;

      if ARow mod 2 = 0 then begin
        lCanvas.Font.Color:= CorFonteLinhaImpar;
        lCanvas.Brush.Color:= CorLinhaPar;
      end else begin
        lCanvas.Font.Color:= CorFonteLinhaPar;
        lCanvas.Brush.Color:= CorLinhaImpar;
      end;

    end;
  end;

  { Preenche com a cor de fundo }
  lCanvas.FillRect(Rect);

  { Calcula posição para centralizar o texto na vertical }
  yCalc:= lCanvas.TextHeight (texto);
  yCalc:= Rect.Top + (Rect.Bottom - Rect.Top - yCalc) div 2;

  lCanvas.TextRect (Rect, Rect.Left + 3, yCalc, texto);

end;

end.
