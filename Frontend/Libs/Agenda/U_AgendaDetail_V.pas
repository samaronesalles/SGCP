unit U_AgendaDetail_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Detail, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, U_Agenda_M;

type
  TfrmAgendaDetail_V = class(TfrmTemplateForm_Detail)
    Label_idPaciente: TLabel;
    Label_idProfissional: TLabel;
    Edit_ProfissionalAgendado: TEdit;
    Edit_PacienteAgendado: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit_DiaAgendado: TMaskEdit;
    MaskEdit_Hora_InicioAte: TMaskEdit;
    Label3: TLabel;
    MaskEdit_Hora_InicioDe: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox_Confirmado: TCheckBox;
    Label6: TLabel;
    Memo_Observacoes: TMemo;
    ButtonSair: TButton;
    Label_di: TLabel;
    Label_id: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonProsseguirClick(Sender: TObject);
    procedure MaskEdit_DiaAgendadoExit(Sender: TObject);
    procedure MaskEdit_Hora_InicioDeExit(Sender: TObject);
    procedure MaskEdit_Hora_InicioAteExit(Sender: TObject);
    procedure Edit_ProfissionalAgendadoChange(Sender: TObject);
    procedure Edit_ProfissionalAgendadoExit(Sender: TObject);
    procedure Edit_PacienteAgendadoChange(Sender: TObject);
    procedure Edit_PacienteAgendadoExit(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    FGLB_Agenda_M                             : TAgenda_M;
    FJson_BkpAgendaEditada                    : String;

    function ValidaCamposObrigatorios: Boolean;
  public
    { Public declarations }

    property GLB_Agenda_M                     : TAgenda_M Read FGLB_Agenda_M Write FGLB_Agenda_M;

    function Execute_Novo: TAgenda_M;
    function Execute_Editar(VAR Agenda: TAgenda_M): Boolean;
  end;

var
  frmAgendaDetail_V: TfrmAgendaDetail_V;

implementation

uses U_frmMain, Uteis, U_Profissional_M, U_Paciente_M,
     U_ProfissionalDropList_V, U_PacienteDropList_V;

{$R *.dfm}

{ TfrmAgendaDetail_V }

procedure TfrmAgendaDetail_V.ButtonCancelarClick(Sender: TObject);
begin

  if NOT ButtonProsseguir.Enabled then
    Exit;

  Try
    Try
      ButtonProsseguir.Enabled:= FALSE;
      ButtonSair.Enabled:= FALSE;
      ButtonCancelar.Enabled:= FALSE;

      if Uteis.SayQuestion('Cancelar agendamento', 'Deseja realmente cancelar este agendamento?', TMsgDlgType.mtConfirmation, mbYesNo, mrNo, 0) <> mrYes then
        Exit;

      if NOT Self.FGLB_Agenda_M.CancelarAtendamento() Then
        Exit;

      Self.Label_di.Caption:= Self.FGLB_Agenda_M.Di;

      frmMain.BufferStr:= Self.FGLB_Agenda_M.ToJSON();

      ModalResult:= mrOk;
    Except
      ModalResult:= mrAbort;
    End;
  Finally
    ButtonProsseguir.Enabled:= TRUE;
    ButtonSair.Enabled:= TRUE;
    ButtonCancelar.Enabled:= TRUE;
  End;

end;

procedure TfrmAgendaDetail_V.ButtonProsseguirClick(Sender: TObject);
var
  Novo                             : Boolean;

begin

  if NOT ButtonProsseguir.Enabled then
    Exit;

  Try
    Try
      ButtonProsseguir.Enabled:= FALSE;
      ButtonSair.Enabled:= FALSE;
      ButtonCancelar.Enabled:= FALSE;

      Novo:= Str2Num(Self.Label_id.Caption) = 0;

      if NOT Self.ValidaCamposObrigatorios() then
        Exit;

      if Self.FGLB_Agenda_M = Nil then
        Self.FGLB_Agenda_M:= TAgenda_M.Create();

      Self.FGLB_Agenda_M.id:= Str2Num(Self.Label_id.Caption);
      Self.FGLB_Agenda_M.Di:= Trim(Self.Label_di.caption);

      Self.FGLB_Agenda_M.Profissional:= TProfissional_M.Create();
      Self.FGLB_Agenda_M.Profissional.Id:= Uteis.Str2Num(Self.Label_idProfissional.Caption);

      Self.FGLB_Agenda_M.Paciente:= TPaciente_M.Create();
      Self.FGLB_Agenda_M.Paciente.Id:= Uteis.Str2Num(Self.Label_idPaciente.Caption);

      Self.FGLB_Agenda_M.Descricao:= 'Consulta ' + Uteis.RetornaPrimeiroNome(Self.Edit_PacienteAgendado.Text) + ' ' + Self.MaskEdit_DiaAgendado.Text + ' ' + Self.MaskEdit_Hora_InicioDe.Text;
      Self.FGLB_Agenda_M.Observacao:= Self.Memo_Observacoes.Text;
      Self.FGLB_Agenda_M.Evento_inicio:= StrToDateTime(Self.MaskEdit_DiaAgendado.Text + ' ' + Self.MaskEdit_Hora_InicioDe.Text);
      Self.FGLB_Agenda_M.Evento_fim:= StrToDateTime(Self.MaskEdit_DiaAgendado.Text + ' ' + Self.MaskEdit_Hora_InicioAte.Text);
      Self.FGLB_Agenda_M.Evento_confirmado:= Self.CheckBox_Confirmado.Checked;

      If ((NOT Novo) AND (Self.FJson_BkpAgendaEditada = Self.FGLB_Agenda_M.ToJSON())) Then
        ModalResult:= mrCancel;

      if NOT Self.FGLB_Agenda_M.Save() Then
        Exit;

      Self.Label_di.Caption:= Self.FGLB_Agenda_M.Di;
      Self.Label_idProfissional.Caption:= IntToStr(Self.FGLB_Agenda_M.Profissional.Id);
      Self.Edit_ProfissionalAgendado.Text:= Self.FGLB_Agenda_M.Profissional.Nome;
      Self.Label_idPaciente.Caption:= IntToStr(Self.FGLB_Agenda_M.Paciente.Id);
      Self.Edit_PacienteAgendado.Text:= Self.FGLB_Agenda_M.Paciente.Nome;
      SetValorToMaskEdit(frmAgendaDetail_V.MaskEdit_DiaAgendado, FormatDateTime('ddmmyyyy', Self.FGLB_Agenda_M.Evento_inicio));
      SetValorToMaskEdit(frmAgendaDetail_V.MaskEdit_Hora_InicioDe, FormatDateTime('hhmm', Self.FGLB_Agenda_M.Evento_inicio));
      SetValorToMaskEdit(frmAgendaDetail_V.MaskEdit_Hora_InicioAte, FormatDateTime('hhmm', Self.FGLB_Agenda_M.Evento_fim));
      Self.CheckBox_Confirmado.Checked:= Self.FGLB_Agenda_M.Evento_confirmado;
      Self.Memo_Observacoes.Text:= Self.FGLB_Agenda_M.Observacao;

      frmMain.BufferStr:= Self.FGLB_Agenda_M.ToJSON();

      ModalResult:= mrOk;
    Except
      ModalResult:= mrAbort;
    End;
  Finally
    ButtonProsseguir.Enabled:= TRUE;
    ButtonSair.Enabled:= TRUE;
    ButtonCancelar.Enabled:= TRUE;
  End;

end;

procedure TfrmAgendaDetail_V.ButtonSairClick(Sender: TObject);
begin
  inherited;

  if NOT ButtonSair.Enabled then
    Exit;

  ModalResult:= mrCancel;

end;

procedure TfrmAgendaDetail_V.Edit_PacienteAgendadoChange(Sender: TObject);
begin
  if Edit_PacienteAgendado.Focused then
    Label_idPaciente.Caption:= '0';
end;

procedure TfrmAgendaDetail_V.Edit_PacienteAgendadoExit(Sender: TObject);
var
  id                                        : Longint;
  JSON_Selecionado, nome                    : String;

begin
  inherited;

  if Str2Num(Label_idPaciente.Caption) > 0 then
    Exit;

  if Edit_PacienteAgendado.Text = '' then
    Exit;

  JSON_Selecionado:= frmPacienteDropList_V.Execute();

  id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'id'));
  nome:= Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'nome');

  if id <= 0 then
    Exit;

  Edit_PacienteAgendado.Text:= nome;
  Label_idPaciente.Caption:= IntToStr(id);

