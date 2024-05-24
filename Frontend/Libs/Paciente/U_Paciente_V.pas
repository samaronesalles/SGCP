unit U_Paciente_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Main, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, System.Generics.Collections,
  U_Paciente_M;

type
  TfrmPacientes_V = class(TfrmTemplateForm_Main)
    procedure ButtonLimparFiltroClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_AddClick(Sender: TObject);
    procedure SpeedButton_DeleteClick(Sender: TObject);
    procedure SpeedButton_SearchClick(Sender: TObject);
    procedure StringGridMainDblClick(Sender: TObject);
    procedure StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure TimerStartUpTimer(Sender: TObject);
    procedure StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    FGLB_ListaPacientes                        : TPaciente_List_M;
    FGLB_ListaFiltro                           : TList<Integer>;

    procedure RetorneTodosPacientes;
    procedure Refresh_StringGrid;
  public
    { Public declarations }
  end;

const
   COL_ID                = 0;
   COL_NOME              = 1;
   COL_CELULAR           = 2;
   COL_EMAIL             = 3;
   COL_ATIVO             = 4;
   COL_IDX_LISTA         = 5;

var
  frmPacientes_V: TfrmPacientes_V;

implementation

uses Uteis, U_PacienteDetail_V;

{$R *.dfm}

procedure TfrmPacientes_V.ButtonLimparFiltroClick(Sender: TObject);
begin
  inherited;

  if Uteis.SayQuestion('Filtro', 'Deseja realmente limpar o filtro aplicado?', TMsgDlgType.mtConfirmation, mbYesNo, mrNo, 0) <> mrYes then
    Exit;

  Self.FGLB_ListaFiltro.Clear();

  Self.Refresh_StringGrid();

end;

procedure TfrmPacientes_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Self.FGLB_ListaPacientes.Free();
  Self.FGLB_ListaFiltro.Free();
end;

procedure TfrmPacientes_V.FormCreate(Sender: TObject);
begin
  inherited;

  Self.FGLB_ListaPacientes:= Nil;
  Self.FGLB_ListaFiltro:= Nil;

  StringGridMain.Cells[COL_ID, 0]:= 'Código';
  StringGridMain.ColWidths[COL_ID]:= 60;

  StringGridMain.Cells[COL_NOME, 0]:= 'Nome';
  StringGridMain.ColWidths[COL_NOME]:= 400;

  StringGridMain.Cells[COL_CELULAR, 0]:= 'Celular';
  StringGridMain.ColWidths[COL_CELULAR]:= 120;

  StringGridMain.Cells[COL_EMAIL, 0]:= 'E-mail';
  StringGridMain.ColWidths[COL_EMAIL]:= 250;

  StringGridMain.Cells[COL_ATIVO, 0]:= 'Ativo';
  StringGridMain.ColWidths[COL_ATIVO]:= 50;

  StringGridMain.ColCount:= 5;
  StringGridMain.RowCount:= 2;

  TimerStartUp.Enabled:= TRUE;

end;

procedure TfrmPacientes_V.Refresh_StringGrid;
var
  C, Row                                       : integer;
  FiltrouAlgo                                  : Boolean;
  Paciente                                     : TPaciente_M;

begin

  try

    Uteis.StringGridDelete_AllRows(StringGridMain);

    FiltrouAlgo:= FALSE;

    If Self.FGLB_ListaPacientes.Count = 0 Then
      Exit;

    Row:= StringGridMain.FixedRows;
    for C:= 0 to Self.FGLB_ListaPacientes.Count - 1 do begin
      Paciente:= TPaciente_M(Self.FGLB_ListaPacientes[C]);

      if Paciente = Nil then
        Continue;

      if NOT (Paciente is TPaciente_M) then
        Continue;

      if ((Self.FGLB_ListaFiltro.Count > 0) AND (NOT Self.FGLB_ListaFiltro.Contains(Paciente.Id))) then begin
        FiltrouAlgo:= TRUE;
        Continue;
      end;

      StringGridMain.Cells[COL_ID, Row]:= IntToStr(Paciente.Id);
      StringGridMain.Cells[COL_NOME, Row]:= Paciente.Nome;
      StringGridMain.Cells[COL_CELULAR, Row]:= Paciente.Celular;
      StringGridMain.Cells[COL_EMAIL, Row]:= Paciente.Email;
      StringGridMain.Cells[COL_ATIVO, Row]:= Uteis.Iff(Paciente.Ativo, 'Ativo', 'Inativo');
      StringGridMain.Cells[COL_IDX_LISTA, Row]:= IntToStr(C);

      Inc(Row);
    end;

    If Row > StringGridMain.FixedRows Then
      StringGridMain.RowCount:= Row;

  finally
    ButtonLimparFiltro.Visible:= FiltrouAlgo;
  end;

