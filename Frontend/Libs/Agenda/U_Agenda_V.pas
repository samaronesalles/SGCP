unit U_Agenda_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.WinXCalendars, Vcl.Buttons, System.DateUtils, Vcl.Grids, Vcl.Mask;

type
  TfrmAgenda_V = class(TForm)
    PanelButtons: TPanel;
    PanelLegenda: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Panel_btnsRight: TPanel;
    ButtonSair: TButton;
    ImageList_Icons: TImageList;
    TimerStartUp: TTimer;
    PanelLateralEsquerdo: TPanel;
    PanelMain: TPanel;
    CalendarView: TCalendarView;
    LabelHoraAtual: TLabel;
    PanelFiltroAgenda: TPanel;
    LabelTituloFiltro: TLabel;
    BevelTituloFiltroAgenda: TBevel;
    PanelFiltroProfissional: TPanel;
    Label4: TLabel;
    TimerClock: TTimer;
    EditFiltroProfissional: TEdit;
    PanelFiltroPaciente: TPanel;
    Label5: TLabel;
    EditFiltroPaciente: TEdit;
    PanelTop: TPanel;
    Panel_TopBtnsRight: TPanel;
    ImageListIcons_42x42: TImageList;
    SpeedButton_Delete: TSpeedButton;
    SpeedButton_Incluir: TSpeedButton;
    LabelSemanaSelecionada: TLabel;
    Bevel2: TBevel;
    Label_idProfissional: TLabel;
    Label_idPaciente: TLabel;
    Splitter: TSplitter;
    ScrollBoxMain: TScrollBox;
    PanelIntervaloHoras: TPanel;
    DrawGridEventos: TDrawGrid;
    Label_0500: TLabel;
    Label_0600: TLabel;
    Label_0800: TLabel;
    Label_0700: TLabel;
    Label_1200: TLabel;
    Label_1100: TLabel;
    Label_1000: TLabel;
    Label_0900: TLabel;
    Label_1600: TLabel;
    Label_1500: TLabel;
    Label_1400: TLabel;
    Label_1300: TLabel;
    Label_2100: TLabel;
    Label_2000: TLabel;
    Label_1900: TLabel;
    Label_1800: TLabel;
    Label_1700: TLabel;
    Label_0000: TLabel;
    Label_2300: TLabel;
    Label_2200: TLabel;
    Panel_Titulo_DOM: TPanel;
    Label_DOM: TLabel;
    ShapeDiaAtual_DOM: TShape;
    Panel_Titulo_SEG: TPanel;
    ShapeDiaAtual_SEG: TShape;
    Label_SEG: TLabel;
    Panel_Titulo_TER: TPanel;
    ShapeDiaAtual_TER: TShape;
    Label_TER: TLabel;
    Panel_Titulo_QUA: TPanel;
    ShapeDiaAtual_QUA: TShape;
    Label_QUA: TLabel;
    Panel_Titulo_QUI: TPanel;
    ShapeDiaAtual_QUI: TShape;
    Label_QUI: TLabel;
    Panel_Titulo_SEX: TPanel;
    ShapeDiaAtual_SEX: TShape;
    Label_SEX: TLabel;
    Panel_Titulo_SAB: TPanel;
    ShapeDiaAtual_SAB: TShape;
    Label_SAB: TLabel;
    Panel_HoraAnalogica_Atual: TPanel;
    PanelConteudoAgenda: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSairClick(Sender: TObject);
    procedure TimerStartUpTimer(Sender: TObject);
    procedure TimerClockTimer(Sender: TObject);
    procedure CalendarViewClick(Sender: TObject);
    procedure EditFiltroProfissionalChange(Sender: TObject);
    procedure EditFiltroPacienteChange(Sender: TObject);
    procedure EditFiltroProfissionalExit(Sender: TObject);
    procedure EditFiltroPacienteExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditFiltroProfissionalKeyPress(Sender: TObject; var Key: Char);
    procedure EditFiltroPacienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure DrawGridEventosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure DrawGridEventosDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }

    procedure PosicioneLinhaHoraAnalogica (HoraCorrente: TTime);
    procedure ApliqueVisualConteudoAgenda;
    function  RetornaPosicaoInicioHorario (Horas, Minutos: Longint): Longint;
  public
    { Public declarations }
  end;

var
  frmAgenda_V: TfrmAgenda_V;

implementation

uses Uteis, U_frmMain, U_ProfissionalDropList_V, U_PacienteDropList_V;

{$R *.dfm}

procedure TfrmAgenda_V.ButtonSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAgenda_V.CalendarViewClick(Sender: TObject);
var
  Seg, Ter, Qua, Qui, Sex, Sab, Dom                  : TDate;

