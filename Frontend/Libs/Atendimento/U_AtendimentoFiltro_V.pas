unit U_AtendimentoFiltro_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_MeusTipos, U_frmTemplateForm_Filtro, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAtendimentoFiltro_V = class(TfrmTemplateForm_Filtro)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox_FiltroStatus: TComboBox;
    Edit_FiltroProfissional: TEdit;
    Edit_FiltroPaciente: TEdit;
    Label_idProfissional: TLabel;
    Label_idPaciente: TLabel;
    procedure ButtonFiltrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit_FiltroProfissionalExit(Sender: TObject);
    procedure Edit_FiltroProfissionalChange(Sender: TObject);
    procedure Edit_FiltroPacienteChange(Sender: TObject);
    procedure Edit_FiltroPacienteExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    function Execute (Status: TStatusAtendimentos; idProfissional: Longint; nomeProfissional: string): string;
  end;

var
  frmAtendimentoFiltro_V: TfrmAtendimentoFiltro_V;

implementation

uses U_frmMain, Uteis, U_ProfissionalDropList_V, U_PacienteDropList_V;

{$R *.dfm}

{ TfrmAtendimentoFiltro_V }

procedure TfrmAtendimentoFiltro_V.ButtonFiltrarClick(Sender: TObject);
var
  Status, profissionalId, pacienteId                 : Longint;
  profissionalNome, pacienteNome                     : String;

begin

  Status:= iff(ComboBox_FiltroStatus.ItemIndex < 0, 0, ComboBox_FiltroStatus.ItemIndex);

  profissionalId:= iff(Str2Num(Label_idProfissional.Caption) <= 0, 0, Str2Num(Label_idProfissional.Caption));
  profissionalNome:= Edit_FiltroProfissional.Text;

  pacienteId:= iff(Str2Num(Label_idPaciente.Caption) <= 0, 0, Str2Num(Label_idPaciente.Caption));
  pacienteNome:= Edit_FiltroPaciente.Text;

  frmMain.BufferStr:= '{' +
                          '"status": ' + IntToStr(Status) + ',' +
                          '"profissionalId": ' + IntToStr(profissionalId) + ',' +
                          '"profissionalNome": ' + Uteis.ConverteTextoToJson(profissionalNome) + ',' +
                          '"pacienteId": ' + IntToStr(pacienteId) + ',' +
                          '"pacienteNome": ' + Uteis.ConverteTextoToJson(pacienteNome) +
                      '}';

  ModalResult:= mrOk;

end;

procedure TfrmAtendimentoFiltro_V.Edit_FiltroPacienteChange(Sender: TObject);
begin
  inherited;

  if Edit_FiltroPaciente.Focused then
    Label_idPaciente.Caption:= '0';

end;

procedure TfrmAtendimentoFiltro_V.Edit_FiltroPacienteExit(Sender: TObject);
var
  id                                        : Longint;
  JSON_Selecionado, nome                    : String;

begin
  inherited;

  if Str2Num(Label_idPaciente.Caption) > 0 then
    Exit;

  if Edit_FiltroPaciente.Text = '' then
    Exit;

  JSON_Selecionado:= frmPacienteDropList_V.Execute();

  id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'id'));
  nome:= Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'nome');

  if id <= 0 then
    Exit;

  Edit_FiltroPaciente.Text:= nome;
  Label_idPaciente.Caption:= IntToStr(id);

end;

procedure TfrmAtendimentoFiltro_V.Edit_FiltroProfissionalChange(Sender: TObject);
begin
  inherited;

  if Edit_FiltroProfissional.Focused then
    Label_idProfissional.Caption:= '0';

end;

procedure TfrmAtendimentoFiltro_V.Edit_FiltroProfissionalExit(Sender: TObject);
var
  id                                        : Longint;
  JSON_Selecionado, nome                    : String;

begin
  inherited;

  if Str2Num(Label_idProfissional.Caption) > 0 then
    Exit;

  if Edit_FiltroProfissional.Text = '' then
    Exit;

  JSON_Selecionado:= frmProfissionalDropList_V.Execute();

  id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'id'));
  nome:= Uteis.ReturnValor_EmJSON(JSON_Selecionado, 'nome');

  if id <= 0 then
    Exit;

  Edit_FiltroProfissional.Text:= nome;
  Label_idProfissional.Caption:= IntToStr(id);

end;

function TfrmAtendimentoFiltro_V.Execute (Status: TStatusAtendimentos; idProfissional: Longint; nomeProfissional: string): string;
var
  BkpBufferStr                              : String;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;

    Try
      Result:= '';
      frmMain.BufferStr:= '';

      if frmAtendimentoFiltro_V = Nil then
        frmAtendimentoFiltro_V:= TfrmAtendimentoFiltro_V.Create(Nil);

      frmAtendimentoFiltro_V.ComboBox_FiltroStatus.ItemIndex:= StatusAtendimento2Int(Status);

      frmAtendimentoFiltro_V.Edit_FiltroProfissional.Text:= nomeProfissional;
      frmAtendimentoFiltro_V.Label_idProfissional.Caption:= IntToStr(idProfissional);

      frmAtendimentoFiltro_V.Label_idPaciente.Caption:= '0';
      frmAtendimentoFiltro_V.Edit_FiltroPaciente.Text:= '';

      if frmAtendimentoFiltro_V.ShowModal <> mrOk Then
        Exit;

      Result:= frmMain.BufferStr;
    Except
      Result:= '';
    End;
  Finally
    frmMain.BufferStr:= BkpBufferStr;
  End;

end;

procedure TfrmAtendimentoFiltro_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  frmAtendimentoFiltro_V:= Nil;
  Action:= caFree;

end;

end.
