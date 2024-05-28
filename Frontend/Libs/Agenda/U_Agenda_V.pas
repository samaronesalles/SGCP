unit U_Agenda_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.WinXCalendars, Vcl.Buttons, System.DateUtils, Vcl.Grids;

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
  private
    { Private declarations }
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

  LabelSemanaSelecionada.Caption:= 'Compomissos da semana: ';

  RetornaDiasDaSemana (CalendarView.Date, Seg, Ter, Qua, Qui, Sex, Sab, Dom);

  LabelSemanaSelecionada.Caption:= LabelSemanaSelecionada.Caption + FormatDateTime('dd/mm', Dom) + ' a ' + FormatDateTime('dd/mm', Sab);

  Label_DOM.Caption:= 'DOM' + #13 + FormatDateTime('dd', Dom);
  ShapeDiaAtual_DOM.Visible:= Date() = Dom;

  Label_SEG.Caption:= 'SEG' + #13 + FormatDateTime('dd', Seg);
  ShapeDiaAtual_SEG.Visible:= Date() = Seg;

  Label_TER.Caption:= 'TER' + #13 + FormatDateTime('dd', Ter);
  ShapeDiaAtual_TER.Visible:= Date() = Ter;

  Label_QUA.Caption:= 'QUA' + #13 + FormatDateTime('dd', Qua);
  ShapeDiaAtual_QUA.Visible:= Date() = Qua;

  Label_QUI.Caption:= 'QUI' + #13 + FormatDateTime('dd', Qui);
  ShapeDiaAtual_QUI.Visible:= Date() = Qui;

  Label_SEX.Caption:= 'SEX' + #13 + FormatDateTime('dd', Sex);
  ShapeDiaAtual_SEX.Visible:= Date() = Sex;

  Label_SAB.Caption:= 'SAB' + #13 + FormatDateTime('dd', Sab);
  ShapeDiaAtual_SAB.Visible:= Date() = Sab;

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

procedure TfrmAgenda_V.FormShow(Sender: TObject);
begin

  CalendarView.OnClick(Self);

  Label_idProfissional.Caption:= IntToStr(frmMain.ProfissionalLogado.Id);
  EditFiltroProfissional.Text:= frmMain.ProfissionalLogado.Nome;

  Label_idPaciente.Caption:= '0';
  EditFiltroPaciente.Text:= '';

end;

procedure TfrmAgenda_V.TimerClockTimer(Sender: TObject);
begin
  LabelHoraAtual.Caption:= 'Hora atual: ' + FormatDateTime('hh:nn:ss', Now());
end;

procedure TfrmAgenda_V.TimerStartUpTimer(Sender: TObject);
begin

  TimerStartUp.Enabled:= FALSE;

  EditFiltroProfissional.SetFocus();

end;

end.