begin

  LabelSemanaSelecionada.Caption:= 'Compromissos da semana: ';

  RetornaDiasDaSemana (CalendarView.Date, Seg, Ter, Qua, Qui, Sex, Sab, Dom);

  LabelSemanaSelecionada.Caption:= LabelSemanaSelecionada.Caption + FormatDateTime('dd/mm', Dom) + ' a ' + FormatDateTime('dd/mm', Sab);

  Label_DOM.Caption:= 'DOM' + #13 + FormatDateTime('dd', Dom);
  ShapeDiaAtual_DOM.Visible:= Date() = Dom;
  Label_DOM.Hint:= Iff(ShapeDiaAtual_DOM.Visible, 'Data atual', FormatDateTime('dd/mm', Dom));

  Label_SEG.Caption:= 'SEG' + #13 + FormatDateTime('dd', Seg);
  ShapeDiaAtual_SEG.Visible:= Date() = Seg;
  Label_SEG.Hint:= Iff(ShapeDiaAtual_SEG.Visible, 'Data atual', FormatDateTime('dd/mm', Seg));

  Label_TER.Caption:= 'TER' + #13 + FormatDateTime('dd', Ter);
  ShapeDiaAtual_TER.Visible:= Date() = Ter;
  Label_TER.Hint:= Iff(ShapeDiaAtual_TER.Visible, 'Data atual', FormatDateTime('dd/mm', Ter));

  Label_QUA.Caption:= 'QUA' + #13 + FormatDateTime('dd', Qua);
  ShapeDiaAtual_QUA.Visible:= Date() = Qua;
  Label_QUA.Hint:= Iff(ShapeDiaAtual_QUA.Visible, 'Data atual', FormatDateTime('dd/mm', Qua));

  Label_QUI.Caption:= 'QUI' + #13 + FormatDateTime('dd', Qui);
  ShapeDiaAtual_QUI.Visible:= Date() = Qui;
  Label_QUI.Hint:= Iff(ShapeDiaAtual_QUI.Visible, 'Data atual', FormatDateTime('dd/mm', Qui));

  Label_SEX.Caption:= 'SEX' + #13 + FormatDateTime('dd', Sex);
  ShapeDiaAtual_SEX.Visible:= Date() = Sex;
  Label_SEX.Hint:= Iff(ShapeDiaAtual_SEX.Visible, 'Data atual', FormatDateTime('dd/mm', Sex));

  Label_SAB.Caption:= 'SAB' + #13 + FormatDateTime('dd', Sab);
  ShapeDiaAtual_SAB.Visible:= Date() = Sab;
  Label_SAB.Hint:= Iff(ShapeDiaAtual_SAB.Visible, 'Data atual', FormatDateTime('dd/mm', Sab));

end;

procedure TfrmAgenda_V.DrawGridEventosDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  DrawGridEventos.Canvas.Brush.Color:= clWhite;
end;

procedure TfrmAgenda_V.DrawGridEventosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect:= FALSE;
end;

procedure TfrmAgenda_V.EditFiltroPacienteChange(Sender: TObject);
begin
  if EditFiltroPaciente.Focused then
    Label_idPaciente.Caption:= '0';
end;

procedure TfrmAgenda_V.EditFiltroPacienteExit(Sender: TObject);
var
  id                                        : Longint;
  JSON_Selecionado, nome                    : String;

begin
  inherited;

  if Str2Num(Label_idPaciente.Caption) > 0 then
    Exit;

  if Trim(EditFiltroPaciente.Text) = '' then
    Exit;

  JSON_Selecionado:= frmPacienteDropList_V.Execute();

  id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'id'));
  nome:= Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'nome');

  if id <= 0 then
    Exit;

  EditFiltroPaciente.Text:= nome;
  Label_idPaciente.Caption:= IntToStr(id);

end;

procedure TfrmAgenda_V.EditFiltroPacienteKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    EditFiltroProfissional.SetFocus();
end;

procedure TfrmAgenda_V.EditFiltroProfissionalChange(Sender: TObject);
begin
  if EditFiltroProfissional.Focused then
    Label_idProfissional.Caption:= '0';
end;

procedure TfrmAgenda_V.EditFiltroProfissionalExit(Sender: TObject);
var
  id                                        : Longint;
  JSON_Selecionado, nome                    : String;

begin
  inherited;

  if Str2Num(Label_idProfissional.Caption) > 0 then
    Exit;

  if Trim(EditFiltroProfissional.Text) = '' then
    Exit;

  JSON_Selecionado:= frmProfissionalDropList_V.Execute();

  id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'id'));
  nome:= Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'nome');

  if id <= 0 then
    Exit;

  EditFiltroProfissional.Text:= nome;
  Label_idProfissional.Caption:= IntToStr(id);

end;

procedure TfrmAgenda_V.EditFiltroProfissionalKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then
    EditFiltroPaciente.SetFocus();

end;

procedure TfrmAgenda_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfrmAgenda_V.FormCreate(Sender: TObject);
begin
  CalendarView.Date:= Date();
end;

procedure TfrmAgenda_V.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  I                                         : Integer;

begin

  Handled := PtInRect(ScrollBoxMain.ClientRect, ScrollBoxMain.ScreenToClient(MousePos));

  if Handled then begin
    for I := 1 to Mouse.WheelScrollLines do begin
      try
        if WheelDelta > 0 then
          ScrollBoxMain.Perform(WM_VSCROLL, SB_LINEUP, 0)
        else
          ScrollBoxMain.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
      finally
        ScrollBoxMain.Perform(WM_VSCROLL, SB_ENDSCROLL, 0);
      end;
    end;
  end;