end;

procedure TfrmAgendaDetail_V.Edit_ProfissionalAgendadoChange(Sender: TObject);
begin
  if Edit_ProfissionalAgendado.Focused then
    Label_idProfissional.Caption:= '0';
end;

procedure TfrmAgendaDetail_V.Edit_ProfissionalAgendadoExit(Sender: TObject);
var
  id                                        : Longint;
  JSON_Selecionado, nome                    : String;

begin
  inherited;

  if Str2Num(Label_idProfissional.Caption) > 0 then
    Exit;

  if Edit_ProfissionalAgendado.Text = '' then
    Exit;

  JSON_Selecionado:= frmProfissionalDropList_V.Execute();

  id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'id'));
  nome:= Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'nome');

  if id <= 0 then
    Exit;

  Edit_ProfissionalAgendado.Text:= nome;
  Label_idProfissional.Caption:= IntToStr(id);

end;

function TfrmAgendaDetail_V.Execute_Editar(var Agenda: TAgenda_M): Boolean;
var
  ResultadoModal                            : TModalResult;

begin

  Try
    Try
      Result:= FALSE;

      if Agenda = Nil then
        Exit;

      if Agenda.Id <= 0 then
        Exit;

      if frmAgendaDetail_V = Nil then
        frmAgendaDetail_V:= TfrmAgendaDetail_V.Create(Self);

      frmAgendaDetail_V.GLB_Agenda_M:= Agenda;

      frmAgendaDetail_V.ButtonCancelar.Visible:= TRUE;

      frmAgendaDetail_V.Label_id.Caption:= IntToStr(Agenda.Id);
      frmAgendaDetail_V.Label_di.Caption:= Agenda.Di;

      frmAgendaDetail_V.Label_idProfissional.caption:= IntToStr(Agenda.Profissional.Id);
      frmAgendaDetail_V.Edit_ProfissionalAgendado.Text:= Agenda.Profissional.Nome;

      frmAgendaDetail_V.Label_idPaciente.caption:= IntToStr(Agenda.Paciente.Id);
      frmAgendaDetail_V.Edit_PacienteAgendado.Text:= Agenda.Paciente.Nome;

      SetValorToMaskEdit(frmAgendaDetail_V.MaskEdit_DiaAgendado, FormatDateTime('ddmmyyyy', Agenda.Evento_inicio));
      SetValorToMaskEdit(frmAgendaDetail_V.MaskEdit_Hora_InicioDe, FormatDateTime('hhmm', Agenda.Evento_inicio));
      SetValorToMaskEdit(frmAgendaDetail_V.MaskEdit_Hora_InicioAte, FormatDateTime('hhmm', Agenda.Evento_fim));
      frmAgendaDetail_V.Memo_Observacoes.Text:= Agenda.Observacao;

      frmAgendaDetail_V.CheckBox_Confirmado.Checked:= Agenda.Evento_confirmado;

      frmAgendaDetail_V.FJson_BkpAgendaEditada:= Agenda.ToJSON();

      ResultadoModal:= frmAgendaDetail_V.ShowModal;

      if ResultadoModal = mrCancel then begin
        Result:= TRUE;
        Exit;
      end;

      if ResultadoModal <> mrOk then
        Exit;

      Agenda.Free();
      Agenda:= TAgenda_M.ToObject(frmMain.BufferStr);

      Result:= TRUE;
    Except
      Agenda.Free();
      Result:= FALSE;
    End;
  Finally
    frmAgendaDetail_V.Free();
  End;

