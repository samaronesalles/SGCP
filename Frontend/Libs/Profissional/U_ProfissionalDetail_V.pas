unit U_ProfissionalDetail_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Detail, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, U_Profissional_M;

type
  TfrmProfissionalDetail_V = class(TfrmTemplateForm_Detail)
    Label1: TLabel;
    EditCodigo: TEdit;
    Label2: TLabel;
    EditNome: TEdit;
    ComboBoxAtivo: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    EditEmail: TEdit;
    Label5: TLabel;
    MaskEditCelular: TMaskEdit;
    Bevel1: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    EditUsuario: TEdit;
    Label8: TLabel;
    EditSenha: TEdit;
    Label_di: TLabel;
    procedure ButtonProsseguirClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditNomeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    GLB_Profissional_M                       : TProfissional_M;

    function ValidaCamposObrigatorios: Boolean;
  public
    { Public declarations }

    function Execute_Novo: TProfissional_M;
  end;

var
  frmProfissionalDetail_V: TfrmProfissionalDetail_V;

implementation

uses U_frmMain, Uteis;

{$R *.dfm}

procedure TfrmProfissionalDetail_V.ButtonProsseguirClick(Sender: TObject);
begin

  if NOT ButtonProsseguir.Enabled then
    Exit;

  Try
    Try
      ButtonProsseguir.Enabled:= FALSE;
      ButtonCancelar.Enabled:= FALSE;

      if NOT Self.ValidaCamposObrigatorios() then
        Exit;

      Self.GLB_Profissional_M:= TProfissional_M.Create();

      Self.GLB_Profissional_M.Id:= Str2Num(EditCodigo.Text);
      Self.GLB_Profissional_M.Di:= Label_di.Caption;
      Self.GLB_Profissional_M.Nome:= EditNome.Text;
      Self.GLB_Profissional_M.Celular:= Uteis.OnlyNumbersOnString(MaskEditCelular.Text);
      Self.GLB_Profissional_M.Email:= EditEmail.Text;
      Self.GLB_Profissional_M.Ativo:= Uteis.iff(ComboBoxAtivo.ItemIndex = 0, TRUE, FALSE);
      Self.GLB_Profissional_M.Username:= EditUsuario.Text;
      Self.GLB_Profissional_M.Password:= EditSenha.Text;

      if NOT Self.GLB_Profissional_M.Save() Then
        Exit;

      Self.EditCodigo.Text:= IntToStr(Self.GLB_Profissional_M.id);
      Self.Label_di.Caption:= Self.GLB_Profissional_M.Di;

      frmMain.BufferStr:= Self.GLB_Profissional_M.ToJSON();

      ModalResult:= mrOk;
    Except
      ModalResult:= mrAbort;
    End;
  Finally
    ButtonProsseguir.Enabled:= TRUE;
    ButtonCancelar.Enabled:= TRUE;
  End;

end;

procedure TfrmProfissionalDetail_V.EditNomeKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #13 then begin
    GoNextField();
    exit;
  end;

end;

function TfrmProfissionalDetail_V.Execute_Novo: TProfissional_M;
var
  BkpBufferStr                              : String;
  ResultadoModal                            : TModalResult;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;

    Try
      Result:= Nil;
      frmMain.BufferStr:= '';

      if frmProfissionalDetail_V = Nil then
        frmProfissionalDetail_V:= TfrmProfissionalDetail_V.Create(Self);

      ResultadoModal:= frmProfissionalDetail_V.ShowModal;

      if ResultadoModal <> mrOk then
        Exit;

      Result:= TProfissional_M.ToObject(frmMain.BufferStr);
    Except
      Result.Free();
      Result:= Nil;
    End;
  Finally
    frmMain.BufferStr:= BkpBufferStr;
    frmProfissionalDetail_V.Free();
  End;

end;

procedure TfrmProfissionalDetail_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmProfissionalDetail_V:= Nil;
  Action:= caFree;
end;

procedure TfrmProfissionalDetail_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  if NOT ButtonProsseguir.Enabled then begin
    CanClose:= FALSE;
    exit;
  end;

  inherited;

end;

procedure TfrmProfissionalDetail_V.FormCreate(Sender: TObject);
begin
  inherited;

  Self.GLB_Profissional_M:= Nil;
  Self.Label_di.Caption:= '';

end;

function TfrmProfissionalDetail_V.ValidaCamposObrigatorios: Boolean;
begin

  Result:= FALSE;

  if Trim(EditNome.Text) = '' then begin
    Uteis.SayInfo('Campo "Nome" é obrigatório! Verifique.');

    EditNome.SetFocus();
    exit;
  end;

  if Trim(Uteis.OnlyNumbersOnString(MaskEditCelular.Text)) = '' then begin
    Uteis.SayInfo('Campo "Celular" é obrigatório! Verifique.');

    MaskEditCelular.SetFocus();
    exit;
  end;

  if Trim(EditEmail.Text) = '' then begin
    Uteis.SayInfo('Campo "E-mail" é obrigatório! Verifique.');

    EditEmail.SetFocus();
    exit;
  end;

  Result:= TRUE;

end;

end.
