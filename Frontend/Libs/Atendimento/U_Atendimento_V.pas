unit U_Atendimento_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Main, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, System.Generics.Collections, U_Atendimento_M;

type
  TfrmAtendimentos_V = class(TfrmTemplateForm_Main)
    Label4: TLabel;
    Shape3: TShape;
    Label5: TLabel;
    Shape4: TShape;
    procedure ButtonLimparFiltroClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_DeleteClick(Sender: TObject);
    procedure SpeedButton_SearchClick(Sender: TObject);
    procedure StringGridMainDblClick(Sender: TObject);
    procedure StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure TimerStartUpTimer(Sender: TObject);
    procedure StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    FGLB_ListaAtendimentos                     : TAtendimento_List_M;
    FGLB_ListaFiltro                           : TList<Integer>;

    procedure RetorneTodosAtendimentos;
    procedure Refresh_StringGrid;
  public
    { Public declarations }
  end;

const
   COL_ID                = 0;
   COL_PROFISSIONAL      = 1;
   COL_PACIENTE          = 2;
   COL_DATA              = 3;
   COL_HORA_AGENDADA     = 4;
   COL_HORA_REALIZADA    = 5;
   // Colunas invisíveis...
   COL_STATUS            = 6;
   COL_IDX_LISTA         = 7;

  COR_PENDENTE_CONFIRMACAO  = clBlack;
  COR_CANCELADOS            = clRed;
  COR_CONFIRMADA_REALIZAR   = $00FF8000;
  COR_CONFIRMADA_REALIZADA  = $00448800;

var
  frmAtendimentos_V: TfrmAtendimentos_V;

implementation

uses Uteis, U_frmMain, U_AtendimentoFiltro_V;

{$R *.dfm}

procedure TfrmAtendimentos_V.ButtonLimparFiltroClick(Sender: TObject);
begin
  inherited;

  if Uteis.SayQuestion('Filtro', 'Deseja realmente limpar o filtro aplicado?', TMsgDlgType.mtConfirmation, mbYesNo, mrNo, 0) <> mrYes then
    Exit;

  Self.FGLB_ListaFiltro.Clear();

  Self.Refresh_StringGrid();

end;

procedure TfrmAtendimentos_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Self.FGLB_ListaAtendimentos.Free();
  Self.FGLB_ListaFiltro.Free();
end;

procedure TfrmAtendimentos_V.FormCreate(Sender: TObject);
begin
  inherited;

  Self.FGLB_ListaAtendimentos:= Nil;
  Self.FGLB_ListaFiltro:= Nil;

  // Preenchimento de títulos da lista...
  StringGridMain.Cells[COL_ID, 0]:= 'Código';
  StringGridMain.ColWidths[COL_ID]:= 65;

  StringGridMain.Cells[COL_PROFISSIONAL, 0]:= 'Profissional';
  StringGridMain.ColWidths[COL_PROFISSIONAL]:= 380;

  StringGridMain.Cells[COL_PACIENTE, 0]:= 'Paciente';
  StringGridMain.ColWidths[COL_PACIENTE]:= 380;

  StringGridMain.Cells[COL_DATA, 0]:= 'Data';
  StringGridMain.ColWidths[COL_DATA]:= 93;
  StringGridMain.ColAlignments[COL_DATA]:= taCenter;

  StringGridMain.Cells[COL_HORA_AGENDADA, 0]:= 'Hora agendada';
  StringGridMain.ColWidths[COL_HORA_AGENDADA]:= 123;
  StringGridMain.ColAlignments[COL_HORA_AGENDADA]:= taCenter;

  StringGridMain.Cells[COL_HORA_REALIZADA, 0]:= 'Hora realizada';
  StringGridMain.ColWidths[COL_HORA_REALIZADA]:= 119;
  StringGridMain.ColAlignments[COL_HORA_REALIZADA]:= taCenter;

  StringGridMain.ColCount:= 6;
  StringGridMain.RowCount:= 2;

  // Atualizando legendas...
  Shape1.Brush.Color:= COR_PENDENTE_CONFIRMACAO;
  Shape2.Brush.Color:= COR_CANCELADOS;
  Shape3.Brush.Color:= COR_CONFIRMADA_REALIZAR;
  Shape4.Brush.Color:= COR_CONFIRMADA_REALIZADA;

  // Iniciando processamentos...
  TimerStartUp.Enabled:= TRUE;

end;

procedure TfrmAtendimentos_V.Refresh_StringGrid;
var
  C, Row                                       : integer;
  FiltrouAlgo                                  : Boolean;
  Atendimento                                  : TAtendimento_M;

