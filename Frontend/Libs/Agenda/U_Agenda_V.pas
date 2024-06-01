unit U_Agenda_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.WinXCalendars, Vcl.Buttons, System.DateUtils, System.Generics.Collections, Vcl.Grids,
  Vcl.Mask, U_Agenda_M;

type
  TfrmAgenda_V = class(TForm)
    PanelButtons: TPanel;
    PanelLegenda: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Shape_legenda_NaoConfirmados: TShape;
    Shape_legenda_Confirmados: TShape;
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
    ButtonFiltrar: TButton;
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
    procedure FormCreate(Sender: TObject);
    procedure DrawGridEventosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure DrawGridEventosDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton_IncluirClick(Sender: TObject);
    procedure ButtonFiltrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

    FGLB_ListaAgendas                     : TAgendas_List_M;
    FGLB_ListaFiltro                      : TList<Integer>;

    FGLB_Dom                              : TDate;
    FGLB_Seg                              : TDate;
    FGLB_Ter                              : TDate;
    FGLB_Qua                              : TDate;
    FGLB_Qui                              : TDate;
    FGLB_Sex                              : TDate;
    FGLB_Sab                              : TDate;

    procedure RetorneTodosAgendamentos;
    procedure ApliqueFiltro;
    procedure Refresh_StringGrid;

    function  EventoJaExistenteNaTela (const idEventoProcurado: Longint; var diEvento: String): Boolean;
    procedure LimpeAgendamentosNaTela;
    procedure AdicioneAgendamentoNaTela (Agenda: TAgenda_M);

    procedure PosicioneLinhaHoraAnalogica (HoraCorrente: TTime);
    procedure ApliqueVisualConteudoAgenda;
    function  RetornaPosicaoInicioHorario (Horas, Minutos: Longint): Longint;
    function  RetornaColData (Data: TDate): Longint;
    function  RetornaPosicaoLeftData (const Data: TDate; var Width: Longint): Longint;

    procedure EventoDblClick (Sender: TObject);
  public
    { Public declarations }
  end;

const
  COL_DOM                    = 0;
  COL_SEG                    = 1;
  COL_TER                    = 2;
  COL_QUA                    = 3;
  COL_QUI                    = 4;
  COL_SEX                    = 5;
  COL_SAB                    = 6;

var
  frmAgenda_V: TfrmAgenda_V;

implementation

uses Uteis, U_frmMain, U_Evento_V, U_ProfissionalDropList_V, U_PacienteDropList_V, U_AgendaDetail_V;

{$R *.dfm}

procedure TfrmAgenda_V.ButtonFiltrarClick(Sender: TObject);
begin
  Self.ApliqueFiltro();
  Self.Refresh_StringGrid();
end;

procedure TfrmAgenda_V.ButtonSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAgenda_V.CalendarViewClick(Sender: TObject);
var
  BkpPeriodo                                     : String;

