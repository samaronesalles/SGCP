unit U_Profissional_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Main, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, System.Generics.Collections,
  U_Profissional_M;

type
  TfrmProfissionais_V = class(TfrmTemplateForm_Main)
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerStartUpTimer(Sender: TObject);
    procedure SpeedButton_AddClick(Sender: TObject);
    procedure StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridMainDblClick(Sender: TObject);
    procedure SpeedButton_DeleteClick(Sender: TObject);
    procedure SpeedButton_SearchClick(Sender: TObject);
    procedure ButtonLimparFiltroClick(Sender: TObject);
    procedure StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    FGLB_ListaProfissionais                    : TProfissional_List_M;
    FGLB_ListaFiltro                           : TList<Integer>;

    procedure RetorneTodosProfissionais;
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
  frmProfissionais_V: TfrmProfissionais_V;

implementation

uses Uteis, U_ProfissionalDetail_V;

{$R *.dfm}

procedure TfrmProfissionais_V.ButtonLimparFiltroClick(Sender: TObject);
begin
  inherited;

  if Uteis.SayQuestion('Filtro', 'Deseja realmente limpar o filtro aplicado?', TMsgDlgType.mtConfirmation, mbYesNo, mrNo, 0) <> mrYes then
    Exit;

  Self.FGLB_ListaFiltro.Clear();

  Self.Refresh_StringGrid();

end;

procedure TfrmProfissionais_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Self.FGLB_ListaProfissionais.Free();
  Self.FGLB_ListaFiltro.Free();
end;

procedure TfrmProfissionais_V.FormCreate(Sender: TObject);
begin
  inherited;

  Self.FGLB_ListaProfissionais:= Nil;
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

procedure TfrmProfissionais_V.Refresh_StringGrid;
var
  C, Row                                       : integer;
  FiltrouAlgo                                  : Boolean;
  Profissional                                 : TProfissional_M;

begin

  try

    Uteis.StringGridDelete_AllRows(StringGridMain);

    FiltrouAlgo:= FALSE;

    If Self.FGLB_ListaProfissionais.Count = 0 Then
      Exit;

    Row:= StringGridMain.FixedRows;
    for C:= 0 to Self.FGLB_ListaProfissionais.Count - 1 do begin
      Profissional:= TProfissional_M(Self.FGLB_ListaProfissionais[C]);

      if Profissional = Nil then
        Continue;

      if NOT (Profissional is TProfissional_M) then
        Continue;

      if ((Self.FGLB_ListaFiltro.Count > 0) AND (NOT Self.FGLB_ListaFiltro.Contains(Profissional.Id))) then begin
        FiltrouAlgo:= TRUE;
        Continue;
      end;

      StringGridMain.Cells[COL_ID, Row]:= IntToStr(Profissional.Id);
      StringGridMain.Cells[COL_NOME, Row]:= Profissional.Nome;
      StringGridMain.Cells[COL_CELULAR, Row]:= Profissional.Celular;
      StringGridMain.Cells[COL_EMAIL, Row]:= Profissional.Email;
      StringGridMain.Cells[COL_ATIVO, Row]:= Uteis.Iff(Profissional.Ativo, 'Ativo', 'Inativo');
      StringGridMain.Cells[COL_IDX_LISTA, Row]:= IntToStr(C);

      Inc(Row);
    end;

    If Row > StringGridMain.FixedRows Then
      StringGridMain.RowCount:= Row;

  finally
    ButtonLimparFiltro.Visible:= FiltrouAlgo;
  end;

end;

procedure TfrmProfissionais_V.RetorneTodosProfissionais;
begin
  Self.FGLB_ListaProfissionais.Clear();
  Self.FGLB_ListaProfissionais.RetornoLista();
end;

procedure TfrmProfissionais_V.SpeedButton_AddClick(Sender: TObject);
var
  NovoProfissional                     : TProfissional_M;

begin

  NovoProfissional:= Nil;

  Try
    NovoProfissional:= frmProfissionalDetail_V.Execute_Novo();

    if NovoProfissional = Nil then
      raise Exception.Create('');

    if NovoProfissional.Id <= 0 then
      raise Exception.Create('');

    Self.FGLB_ListaProfissionais.Add(NovoProfissional);

    Refresh_StringGrid();

  Except
    NovoProfissional.Free;
  End;