begin

  try

    Uteis.StringGridDelete_AllRows(StringGridMain);

    FiltrouAlgo:= FALSE;

    If Self.FGLB_ListaAtendimentos.Count = 0 Then
      Exit;

    Row:= StringGridMain.FixedRows;
    for C:= 0 to Self.FGLB_ListaAtendimentos.Count - 1 do begin
      Atendimento:= TAtendimento_M(Self.FGLB_ListaAtendimentos[C]);

      if Atendimento = Nil then
        Continue;

      if NOT (Atendimento is TAtendimento_M) then
        Continue;

      if ((Self.FGLB_ListaFiltro.Count > 0) AND (NOT Self.FGLB_ListaFiltro.Contains(Atendimento.Id))) then begin
        FiltrouAlgo:= TRUE;
        Continue;
      end;

      StringGridMain.Cells[COL_ID, Row]:= IntToStr(Atendimento.Id);
      StringGridMain.Cells[COL_PROFISSIONAL, Row]:= Atendimento.Agenda.Profissional.Nome;
      StringGridMain.Cells[COL_PACIENTE, Row]:= Atendimento.Agenda.Paciente.Nome;
      StringGridMain.Cells[COL_DATA, Row]:= Copy(DateTime2Str(Atendimento.DataHoraIni), 1, 10);
      StringGridMain.Cells[COL_HORA_AGENDADA, Row]:= Copy(DateTime2Str(Atendimento.DataHoraIni), 12, 5);
      StringGridMain.Cells[COL_HORA_REALIZADA, Row]:= '';
      StringGridMain.Cells[COL_STATUS, Row]:= IntToStr(Atendimento.Status);
      StringGridMain.Cells[COL_IDX_LISTA, Row]:= IntToStr(C);

      Inc(Row);
    end;

    If Row > StringGridMain.FixedRows Then
      StringGridMain.RowCount:= Row;

  finally
    ButtonLimparFiltro.Visible:= FiltrouAlgo;
  end;

end;

procedure TfrmAtendimentos_V.RetorneTodosAtendimentos;
begin
  Self.FGLB_ListaAtendimentos.Clear();
  Self.FGLB_ListaAtendimentos.RetornoLista();
end;

procedure TfrmAtendimentos_V.SpeedButton_DeleteClick(Sender: TObject);
var
  Posicao, id                    : Longint;
  ItemLista, ItemEditado         : TAtendimento_M;

begin

  ItemEditado:= Nil;

  Posicao:= Str2Num(StringGridMain.Cells[COL_IDX_LISTA, StringGridMain.Row]);

  if Posicao < 0 then
    Exit;

  if Self.FGLB_ListaAtendimentos = Nil then
    Exit;

  if Self.FGLB_ListaAtendimentos.Count = 0 then
    Exit;

  ItemLista:= Self.FGLB_ListaAtendimentos[Posicao];

  if Uteis.SayQuestion('Cancelamento', 'Deseja realmente cancelar o atencimento do paciente "' + ItemLista.Agenda.Paciente.Nome + '"?', TMsgDlgType.mtConfirmation, mbYesNo, mrNo, 0) <> mrYes then
    Exit;

  id:= ItemLista.Id;

  if NOT ItemLista.Agenda.CancelarAtendamento() then
    SayError('Atendimento e agenda não foram cancelados. Verifique')
  else begin
    RetorneTodosAtendimentos();

    if Self.FGLB_ListaAtendimentos.GetStatusAtendimento(id) = 2 then
      SayInfo('Atendimento e agenda cancelados com sucesso!');
  end;

  Refresh_StringGrid();

end;

procedure TfrmAtendimentos_V.SpeedButton_SearchClick(Sender: TObject);
var
  JsonFiltro                                                 : String;

begin
  inherited;

  JsonFiltro:= frmAtendimentoFiltro_V.Execute(Self.FGLB_ListaAtendimentos.Status);

  Self.FGLB_ListaAtendimentos.Status:= Str2Num(Uteis.ReturnValor_EmJSON(JsonFiltro, 'status'));
  Self.FGLB_ListaAtendimentos.ProfissionalID:= Str2Num(Uteis.ReturnValor_EmJSON(JsonFiltro, 'profissionalId'));
  Self.FGLB_ListaAtendimentos.PacienteID:= Str2Num(Uteis.ReturnValor_EmJSON(JsonFiltro, 'pacienteId'));

  RetorneTodosAtendimentos();
  Refresh_StringGrid();

end;

procedure TfrmAtendimentos_V.StringGridMainDblClick(Sender: TObject);
begin
  inherited;

  Uteis.SayInfo('Em desenvolvimento: TfrmAtendimentos_V.StringGridMainDblClick()');
end;

procedure TfrmAtendimentos_V.StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  CorFont, CorLinha              : TColor;

begin

  inherited;

  CorFont:= clBlack;
  CorLinha:= Self.GetCorCell(StringGridMain, ACol, ARow);

  Case Uteis.Str2Num(StringGridMain.Cells[COL_STATUS, ARow]) Of
    1: CorFont:= COR_PENDENTE_CONFIRMACAO;
    2: CorFont:= COR_CANCELADOS;
    3: CorFont:= COR_CONFIRMADA_REALIZAR;
    4: CorFont:= COR_CONFIRMADA_REALIZADA;
  End;

  Self.SetCorRowgrid(StringGridMain, CorFont, CorLinha, ACol, ARow, Rect, State);

end;

procedure TfrmAtendimentos_V.StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  if Key = VK_F5 then begin
    Key:= 0;

    Self.RetorneTodosAtendimentos();
    Self.Refresh_StringGrid();

    Exit;
  end;

end;

procedure TfrmAtendimentos_V.TimerStartUpTimer(Sender: TObject);
begin
  inherited;

  Self.FGLB_ListaAtendimentos:= TAtendimento_List_M.Create();

  Self.FGLB_ListaAtendimentos.Status:= 0;            // Filtrando por todos
  Self.FGLB_ListaAtendimentos.ProfissionalID:= frmMain.ProfissionalLogado.Id;
  Self.FGLB_ListaAtendimentos.PacienteID:= 0;        // Exibindo atendimentos a todos os pacientes

  Self.FGLB_ListaFiltro:= TList<Integer>.Create();

  Self.RetorneTodosAtendimentos();
  Self.Refresh_StringGrid();

end;

end.