begin

  LabelSemanaSelecionada.Caption:= 'Compromissos da semana: ';

  BkpPeriodo:= FormatDateTime('dd/mm/yyyy', Self.FGLB_Dom) + '|' + FormatDateTime('dd/mm/yyyy', Self.FGLB_Sab);

  Uteis.RetornaDiasDaSemana (CalendarView.Date, Self.FGLB_Dom, Self.FGLB_Seg, Self.FGLB_Ter, Self.FGLB_Qua, Self.FGLB_Qui, Self.FGLB_Sex, Self.FGLB_Sab);

  // Não trocou a semana, não precisa fazer nada.
  if BkpPeriodo = FormatDateTime('dd/mm/yyyy', Self.FGLB_Dom) + '|' + FormatDateTime('dd/mm/yyyy', Self.FGLB_Sab) then
    Exit;

  LabelSemanaSelecionada.Caption:= LabelSemanaSelecionada.Caption + FormatDateTime('dd/mm', Self.FGLB_Dom) + ' a ' + FormatDateTime('dd/mm', Self.FGLB_Sab);

  Label_DOM.Caption:= 'DOM' + #13 + FormatDateTime('dd', Self.FGLB_Dom);
  ShapeDiaAtual_DOM.Visible:= Date() = Self.FGLB_Dom;
  Label_DOM.Hint:= Iff(ShapeDiaAtual_DOM.Visible, 'Data atual', FormatDateTime('dd/mm', Self.FGLB_Dom));

  Label_SEG.Caption:= 'SEG' + #13 + FormatDateTime('dd', Self.FGLB_Seg);
  ShapeDiaAtual_SEG.Visible:= Date() = Self.FGLB_Seg;
  Label_SEG.Hint:= Iff(ShapeDiaAtual_SEG.Visible, 'Data atual', FormatDateTime('dd/mm', Self.FGLB_Seg));

  Label_TER.Caption:= 'TER' + #13 + FormatDateTime('dd', Self.FGLB_Ter);
  ShapeDiaAtual_TER.Visible:= Date() = Self.FGLB_Ter;
  Label_TER.Hint:= Iff(ShapeDiaAtual_TER.Visible, 'Data atual', FormatDateTime('dd/mm', Self.FGLB_Ter));

  Label_QUA.Caption:= 'QUA' + #13 + FormatDateTime('dd', Self.FGLB_Qua);
  ShapeDiaAtual_QUA.Visible:= Date() = Self.FGLB_Qua;
  Label_QUA.Hint:= Iff(ShapeDiaAtual_QUA.Visible, 'Data atual', FormatDateTime('dd/mm', Self.FGLB_Qua));

  Label_QUI.Caption:= 'QUI' + #13 + FormatDateTime('dd', Self.FGLB_Qui);
  ShapeDiaAtual_QUI.Visible:= Date() = Self.FGLB_Qui;
  Label_QUI.Hint:= Iff(ShapeDiaAtual_QUI.Visible, 'Data atual', FormatDateTime('dd/mm', Self.FGLB_Qui));

  Label_SEX.Caption:= 'SEX' + #13 + FormatDateTime('dd', Self.FGLB_Sex);
  ShapeDiaAtual_SEX.Visible:= Date() = Self.FGLB_Sex;
  Label_SEX.Hint:= Iff(ShapeDiaAtual_SEX.Visible, 'Data atual', FormatDateTime('dd/mm', Self.FGLB_Sex));

  Label_SAB.Caption:= 'SAB' + #13 + FormatDateTime('dd', Self.FGLB_Sab);
  ShapeDiaAtual_SAB.Visible:= Date() = Self.FGLB_Sab;
  Label_SAB.Hint:= Iff(ShapeDiaAtual_SAB.Visible, 'Data atual', FormatDateTime('dd/mm', Self.FGLB_Sab));

  Self.ApliqueFiltro();
  Self.Refresh_StringGrid();

end;

procedure TfrmAgenda_V.ApliqueFiltro;
begin
  Self.FGLB_ListaFiltro.Free();
  Self.FGLB_ListaFiltro:= Self.FGLB_ListaAgendas.FiltraLista(Str2Num(Label_idProfissional.Caption), Str2Num(Label_idPaciente.Caption), Self.FGLB_Dom, Self.FGLB_Sab);
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

  Try
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

  Finally
    if Str2Num(Label_idProfissional.Caption) <= 0 then begin
      Label_idProfissional.Caption:= IntToStr(frmMain.ProfissionalLogado.Id);
      EditFiltroProfissional.Text:= frmMain.ProfissionalLogado.Nome;
    end;
  End;

end;

procedure TfrmAgenda_V.FormActivate(Sender: TObject);
begin
  Self.WindowState:= TWindowState.wsMaximized;
end;

procedure TfrmAgenda_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfrmAgenda_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Self.FGLB_ListaAgendas.Free();
  Self.FGLB_ListaFiltro.Free();
end;

procedure TfrmAgenda_V.FormCreate(Sender: TObject);
begin
  Self.FGLB_ListaAgendas:= Nil;
  Self.FGLB_ListaFiltro:= Nil;

  Shape_legenda_NaoConfirmados.Brush.Color:= COR_AGENDA_NAO_CONFIRMADA;
  Shape_legenda_Confirmados.Brush.Color:= COR_AGENDA_CONFIRMADA;

  CalendarView.Date:= Date();
end;

procedure TfrmAgenda_V.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_F5 then begin
    Key:= 0;

    Self.RetorneTodosAgendamentos();
    Self.Refresh_StringGrid();

    Exit;
  end;

  if Key = VK_INSERT then begin
    Key:= 0;

    Self.SpeedButton_Incluir.OnClick(Self);

    Exit;
  end;

end;

procedure TfrmAgenda_V.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then begin
    SelectNext(ActiveControl as TWinControl, TRUE, TRUE);
    Key:= #0;
  end;

end;

procedure TfrmAgenda_V.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  I                                         : Integer;

