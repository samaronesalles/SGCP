unit U_PacienteDropList_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_DropList, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Grids, Vcl.StdCtrls, U_Paciente_M;

type
  TfrmPacienteDropList_V = class(TfrmTemplateForm_DropList)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StringGridMainDblClick(Sender: TObject);
    procedure StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerStartUpTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    procedure RetorneTodosPacientes;
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
  frmPacienteDropList_V: TfrmPacienteDropList_V;

implementation

{$R *.dfm}

uses U_frmMain, Uteis;

function TfrmPacienteDropList_V.Execute: string;
var
  BkpBufferStr                              : String;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;

    Try
      Result:= '';
      frmMain.BufferStr:= '';

      if frmPacienteDropList_V = Nil then
        frmPacienteDropList_V:= TfrmPacienteDropList_V.Create(Nil);

      if frmPacienteDropList_V.ShowModal <> mrOk Then
        Exit;

      Result:= frmMain.BufferStr;
    Except
      Result:= '';
    End;
  Finally
    frmMain.BufferStr:= BkpBufferStr;
  End;

end;

procedure TfrmPacienteDropList_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmPacienteDropList_V:= Nil;
  Action:= caFree;
end;

procedure TfrmPacienteDropList_V.FormCreate(Sender: TObject);
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

procedure TfrmPacienteDropList_V.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_F5 then begin
    Self.RetorneTodosPacientes();
    Self.Refresh_StringGrid();
  end;

end;

procedure TfrmPacienteDropList_V.Refresh_StringGrid;
var
  C, Row                                       : integer;
  Paciente                                     : TPaciente_M;

begin

  try

    Uteis.StringGridDelete_AllRows(StringGridMain);

    If frmMain.GLB_ListaPacientes.Count = 0 Then
      Exit;

    Row:= StringGridMain.FixedRows;
    for C:= 0 to frmMain.GLB_ListaPacientes.Count - 1 do begin
      Paciente:= TPaciente_M(frmMain.GLB_ListaPacientes[C]);

      if Paciente = Nil then
        Continue;

      if NOT (Paciente is TPaciente_M) then
        Continue;

      StringGridMain.Cells[COL_ID, Row]:= IntToStr(Paciente.Id);
      StringGridMain.Cells[COL_NOME, Row]:= Paciente.Nome;
      StringGridMain.Cells[COL_JSON, Row]:= Paciente.ToJSON();

      Inc(Row);
    end;

    If Row > StringGridMain.FixedRows Then
      StringGridMain.RowCount:= Row;

  finally
  end;

end;

procedure TfrmPacienteDropList_V.RetorneTodosPacientes;
begin
  frmMain.GLB_ListaPacientes.Clear();
  frmMain.GLB_ListaPacientes.RetornoLista();
end;


procedure TfrmPacienteDropList_V.StringGridMainDblClick(Sender: TObject);
begin
  inherited;

  if Str2Num(StringGridMain.Cells[COL_ID, StringGridMain.Row]) <= 0 then
    Exit;

  frmMain.BufferStr:= StringGridMain.Cells[COL_JSON, StringGridMain.Row];

  ModalResult:= mrOk;

end;

procedure TfrmPacienteDropList_V.StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_RETURN then begin
    StringGridMainDblClick(StringGridMain);
    Exit;
  end;

end;

procedure TfrmPacienteDropList_V.TimerStartUpTimer(Sender: TObject);
begin
  inherited;

  if frmMain.GLB_ListaPacientes.Count = 0 then
    Self.RetorneTodosPacientes();

  Self.Refresh_StringGrid();

end;

end.