end;

function TfrmAgendaDetail_V.Execute_Novo: TAgenda_M;
var
  BkpBufferStr                              : String;
  ResultadoModal                            : TModalResult;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;

    Try
      Result:= Nil;
      frmMain.BufferStr:= '';

      if frmAgendaDetail_V = Nil then
        frmAgendaDetail_V:= TfrmAgendaDetail_V.Create(Self);

      frmAgendaDetail_V.ButtonCancelar.Visible:= FALSE;

      frmAgendaDetail_V.Label_id.Caption:= '0';
      frmAgendaDetail_V.Label_di.Caption:= '';

      frmAgendaDetail_V.Label_idProfissional.caption:= IntToStr(frmMain.ProfissionalLogado.Id);
      frmAgendaDetail_V.Edit_ProfissionalAgendado.Text:= frmMain.ProfissionalLogado.Nome;

      ResultadoModal:= frmAgendaDetail_V.ShowModal;

      if ResultadoModal <> mrOk then
        Exit;

      Result:= TAgenda_M.ToObject(frmMain.BufferStr);
    Except
      Result.Free();
      Result:= Nil;
    End;
  Finally
    frmMain.BufferStr:= BkpBufferStr;
    frmAgendaDetail_V.Free();
  End;

end;

procedure TfrmAgendaDetail_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  frmAgendaDetail_V:= Nil;
  Action:= caFree;

end;

procedure TfrmAgendaDetail_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  if NOT ButtonProsseguir.Enabled then begin
    CanClose:= FALSE;
    exit;
  end;

  inherited;

end;

procedure TfrmAgendaDetail_V.FormCreate(Sender: TObject);
begin

  inherited;

  Self.FGLB_Agenda_M:= Nil;

  Self.Label_id.Caption:= '';
  Self.Label_idProfissional.Caption:= '';
  Self.Label_idPaciente.Caption:= '';
  Self.Label_di.Caption:= '';

  Self.FJson_BkpAgendaEditada:= '';

  if Uteis.MicroDesenv_Temporario() then begin
    Self.Label_id.Visible:= TRUE;
    Self.Label_idProfissional.Visible:= TRUE;
    Self.Label_idPaciente.Visible:= TRUE;
    Self.Label_di.Visible:= TRUE;
  end;