begin

  Handled := PtInRect(ScrollBoxMain.ClientRect, ScrollBoxMain.ScreenToClient(MousePos));

  if Handled then begin
    for I:= 1 to Mouse.WheelScrollLines do begin
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

    CellRect:= DrawGridEventos.CellRect(COL_DOM, Row);

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

  TimerStartUp.Enabled:= TRUE;

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

  Self.FGLB_ListaAgendas:= TAgendas_List_M.Create();
  Self.FGLB_ListaFiltro:= TList<Integer>.Create();

  EditFiltroProfissional.SetFocus();

  Self.FGLB_ListaAgendas.Clear();
  Self.FGLB_ListaAgendas.RetornoLista(0, 0, StrToDateTime(DateToStr(Self.FGLB_Dom) + ' 00:00'), StrToDateTime(DateToStr(Self.FGLB_Sab) + ' 23:59'));

  Self.FGLB_ListaFiltro.Free();
  Self.FGLB_ListaFiltro:= Self.FGLB_ListaAgendas.FiltraLista(0, 0, Self.FGLB_Dom, Self.FGLB_Sab);

  Self.Refresh_StringGrid();

end;

procedure TfrmAgenda_V.Refresh_StringGrid;
var
  C                                            : integer;
  FiltrouAlgo                                  : Boolean;
  Agenda                                       : TAgenda_M;

begin

  try
    LimpeAgendamentosNaTela();

    FiltrouAlgo:= FALSE;

    If Self.FGLB_ListaAgendas = Nil Then
      Exit;

    If Self.FGLB_ListaAgendas.Count = 0 Then
      Exit;

    for C:= 0 to Self.FGLB_ListaAgendas.Count - 1 do begin
      Agenda:= TAgenda_M(Self.FGLB_ListaAgendas[C]);

      if Agenda = Nil then
        Continue;

      if NOT (Agenda is TAgenda_M) then
        Continue;

      if NOT Self.FGLB_ListaFiltro.Contains(Agenda.Id) then begin
        FiltrouAlgo:= TRUE;
        Continue;
      end;

      AdicioneAgendamentoNaTela(Agenda);
    end;

  finally

  end;

end;

function TfrmAgenda_V.EventoJaExistenteNaTela (const idEventoProcurado: Longint; var diEvento: String): Boolean;
var
  i                          : Integer;
  child                      : TControl;

begin

  diEvento:= '';
  Result:= FALSE;

  // Use um loop reverso para evitar problemas ao remover componentes durante a iteração
  for i:= PanelConteudoAgenda.ControlCount - 1 downto 0 do begin
    child:= PanelConteudoAgenda.Controls[i];

    if ((child is TEvento_V) AND (TEvento_V(child).id = idEventoProcurado)) then begin
      diEvento:= TEvento_V(child).di;

      Result:= TRUE;
      Break;
    end;
  end;

end;

procedure TfrmAgenda_V.LimpeAgendamentosNaTela;
var
  i                          : Integer;
  child                      : TControl;

begin

  // Use um loop reverso para evitar problemas ao remover componentes durante a iteração
  for i:= PanelConteudoAgenda.ControlCount - 1 downto 0 do begin
    child:= PanelConteudoAgenda.Controls[i];

    if (child is TEvento_V) and (Pos('pnEvento_', child.Name) = 1) then
      child.Free;
  end;

end;

procedure TfrmAgenda_V.AdicioneAgendamentoNaTela (Agenda: TAgenda_M);
var
  Evento_V                                : TEvento_V;
  Width, MinutosAgendados                 : Longint;
  diEventoJaExistente                     : String;
  RectEvento                              : TRect;
  Cor                                     : TColor;

begin

  Evento_V:= Nil;

  // Se o evento já existir na tela, e não teve alteração, não o recriamos.
  if EventoJaExistenteNaTela(Agenda.Id, diEventoJaExistente) then begin
    if Agenda.Di = diEventoJaExistente then
      Exit;
  end;

  Try
    MinutosAgendados:= MinutesBetween(Agenda.Evento_fim, Agenda.Evento_inicio);

    RectEvento.Top:= RetornaPosicaoInicioHorario(HourOf(Agenda.Evento_inicio), MinuteOf(Agenda.Evento_inicio)) + 2;
    RectEvento.Left:= RetornaPosicaoLeftData(DateOf(Agenda.Evento_inicio), Width);
    RectEvento.width:= Width;
    RectEvento.Height:= MinutosAgendados;

    Cor:= Iff(Agenda.Evento_confirmado, COR_AGENDA_CONFIRMADA, COR_AGENDA_NAO_CONFIRMADA);

    Evento_V:= TEvento_V.ToObject(PanelConteudoAgenda, Cor, RectEvento, Agenda);

    if Evento_V = Nil then
      Exit;

    Evento_V.LabelNome.OnDblClick:= EventoDblClick;
    Evento_V.LabelHora.OnDblClick:= EventoDblClick;

    Evento_V.Visible:= TRUE;
    Evento_V.BringToFront();

  Except
    Evento_V.Free;
  End;

