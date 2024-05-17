unit U_frmTemplateForm_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.Buttons, System.ImageList, Vcl.ImgList;

type
  TfrmTemplateForm_Main = class(TForm)
    PanelButtons: TPanel;
    ButtonSair: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    StringGridMain: TStringGrid;
    ImageList_Icons: TImageList;
    SpeedButton_Add: TSpeedButton;
    SpeedButton_Search: TSpeedButton;
    SpeedButton_Delete: TSpeedButton;
    TimerStartUp: TTimer;
    PanelLegenda: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    ButtonLimparFiltro: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure TimerStartUpTimer(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);

    function  GetCorCell(Grid: TStringGrid; ACol, ARow: Integer): TColor;
    procedure SetCorRowgrid(Grid: TStringGrid; CorFont, CorLinha: TColor; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SpeedButton_DeleteClick(Sender: TObject);
    procedure StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton_SearchClick(Sender: TObject);
    procedure SpeedButton_AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTemplateForm_Main: TfrmTemplateForm_Main;

implementation

uses Uteis;

{$R *.dfm}


procedure TfrmTemplateForm_Main.ButtonSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTemplateForm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfrmTemplateForm_Main.FormCreate(Sender: TObject);
begin

  SpeedButton_Delete.Left:= 1220;
  SpeedButton_Search.Left:= 1190;
  SpeedButton_Add.Left:= 1160;

  ButtonSair.Left:= 1160;
  ButtonLimparFiltro.Left:= 1040;

end;

function TfrmTemplateForm_Main.GetCorCell(Grid: TStringGrid; ACol, ARow: Integer): TColor;
var
  R                                            : TRect;
  Cor                                          : TColor;
begin
  R:= Grid.CellRect(ACol, ARow);
  Result:= Grid.Canvas.Pixels[R.Left + 2, R.Top + 2];
end;

procedure TfrmTemplateForm_Main.SetCorRowgrid(Grid: TStringGrid; CorFont, CorLinha: TColor; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  yCalc                                                                 : integer;
  Texto                                                                 : String;
  lCanvas                                                               : TCanvas;

begin

  { Salva em variáveis locais por questão de clareza do código }
  texto:= Grid.Cells[ACol, ARow];
  lCanvas:= Grid.Canvas;

  if gdFixed in State then begin
    { Cor do fonte e de fundo para linhas e colunas fixas }
    lCanvas.Font.Color:= clWhite;
    lCanvas.Font.Style:= [TFontStyle.fsBold];

    lCanvas.Brush.Color:= Grid.FixedColor;
  end else begin
    if gdSelected in State then begin
      { Cor do fonte e de fundo para linhas e colunas selecionadas }
      lCanvas.Font.Color:= clWhite;
      lCanvas.Brush.Color:= clHighlight;
    end else begin
      { Cor do fonte e de fundo para linhas e colunas com dados }
      lCanvas.Font.Color:= CorFont;
      lCanvas.Brush.Color:= CorLinha;
    end;
  end;

  { Preenche com a cor de fundo }
  lCanvas.FillRect(Rect);

  { Calcula posição para centralizar o texto na vertical }
  yCalc:= lCanvas.TextHeight (texto);
  yCalc:= Rect.Top + (Rect.Bottom - Rect.Top - yCalc) div 2;

  lCanvas.TextRect (Rect, Rect.Left + 3, yCalc, texto);

end;

procedure TfrmTemplateForm_Main.SpeedButton_AddClick(Sender: TObject);
begin
  Application.ProcessMessages();
end;

procedure TfrmTemplateForm_Main.SpeedButton_DeleteClick(Sender: TObject);
begin
  Application.ProcessMessages();
end;

procedure TfrmTemplateForm_Main.SpeedButton_SearchClick(Sender: TObject);
begin
  Application.ProcessMessages();
end;

procedure TfrmTemplateForm_Main.StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  CorFonteLinhaPar               = clBlack;
  CorLinhaPar                    = $00EAEAEA;

  CorFonteLinhaImpar             = clBlack;
  CorLinhaImpar                  = clWhite;

var
  CorFont, CorLinha              : TColor;

begin

  if ARow mod 2 = 0 then begin
    CorFont:= CorFonteLinhaImpar;
    CorLinha:= CorLinhaPar;
  end else begin
    CorFont:= CorFonteLinhaPar;
    CorLinha:= CorLinhaImpar;
  end;

  SetCorRowgrid(TStringGrid(Sender), CorFont, CorLinha, ACol, ARow, Rect, State);

end;

procedure TfrmTemplateForm_Main.StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_INSERT then begin
    SpeedButton_Add.OnClick(Self);
    Exit;
  end;


  if Key = VK_F3 then begin
    SpeedButton_Search.OnClick(Self);
    Exit;
  end;

  if ssCtrl in Shift then begin
    if UpperKEY(Chr(Key)) = 'F' then begin
      SpeedButton_Search.OnClick(Self);
      Exit;
    end;
  end;

  if Key = VK_DELETE then begin
    SpeedButton_Delete.OnClick(Self);
    Exit;
  end;

end;

procedure TfrmTemplateForm_Main.TimerStartUpTimer(Sender: TObject);
begin

  TimerStartUp.Enabled:= FALSE;

end;

end.
