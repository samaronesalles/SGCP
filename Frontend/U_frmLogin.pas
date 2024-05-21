unit U_frmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList, Vcl.ImgList;

type
  TfrmLogin = class(TForm)
    Button_Sair: TButton;
    Button_Entrar: TButton;
    Edit_Usuario: TEdit;
    Label1: TLabel;
    Edit_Senha: TEdit;
    Label2: TLabel;
    ImageList_Icons: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button_SairClick(Sender: TObject);
    procedure Button_EntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    function Execute: TModalResult;
  end;

var
  frmLogin: TfrmLogin;

implementation

uses U_frmMain, U_Profissional_M;

{$R *.dfm}

procedure TfrmLogin.Button_EntrarClick(Sender: TObject);
var
  usuarioValido                                          : boolean;

begin

  Try
    usuarioValido:= FALSE;

    if frmMain.ProfissionalLogado <> Nil then
      frmMain.ProfissionalLogado.Free();

    frmMain.ProfissionalLogado:= TProfissional_M.autenticar(Edit_Usuario.Text, Edit_Senha.Text);

    if frmMain.ProfissionalLogado <> Nil then
      usuarioValido:= frmMain.ProfissionalLogado.Id > 0;

    if (NOT usuarioValido) then begin
      Edit_Usuario.SetFocus();
      Edit_Usuario.SelectAll();

      Exit;
    end;

    ModalResult:= mrOk;
  Except
    frmMain.ProfissionalLogado.Free();
  End;

end;

procedure TfrmLogin.Button_SairClick(Sender: TObject);
begin
  ModalResult:= mrAbort;
end;

function TfrmLogin.Execute: TModalResult;
begin

  if frmLogin = Nil then
    frmLogin:= TfrmLogin.Create(Self);

  result:= frmLogin.ShowModal();

end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  frmLogin:= Nil;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  Edit_Usuario.SetFocus();
end;

end.