end;

procedure TfrmProfissionais_V.SpeedButton_DeleteClick(Sender: TObject);
var
  Posicao                        : Longint;
  ItemLista, ItemEditado         : TProfissional_M;

begin

  ItemEditado:= Nil;

  Posicao:= Str2Num(StringGridMain.Cells[COL_IDX_LISTA, StringGridMain.Row]);

  if Posicao < 0 then
    Exit;

  if Self.FGLB_ListaProfissionais = Nil then
    Exit;

  if Self.FGLB_ListaProfissionais.Count = 0 then
    Exit;

  ItemLista:= Self.FGLB_ListaProfissionais[Posicao];

  if Uteis.SayQuestion('Exclusão de profissional', 'Deseja realmente excluir o profissional "' + ItemLista.Nome + '"?', TMsgDlgType.mtConfirmation, mbYesNo, mrNo, 0) <> mrYes then
    Exit;

  if NOT ItemLista.Delete() then
    RetorneTodosProfissionais()
  else
    Self.FGLB_ListaProfissionais.Delete(Posicao);

  Refresh_StringGrid();

end;

procedure TfrmProfissionais_V.SpeedButton_SearchClick(Sender: TObject);
var
  ItemLista                      : Longint;
  Nome                           : String;

begin

  Self.FGLB_ListaFiltro.Clear;

  if Self.FGLB_ListaProfissionais.Count = 0 then
    Exit;

  Try
    Nome:= InputBox('Filtro', 'Nome: ', '');

    if Nome.Trim() = '' then
      Exit;

    Self.FGLB_ListaFiltro.Clear();
    Self.FGLB_ListaFiltro.Free();

    Self.FGLB_ListaFiltro:= Self.FGLB_ListaProfissionais.FiltraLista(Nome);

    if Self.FGLB_ListaFiltro = Nil then
      Exit;

    if Self.FGLB_ListaFiltro.Count = 0 then
      Exit;

    if Self.FGLB_ListaFiltro.Count > 0 then
      Refresh_StringGrid();

  Finally
  End;

end;

procedure TfrmProfissionais_V.StringGridMainDblClick(Sender: TObject);
var
  Posicao                        : Longint;
  ItemLista, ItemEditado         : TProfissional_M;

begin

  ItemEditado:= Nil;

  Posicao:= Str2Num(StringGridMain.Cells[COL_IDX_LISTA, StringGridMain.Row]);

  if Posicao < 0 then
    Exit;

  if Self.FGLB_ListaProfissionais = Nil then
    Exit;

  if Self.FGLB_ListaProfissionais.Count = 0 then
    Exit;

  ItemLista:= Self.FGLB_ListaProfissionais[Posicao];

  If frmProfissionalDetail_V.Execute_Editar(ItemLista) then
    Self.FGLB_ListaProfissionais[Posicao]:= ItemLista
  else
    RetorneTodosProfissionais();

  Refresh_StringGrid();

end;

procedure TfrmProfissionais_V.StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  CorFont, CorLinha              : TColor;

begin
  inherited;

  CorFont:= clRed;
  CorLinha:= Self.GetCorCell(StringGridMain, ACol, ARow);

  if AnsiUpperCase(StringGridMain.Cells[COL_ATIVO, ARow]) = 'INATIVO' then
    Uteis.SetCorRowgrid(StringGridMain, CorFont, CorLinha, ACol, ARow, Rect, State);

end;

procedure TfrmProfissionais_V.StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  if Key = VK_F5 then begin
    Key:= 0;

    Self.RetorneTodosProfissionais();
    Self.Refresh_StringGrid();

    Exit;
  end;

end;

procedure TfrmProfissionais_V.TimerStartUpTimer(Sender: TObject);
begin

  inherited;

  Self.FGLB_ListaProfissionais:= TProfissional_List_M.Create();
  Self.FGLB_ListaFiltro:= TList<Integer>.Create();

  Self.RetorneTodosProfissionais();
  Self.Refresh_StringGrid();

end;

end.