end;

procedure TfrmAgenda_V.ApliqueVisualConteudoAgenda;
const
  RowHeight                 = 60;

var
  Row                                       : Longint;
  CellRect                                  : TRect;

begin

  DrawGridEventos.RowHeights[0]:= 75;
  for Row:= 1 to DrawGridEventos.RowCount - 1 do begin // Inicia da 1, para pular o título;
    DrawGridEventos.RowHeights[Row]:= RowHeight;

    CellRect:= DrawGridEventos.CellRect(0, Row);

    case Row of
       1: Label_0500.Top:= CellRect.Top - (Label_0500.Height Div 2);
       2: Label_0600.Top:= CellRect.Top - (Label_0500.Height Div 2);
       3: Label_0700.Top:= CellRect.Top - (Label_0500.Height Div 2);
       4: Label_0800.Top:= CellRect.Top - (Label_0500.Height Div 2);
       5: Label_0900.Top:= CellRect.Top - (Label_0500.Height Div 2);
       6: Label_1000.Top:= CellRect.Top - (Label_0500.Height Div 2);
       7: Label_1100.Top:= CellRect.Top - (Label_0500.Height Div 2);
       8: Label_1200.Top:= CellRect.Top - (Label_0500.Height Div 2);
       9: Label_1300.Top:= CellRect.Top - (Label_0500.Height Div 2);
      10: Label_1400.Top:= CellRect.Top - (Label_0500.Height Div 2);
      11: Label_1500.Top:= CellRect.Top - (Label_0500.Height Div 2);
      12: Label_1600.Top:= CellRect.Top - (Label_0500.Height Div 2);
      13: Label_1700.Top:= CellRect.Top - (Label_0500.Height Div 2);
      14: Label_1800.Top:= CellRect.Top - (Label_0500.Height Div 2);
      15: Label_1900.Top:= CellRect.Top - (Label_0500.Height Div 2);
      16: Label_2000.Top:= CellRect.Top - (Label_0500.Height Div 2);
      17: Label_2100.Top:= CellRect.Top - (Label_0500.Height Div 2);
      18: Label_2200.Top:= CellRect.Top - (Label_0500.Height Div 2);
      19: Label_2300.Top:= CellRect.Top - (Label_0500.Height Div 2);
    end;
  end;

  Label_0000.Top:= Label_2300.Top + RowHeight;

  Panel_HoraAnalogica_Atual.Left:= DrawGridEventos.Left;
  Panel_HoraAnalogica_Atual.Width:= DrawGridEventos.Width;

end;

procedure TfrmAgenda_V.FormShow(Sender: TObject);
begin

  ApliqueVisualConteudoAgenda();

  CalendarView.OnClick(Self);

  Label_idProfissional.Caption:= IntToStr(frmMain.ProfissionalLogado.Id);
  EditFiltroProfissional.Text:= frmMain.ProfissionalLogado.Nome;

  Label_idPaciente.Caption:= '0';
  EditFiltroPaciente.Text:= '';

end;

procedure TfrmAgenda_V.TimerClockTimer(Sender: TObject);
var
  Hora                             : TTime;

begin

  Hora:= Now();

  LabelHoraAtual.Caption:= 'Hora atual: ' + FormatDateTime('hh:nn:ss', Hora);

  PosicioneLinhaHoraAnalogica(Hora);

end;

procedure TfrmAgenda_V.TimerStartUpTimer(Sender: TObject);
begin

  TimerStartUp.Enabled:= FALSE;

  EditFiltroProfissional.SetFocus();

end;

function TfrmAgenda_V.RetornaPosicaoInicioHorario (Horas, Minutos: Longint): Longint;
var
  Row, heightCell, pixelInicioHora, Resultado              : Longint;
  CellRect                                                 : TRect;

begin

  Result:= -1;

  if ((Horas >= 24) AND (Horas <= 4)) then
    Exit;

  Row:= Horas - 4;           // A partir da hora "05:00", incia a row 0. Porém, queremos o início da célula seguinte.
  heightCell:= DrawGridEventos.RowHeights[Row];

  CellRect:= DrawGridEventos.CellRect(0, Row);
  pixelInicioHora:= CellRect.Top + DrawGridEventos.Top - 2;

  Resultado:= pixelInicioHora + Minutos;

  Result:= Resultado;

end;

procedure TfrmAgenda_V.PosicioneLinhaHoraAnalogica (HoraCorrente: TTime);
var
  Top, Hora, Minuto                              : Longint;

begin

  Top:= -1;

  Hora:= HourOf(HoraCorrente);
  Minuto:= MinuteOf(HoraCorrente);

  Panel_HoraAnalogica_Atual.Visible:= FALSE;

  if ((Hora > StrToTime('23:59:00')) AND (Hora < StrToTime('05:00:00'))) then
    Exit;

  Top:= RetornaPosicaoInicioHorario(Hora, Minuto);

  if Top < 0 then
    Exit;

  Panel_HoraAnalogica_Atual.Top:= Top;
  Panel_HoraAnalogica_Atual.Visible:= TRUE;

end;

end.