end;

procedure TfrmPacientes_V.RetorneTodosPacientes;
begin
  Self.FGLB_ListaPacientes.Clear();
  Self.FGLB_ListaPacientes.RetornoLista();
end;

procedure TfrmPacientes_V.SpeedButton_AddClick(Sender: TObject);
var
  NovoPaciente                        : TPaciente_M;

begin

  NovoPaciente:= Nil;

  Try
    NovoPaciente:= frmPacienteDetail_V.Execute_Novo();

    if NovoPaciente = Nil then
      raise Exception.Create('');

    if NovoPaciente.Id <= 0 then
      raise Exception.Create('');

    Self.FGLB_ListaPacientes.Add(NovoPaciente);

    Refresh_StringGrid();

  Except
    NovoPaciente.Free;
  End;

end;

procedure TfrmPacientes_V.SpeedButton_DeleteClick(Sender: TObject);
var
  Posicao                        : Longint;
  ItemLista, ItemEditado         : TPaciente_M;

begin

  ItemEditado:= Nil;

  Posicao:= Str2Num(StringGridMain.Cells[COL_IDX_LISTA, StringGridMain.Row]);

  if Posicao < 0 then
    Exit;

  if Self.FGLB_ListaPacientes = Nil then
    Exit;

  if Self.FGLB_ListaPacientes.Count = 0 then
    Exit;

  ItemLista:= Self.FGLB_ListaPacientes[Posicao];

  if Uteis.SayQuestion('Exclusão de paciente', 'Deseja realmente excluir o paciente "' + ItemLista.Nome + '"?', TMsgDlgType.mtConfirmation, mbYesNo, mrNo, 0) <> mrYes then
    Exit;

  if NOT ItemLista.Delete() then
    RetorneTodosPacientes()
  else
    Self.FGLB_ListaPacientes.Delete(Posicao);

  Refresh_StringGrid();

end;

procedure TfrmPacientes_V.SpeedButton_SearchClick(Sender: TObject);
var
  ItemLista                      : Longint;
  Nome                           : String;

begin

  Self.FGLB_ListaFiltro.Clear;

  if Self.FGLB_ListaPacientes.Count = 0 then
    Exit;

  Try
    Nome:= InputBox('Filtro', 'Nome: ', '');

    if Nome.Trim() = '' then
      Exit;

    Self.FGLB_ListaFiltro.Clear();
    Self.FGLB_ListaFiltro.Free();

    Self.FGLB_ListaFiltro:= Self.FGLB_ListaPacientes.FiltraLista(Nome);

    if Self.FGLB_ListaFiltro = Nil then
      Exit;

    if Self.FGLB_ListaFiltro.Count = 0 then
      Exit;

    if Self.FGLB_ListaFiltro.Count > 0 then
      Refresh_StringGrid();

  Finally
  End;

end;

procedure TfrmPacientes_V.StringGridMainDblClick(Sender: TObject);
var
  Posicao                        : Longint;
  ItemLista, ItemEditado         : TPaciente_M;

begin

  ItemEditado:= Nil;

  Posicao:= Str2Num(StringGridMain.Cells[COL_IDX_LISTA, StringGridMain.Row]);

  if Posicao < 0 then
    Exit;

  if Self.FGLB_ListaPacientes = Nil then
    Exit;

  if Self.FGLB_ListaPacientes.Count = 0 then
    Exit;

  ItemLista:= Self.FGLB_ListaPacientes[Posicao];

  If frmPacienteDetail_V.Execute_Editar(ItemLista) then
    Self.FGLB_ListaPacientes[Posicao]:= ItemLista
  else
    RetorneTodosPacientes();

  Refresh_StringGrid();

end;

procedure TfrmPacientes_V.StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  CorFont, CorLinha              : TColor;

begin
  inherited;

  CorFont:= clRed;
  CorLinha:= Self.GetCorCell(StringGridMain, ACol, ARow);

  if AnsiUpperCase(StringGridMain.Cells[COL_ATIVO, ARow]) = 'INATIVO' then
    Uteis.SetCorRowgrid(StringGridMain, CorFont, CorLinha, ACol, ARow, Rect, State);

end;

procedure TfrmPacientes_V.StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  if Key = VK_F5 then begin
    Key:= 0;

    Self.RetorneTodosPacientes();
    Self.Refresh_StringGrid();

    Exit;
  end;

end;

procedure TfrmPacientes_V.TimerStartUpTimer(Sender: TObject);
begin
  inherited;

  Self.FGLB_ListaPacientes:= TPaciente_List_M.Create();
  Self.FGLB_ListaFiltro:= TList<Integer>.Create();

  Self.RetorneTodosPacientes();
  Self.Refresh_StringGrid();

end;

end.
