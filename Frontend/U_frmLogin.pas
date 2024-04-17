unit U_frmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmLogin = class(TForm)
    Button_Sair: TButton;
    Button_Entrar: TButton;
    Edit_Usuario: TEdit;
    Label1: TLabel;
    Edit_Senha: TEdit;
    Label2: TLabel;
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

{$R *.dfm}

procedure TfrmLogin.Button_EntrarClick(Sender: TObject);
var
  usuarioValido                                          : boolean;

begin

  usuarioValido:= ((Edit_Usuario.Text = 'admin') and (Edit_Senha.Text = '123'));

  if (not usuarioValido) then begin
    ShowMessage('Usuário ou senha inválidos. Verifique!');

    Edit_Usuario.SetFocus();
    Edit_Usuario.SelectAll();

    Exit;
  end;

  ModalResult:= mrOk;

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