end;

function TfrmAgenda_V.RetornaColData (Data: TDate): Longint;
begin

  Case DayOfTheWeek(Data) of
       DaySunday: Result:= COL_DOM;
       DayMonday: Result:= COL_SEG;
      DayTuesday: Result:= COL_TER;
    DayWednesday: Result:= COL_QUA;
     DayThursday: Result:= COL_QUI;
       DayFriday: Result:= COL_SEX;
     DaySaturday: Result:= COL_SAB;
  End;

end;

function TfrmAgenda_V.RetornaPosicaoLeftData (const Data: TDate; var Width: Longint): Longint;
begin

  try
    Result:= 0;
    Width:= 0;

    Case DayOfTheWeek(Data) of
         DaySunday: begin
                      Result:= Panel_Titulo_DOM.Left;
                      Width:= Panel_Titulo_DOM.Width;
                    end;
         DayMonday: begin
                      Result:= Panel_Titulo_SEG.Left;
                      Width:= Panel_Titulo_SEG.Width;
                    end;
        DayTuesday: begin
                      Result:= Panel_Titulo_TER.Left;
                      Width:= Panel_Titulo_TER.Width;
                    end;
      DayWednesday: begin
                      Result:= Panel_Titulo_QUA.Left;
                      Width:= Panel_Titulo_QUA.Width;
                    end;
       DayThursday: begin
                      Result:= Panel_Titulo_QUI.Left;
                      Width:= Panel_Titulo_QUI.Width;
                    end;
         DayFriday: begin
                      Result:= Panel_Titulo_SEX.Left;
                      Width:= Panel_Titulo_SEX.Width;
                    end;
       DaySaturday: begin
                      Result:= Panel_Titulo_SAB.Left;
                      Width:= Panel_Titulo_SAB.Width;
                    end;
    End;

  except
    Result:= 0;
  end;

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

  CellRect:= DrawGridEventos.CellRect(COL_DOM, Row);
  pixelInicioHora:= CellRect.Top + DrawGridEventos.Top - 2;

  Resultado:= pixelInicioHora + Minutos;

  Result:= Resultado;

end;

procedure TfrmAgenda_V.RetorneTodosAgendamentos;
begin

  Self.FGLB_ListaAgendas.Clear();

  Self.FGLB_ListaAgendas.RetornoLista(Str2Num(Label_idProfissional.Caption),
                                      Str2Num(Label_idPaciente.Caption),
                                      StrToDateTime(DateToStr(Self.FGLB_Dom) + ' 00:00'),
                                      StrToDateTime(DateToStr(Self.FGLB_Sab) + ' 23:59')
                                     );

  Self.ApliqueFiltro();

  Self.Refresh_StringGrid();

end;

procedure TfrmAgenda_V.SpeedButton_IncluirClick(Sender: TObject);
var
  NovaAgenda                        : TAgenda_M;

begin

  NovaAgenda:= Nil;

  Try
    NovaAgenda:= frmAgendaDetail_V.Execute_Novo();

    if NovaAgenda = Nil then
      raise Exception.Create('');

    if NovaAgenda.Id <= 0 then
      raise Exception.Create('');

    Self.FGLB_ListaAgendas.Add(NovaAgenda);

    ButtonFiltrar.OnClick(Self);

  Except
    NovaAgenda.Free;
  End;

end;

procedure TfrmAgenda_V.PosicioneLinhaHoraAnalogica (HoraCorrente: TTime);
var
  Top, Hora, Minuto                       : Longint;

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

procedure TfrmAgenda_V.EventoDblClick(Sender: TObject);
var
  idAgenda                         : Longint;
  Agenda                           : TAgenda_M;

begin

  idAgenda:= TEvento_V(TLabel(Sender).Parent).id;

  if idAgenda <= 0 then
    Exit;

  Agenda:= Self.FGLB_ListaAgendas.RetornaAgenda(idAgenda);

  if Agenda = Nil then
    Exit;

  try
    frmAgendaDetail_V.Execute_Editar(Agenda);
  finally
    Self.RetorneTodosAgendamentos();
    Self.Refresh_StringGrid();
  end;

end;

end.

