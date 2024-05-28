unit U_Agenda_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.WinXCalendars, Vcl.Buttons, Vcl.Grids;

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
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
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
  Seg, Dom                     : TDate;

begin

  LabelSemanaSelecionada.Caption:= 'Compomissos da semana: ';

  Uteis.RetornaIntervaloDaSemana(CalendarView.Date, Seg, Dom);

  LabelSemanaSelecionada.Caption:= LabelSemanaSelecionada.Caption + FormatDateTime('dd/mm', Seg) + ' a ' + FormatDateTime('dd/mm', Dom);

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
