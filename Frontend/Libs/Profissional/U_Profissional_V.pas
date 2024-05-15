unit U_Profissional_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Main, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, U_Profissional_M;

type
  TfrmProfissionais_V = class(TfrmTemplateForm_Main)
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerStartUpTimer(Sender: TObject);
    procedure SpeedButton_AddClick(Sender: TObject);
  private
    { Private declarations }

    GLB_ListaProfissionais                    : TProfissional_List_M;

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

procedure TfrmProfissionais_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  GLB_ListaProfissionais.Free();
end;

procedure TfrmProfissionais_V.FormCreate(Sender: TObject);
begin
  inherited;

  GLB_ListaProfissionais:= Nil;

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
  Profissional                                 : TProfissional_M;

begin

  Uteis.StringGridDelete_AllRows(StringGridMain);

  If GLB_ListaProfissionais.Count = 0 Then
    Exit;

  Row:= StringGridMain.FixedRows;
  for C:= 0 to GLB_ListaProfissionais.Count - 1 do begin
    Profissional:= TProfissional_M(GLB_ListaProfissionais[C]);

    If Profissional = Nil Then
      Continue;

    If NOT (Profissional is TProfissional_M) Then
      Continue;

    StringGridMain.Cells[COL_ID, Row]:= IntToStr(Profissional.Id);
    StringGridMain.Cells[COL_NOME, Row]:= Profissional.Nome;
    StringGridMain.Cells[COL_CELULAR, Row]:= Profissional.Celular;
    StringGridMain.Cells[COL_EMAIL, Row]:= Profissional.Email;
    StringGridMain.Cells[COL_ATIVO, Row]:= Uteis.Iff(Profissional.Ativo, 'Sim', 'Não');
    StringGridMain.Cells[COL_IDX_LISTA, Row]:= IntToStr(C);

    Inc(Row);
  end;

  If Row > StringGridMain.FixedRows Then
    StringGridMain.RowCount:= Row;

end;

procedure TfrmProfissionais_V.RetorneTodosProfissionais;
begin
  GLB_ListaProfissionais.RetornoLista();
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

    GLB_ListaProfissionais.Add(NovoProfissional);

    Refresh_StringGrid();
      
  Except
    NovoProfissional.Free;
  End;

end;

procedure TfrmProfissionais_V.TimerStartUpTimer(Sender: TObject);
begin

  inherited;

  GLB_ListaProfissionais:= TProfissional_List_M.Create();

  Self.RetorneTodosProfissionais();
  Self.Refresh_StringGrid();

end;

end.
