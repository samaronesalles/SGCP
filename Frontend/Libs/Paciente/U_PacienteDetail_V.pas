unit U_PacienteDetail_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Detail, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, U_Paciente_M;

type
  TfrmPacienteDetail_V = class(TfrmTemplateForm_Detail)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label_di: TLabel;
    EditCodigo: TEdit;
    EditNome: TEdit;
    ComboBoxAtivo: TComboBox;
    EditEmail: TEdit;
    MaskEditCelular: TMaskEdit;
    procedure ButtonProsseguirClick(Sender: TObject);
    procedure ComboBoxAtivoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    FGLB_Paciente_M                           : TPaciente_M;
    FJson_BkpPacienteEditado                  : String;

    function ValidaCamposObrigatorios: Boolean;
  public
    { Public declarations }
    property GLB_Paciente_M               : TPaciente_M Read FGLB_Paciente_M;

    function Execute_Novo: TPaciente_M;
    function Execute_Editar(VAR Paciente: TPaciente_M): Boolean;
  end;

var
  frmPacienteDetail_V: TfrmPacienteDetail_V;

implementation

uses U_frmMain, Uteis;

{$R *.dfm}

procedure TfrmPacienteDetail_V.ButtonProsseguirClick(Sender: TObject);
var
  Novo                             : Boolean;

begin

  if NOT ButtonProsseguir.Enabled then
    Exit;

  Try
    Try
      ButtonProsseguir.Enabled:= FALSE;
      ButtonCancelar.Enabled:= FALSE;

      Novo:= Str2Num(EditCodigo.Text) = 0;

      if NOT Self.ValidaCamposObrigatorios() then
        Exit;

      Self.FGLB_Paciente_M:= TPaciente_M.Create();

      Self.FGLB_Paciente_M.Id:= Str2Num(EditCodigo.Text);
      Self.FGLB_Paciente_M.Di:= Label_di.Caption;
      Self.FGLB_Paciente_M.Nome:= EditNome.Text;
      Self.FGLB_Paciente_M.Celular:= Uteis.OnlyNumbersOnString(MaskEditCelular.Text);
      Self.FGLB_Paciente_M.Email:= EditEmail.Text;
      Self.FGLB_Paciente_M.Ativo:= Uteis.iff(ComboBoxAtivo.ItemIndex = 0, TRUE, FALSE);

      If ((NOT Novo) AND (Self.FJson_BkpPacienteEditado = Self.FGLB_Paciente_M.ToJSON())) Then
        ModalResult:= mrCancel;

      if NOT Self.FGLB_Paciente_M.Save() Then
        Exit;

      Self.EditCodigo.Text:= IntToStr(Self.FGLB_Paciente_M.id);
      Self.Label_di.Caption:= Self.FGLB_Paciente_M.Di;

      frmMain.BufferStr:= Self.FGLB_Paciente_M.ToJSON();

      ModalResult:= mrOk;
    Except
      ModalResult:= mrAbort;
    End;
  Finally
    ButtonProsseguir.Enabled:= TRUE;
    ButtonCancelar.Enabled:= TRUE;
  End;

end;

procedure TfrmPacienteDetail_V.ComboBoxAtivoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_TAB) then begin
    Key:= VK_RETURN;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;

end;

function TfrmPacienteDetail_V.Execute_Novo: TPaciente_M;
var
  BkpBufferStr                              : String;
  ResultadoModal                            : TModalResult;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;

    Try
      Result:= Nil;
      frmMain.BufferStr:= '';

      if frmPacienteDetail_V = Nil then
        frmPacienteDetail_V:= TfrmPacienteDetail_V.Create(Self);

      ResultadoModal:= frmPacienteDetail_V.ShowModal;

      if ResultadoModal <> mrOk then
        Exit;

      Result:= TPaciente_M.ToObject(frmMain.BufferStr);
    Except
      Result.Free();
      Result:= Nil;
    End;
  Finally
    frmMain.BufferStr:= BkpBufferStr;
    frmPacienteDetail_V.Free();
  End;

end;

function TfrmPacienteDetail_V.Execute_Editar(VAR Paciente: TPaciente_M): Boolean;
var
  ResultadoModal                            : TModalResult;

begin

  Try
    Try
      Result:= FALSE;

      if Paciente = Nil then
        Exit;

      if Paciente.Id <= 0 then
        Exit;

      if frmPacienteDetail_V = Nil then
        frmPacienteDetail_V:= TfrmPacienteDetail_V.Create(Self);

      frmPacienteDetail_V.EditCodigo.Text:= IntToStr(Paciente.Id);
      frmPacienteDetail_V.Label_di.Caption:= Paciente.Di;
      frmPacienteDetail_V.EditNome.Text:= Paciente.Nome;
      frmPacienteDetail_V.ComboBoxAtivo.ItemIndex:= Uteis.iff(Paciente.Ativo, 0, 1);
      frmPacienteDetail_V.EditEmail.Text:= Paciente.Email;
      SetValorToMaskEdit(frmPacienteDetail_V.MaskEditCelular, Uteis.OnlyNumbersOnString(Paciente.Celular));

      frmPacienteDetail_V.FJson_BkpPacienteEditado:= Paciente.ToJSON();

      ResultadoModal:= frmPacienteDetail_V.ShowModal;

      if ResultadoModal = mrCancel then begin
        Result:= TRUE;
        Exit;
      end;

      if ResultadoModal <> mrOk then
        Exit;

      Paciente.Free();
      Paciente:= TPaciente_M.ToObject(frmMain.BufferStr);

      Result:= TRUE;
    Except
      Paciente.Free();
      Result:= FALSE;
    End;
  Finally
    frmPacienteDetail_V.Free();
  End;

end;

procedure TfrmPacienteDetail_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPacienteDetail_V:= Nil;
  Action:= caFree;
end;


procedure TfrmPacienteDetail_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  if NOT ButtonProsseguir.Enabled then begin
    CanClose:= FALSE;
    exit;
  end;

  inherited;

end;

procedure TfrmPacienteDetail_V.FormCreate(Sender: TObject);
begin
  inherited;

  Self.FGLB_Paciente_M:= Nil;
  Self.Label_di.Caption:= '';

  Self.FJson_BkpPacienteEditado:= '';

  if Uteis.MicroDesenv_Temporario() then begin
    Self.Label_di.Visible:= TRUE;
  end;

end;

procedure TfrmPacienteDetail_V.FormShow(Sender: TObject);
begin
  inherited;
  Self.EditNome.SetFocus();
end;

function TfrmPacienteDetail_V.ValidaCamposObrigatorios: Boolean;
begin

  Result:= FALSE;

  if Trim(Self.EditNome.Text) = '' then begin
    Uteis.SayInfo('Campo "Nome" é obrigatório! Verifique.');

    Self.EditNome.SetFocus();
    exit;
  end;

  if Trim(Uteis.OnlyNumbersOnString(Self.MaskEditCelular.Text)) = '' then begin
    Uteis.SayInfo('Campo "Celular" é obrigatório! Verifique.');

    Self.MaskEditCelular.SetFocus();
    exit;
  end;

  if Trim(Self.EditEmail.Text) = '' then begin
    Uteis.SayInfo('Campo "E-mail" é obrigatório! Verifique.');

    Self.EditEmail.SetFocus();
    exit;
  end;

  Result:= TRUE;

end;

end.