end;

procedure TfrmAgendaDetail_V.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then begin
    SelectNext(ActiveControl as TWinControl, TRUE, TRUE);
    Key:= #0;
  end;

  if Key = #27 then begin
    Key:= #0;
    ButtonSair.OnClick(Self);
  end;

end;

procedure TfrmAgendaDetail_V.FormShow(Sender: TObject);
begin
  inherited;

  if Self.Edit_ProfissionalAgendado.Text = '' then
    Self.Edit_ProfissionalAgendado.SetFocus()
  Else
    Self.Edit_PacienteAgendado.SetFocus();

end;

procedure TfrmAgendaDetail_V.MaskEdit_DiaAgendadoExit(Sender: TObject);
begin

  if Uteis.CheckDate(MaskEdit_DiaAgendado.Text) then
     Exit;

  MaskEdit_DiaAgendado.Text:= Uteis.FormatDate(MaskEdit_DiaAgendado.Text);

  if NOT Uteis.CheckDate(MaskEdit_DiaAgendado.Text) then
    MaskEdit_DiaAgendado.Text:= FormatDateTime('dd/mm/yyyy', Date());

end;

procedure TfrmAgendaDetail_V.MaskEdit_Hora_InicioAteExit(Sender: TObject);
begin
  inherited;

  if NOT Uteis.CheckTime(MaskEdit_Hora_InicioAte.Text) then
    MaskEdit_Hora_InicioAte.Text:= FormatDateTime('hh:nn', Now());

end;

procedure TfrmAgendaDetail_V.MaskEdit_Hora_InicioDeExit(Sender: TObject);
begin
  inherited;

  if NOT Uteis.CheckTime(MaskEdit_Hora_InicioDe.Text) then
    MaskEdit_Hora_InicioDe.Text:= FormatDateTime('hh:nn', Now());

end;

function TfrmAgendaDetail_V.ValidaCamposObrigatorios: Boolean;
begin

  Result:= FALSE;

  if Uteis.Str2Num(Self.Label_idProfissional.Caption) = 0 then begin
    Uteis.SayInfo('Campo "Profissional" é obrigatório! Verifique.');

    Self.Edit_ProfissionalAgendado.SetFocus();
    exit;
  end;

  if Uteis.Str2Num(Self.Label_idPaciente.Caption) = 0 then begin
    Uteis.SayInfo('Campo "Paciente" é obrigatório! Verifique.');

    Self.Edit_PacienteAgendado.SetFocus();
    exit;
  end;

  if NOT CheckDate(Self.MaskEdit_DiaAgendado.Text) then begin
    Uteis.SayInfo('Campo "Dia" é obrigatório! Verifique.');

    Self.MaskEdit_DiaAgendado.SetFocus();
    exit;
  end;

  if StrToDate(Self.MaskEdit_DiaAgendado.Text) < Date() then begin
    Uteis.SayInfo('A data do agendamento não pode ser inferior à data atual! Verifique.');

    Self.MaskEdit_DiaAgendado.SetFocus();
    exit;
  end;

  if NOT CheckTime(Self.MaskEdit_Hora_InicioDe.Text) then begin
    Uteis.SayInfo('Campo "Hora início" é obrigatório! Verifique.');

    Self.MaskEdit_Hora_InicioDe.SetFocus();
    exit;
  end;

  if NOT CheckTime(Self.MaskEdit_Hora_InicioAte.Text) then begin
    Uteis.SayInfo('Campo "Hora final" é obrigatório! Verifique.');

    Self.MaskEdit_Hora_InicioAte.SetFocus();
    exit;
  end;

  if StrToDateTime(Self.MaskEdit_DiaAgendado.Text + ' ' + Self.MaskEdit_Hora_InicioAte.Text) < StrToDateTime(Self.MaskEdit_DiaAgendado.Text + ' ' + Self.MaskEdit_Hora_InicioDe.Text) then begin
    Uteis.SayInfo('O horário final prefisto para o atendimento não pode ser inferior ao horário de início! Verifique.');

    Self.MaskEdit_Hora_InicioAte.SetFocus();
    exit;
  end;

  if (StrToTime(Self.MaskEdit_Hora_InicioAte.Text) < StrToTime('05:00')) OR (StrToTime(Self.MaskEdit_Hora_InicioAte.Text) > StrToTime('23:00')) then begin
    Uteis.SayInfo('Horário agendado é inválido, o início do agendamento não pode estar entre 23:00 às 05:00! Verifique.');

    Self.MaskEdit_Hora_InicioAte.SetFocus();
    exit;
  end;

  Result:= TRUE;

end;

end.
