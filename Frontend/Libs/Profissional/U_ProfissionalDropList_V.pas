unit U_ProfissionalDropList_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_DropList, System.ImageList, Vcl.ImgList,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, U_Profissional_M;

type
  TfrmProfissionalDropList_V = class(TfrmTemplateForm_DropList)
    procedure FormCreate(Sender: TObject);
    procedure StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerStartUpTimer(Sender: TObject);
    procedure StringGridMainDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    procedure RetorneTodosProfissionais;
    procedure Refresh_StringGrid;
  public
    { Public declarations }

    function Execute: string;
  end;

const
   COL_ID                = 0;
   COL_NOME              = 1;
   COL_JSON              = 2;

var
  frmProfissionalDropList_V: TfrmProfissionalDropList_V;

implementation

{$R *.dfm}

uses U_frmMain, Uteis;

function TfrmProfissionalDropList_V.Execute: string;
var
  BkpBufferStr                              : String;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;

    Try
      Result:= '';
      frmMain.BufferStr:= '';

      if frmProfissionalDropList_V = Nil then
        frmProfissionalDropList_V:= TfrmProfissionalDropList_V.Create(Nil);

      if frmProfissionalDropList_V.ShowModal <> mrOk Then
        Exit;

      Result:= frmMain.BufferStr;
    Except
      Result:= '';
    End;
  Finally
    frmMain.BufferStr:= BkpBufferStr;
  End;

end;

procedure TfrmProfissionalDropList_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmProfissionalDropList_V:= Nil;
  Action:= caFree;
end;

procedure TfrmProfissionalDropList_V.FormCreate(Sender: TObject);
begin
  inherited;

  Self.StringGridMain.Cells[COL_ID, 0]:= 'Código';
  Self.StringGridMain.ColWidths[COL_ID]:= 65;

  Self.StringGridMain.Cells[COL_NOME, 0]:= 'Nome';
  Self.StringGridMain.ColWidths[COL_NOME]:= 400;

  Self.StringGridMain.ColCount:= 2;
  Self.StringGridMain.RowCount:= 2;

  TimerStartUp.Enabled:= TRUE;

end;

procedure TfrmProfissionalDropList_V.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_F5 then begin
    Self.RetorneTodosProfissionais();
    Self.Refresh_StringGrid();
  end;

end;

procedure TfrmProfissionalDropList_V.Refresh_StringGrid;
var
  C, Row                                       : integer;
  Profissional                                 : TProfissional_M;

begin

  try

    Uteis.StringGridDelete_AllRows(StringGridMain);

    If frmMain.GLB_ListaProfissionais.Count = 0 Then
      Exit;

    Row:= StringGridMain.FixedRows;
    for C:= 0 to frmMain.GLB_ListaProfissionais.Count - 1 do begin
      Profissional:= TProfissional_M(frmMain.GLB_ListaProfissionais[C]);

      if Profissional = Nil then
        Continue;

      if NOT (Profissional is TProfissional_M) then
        Continue;

      StringGridMain.Cells[COL_ID, Row]:= IntToStr(Profissional.Id);
      StringGridMain.Cells[COL_NOME, Row]:= Profissional.Nome;
      StringGridMain.Cells[COL_JSON, Row]:= Profissional.ToJSON();

      Inc(Row);
    end;

    If Row > StringGridMain.FixedRows Then
      StringGridMain.RowCount:= Row;

  finally
  end;

end;

procedure TfrmProfissionalDropList_V.RetorneTodosProfissionais;
begin
  frmMain.GLB_ListaProfissionais.Clear();
  frmMain.GLB_ListaProfissionais.RetornoLista();
end;

procedure TfrmProfissionalDropList_V.StringGridMainDblClick(Sender: TObject);
begin
  inherited;

  if Str2Num(StringGridMain.Cells[COL_ID, StringGridMain.Row]) <= 0 then
    Exit;

  frmMain.BufferStr:= StringGridMain.Cells[COL_JSON, StringGridMain.Row];

  ModalResult:= mrOk;

end;

procedure TfrmProfissionalDropList_V.StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_RETURN then begin
    StringGridMainDblClick(StringGridMain);
    Exit;
  end;

end;


procedure TfrmProfissionalDropList_V.TimerStartUpTimer(Sender: TObject);
begin
  inherited;

  if frmMain.GLB_ListaProfissionais.Count = 0 then
    Self.RetorneTodosProfissionais();

  Self.Refresh_StringGrid();

end;

end.
