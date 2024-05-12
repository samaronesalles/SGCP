unit U_frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.Themes,
  Vcl.ExtCtrls, Vcl.WinXCalendars, System.TypInfo, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Movimentaes1: TMenuItem;
    Sobre1: TMenuItem;
    Pacientes1: TMenuItem;
    erapeutas1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Agendamentos1: TMenuItem;
    Atendimentos1: TMenuItem;
    Sobre2: TMenuItem;
    StatusBar: TStatusBar;
    Configuraes1: TMenuItem;
    emas1: TMenuItem;
    Windows1: TMenuItem;
    WindowsDark1: TMenuItem;
    Timer_login: TTimer;
    Janelas1: TMenuItem;
    Button_Teste: TButton;
    Memo_Teste: TMemo;
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Windows1Click(Sender: TObject);
    procedure WindowsDark1Click(Sender: TObject);
    procedure Timer_loginTimer(Sender: TObject);
    procedure Button_TesteClick(Sender: TObject);
  private
    { Private declarations }
    FDefaultStyleName : String;

    procedure SetDefaultStyleName(styleNam: String);

    function  IsChildFormExist(InstanceClass: TFormClass): Boolean;
    procedure ShowChild(MainForm : TForm; InstanceClass: TFormClass; var Reference);
  public
    { Public declarations }

    BufferStr                                           : String;

    property DefaultStyleName                           : String Read FdefaultStyleName Write SetDefaultStyleName;
  end;

var
  frmMain: TfrmMain;

implementation

uses U_frmLogin, Uteis, U_ConexaoAPI_V, U_ConexaoAPI_M;

{$R *.dfm}

function TfrmMain.IsChildFormExist(InstanceClass: TFormClass): Boolean;
var
  I: Integer;
begin
  with (Application.MainForm) do
    for I := 0 to MDIChildCount - 1 do
      if (MDIChildren[i] is InstanceClass) then begin
        Result := True;
        Exit;
      end;

  Result:= False;
end;

procedure TfrmMain.ShowChild(MainForm : TForm; InstanceClass: TFormClass; var Reference);
var
  Instance: TForm;

begin
  Screen.Cursor:= crHourglass;
  LockWindowUpdate(MainForm.Handle);

  if not IsChildFormExist(InstanceClass) then
    try
      Instance:= TForm(InstanceClass.NewInstance);
      TForm(Reference):= Instance;

      try
        Instance.Create(MainForm);

        if (Instance as TForm).FormStyle = fsNormal then begin
          (Instance as TForm).FormStyle:= fsMdiChild;
          (Instance as TForm).Visible:= True;
        end;
      except
        TForm(Reference):= nil;
        Instance.Free;
        raise;
      end;

    finally
      Screen.Cursor:= crDefault;
    end
  else
    with TForm(Reference) do begin
      if WindowState = wsMinimized then
        WindowState:= wsNormal;

      BringToFront();
      Screen.Cursor:= crDefault;
      SetFocus();
    end;

  LockWindowUpdate(0);
end;

procedure TfrmMain.Button_TesteClick(Sender: TObject);
var
  C                 : Longint;
  dados, St         : String;
  Lista             : TStringlist;

  id, di, nome, celular, email, username, password : String;

begin

  Lista:= Nil;

  Try
    Lista:= TStringlist.Create;

    dados:= frmConexaoAPI_V.Execute(taProfissional_Lista, 'Processando. Aguarde!');

    Lista.Text:= Uteis.ReturnValor_EmJSON(dados, 'data');

    if lista.Count = 0 then begin
      Memo_Teste.Lines.Text:= 'Nenhum profissional encontrado';
      exit;
    end;

    for C:= 0 to lista.Count - 1 do begin
      St:= lista.Strings[C];

      id:= Uteis.ReturnValor_EmJSON(St, 'id');
      di:= Uteis.ReturnValor_EmJSON(St, 'di');
      nome:= Uteis.ReturnValor_EmJSON(St, 'nome');
      celular:= Uteis.ReturnValor_EmJSON(St, 'celular');
      email:= Uteis.ReturnValor_EmJSON(St, 'email');
      username:= Uteis.ReturnValor_EmJSON(St, 'username');
      password:= Uteis.ReturnValor_EmJSON(St, 'password');

      Memo_Teste.Lines.Add('PROFISSIONAL ' + IntToStr(c + 1) + ':');
      Memo_Teste.Lines.Add('  id: ' + id);
      Memo_Teste.Lines.Add('  di: ' + di);
      Memo_Teste.Lines.Add('  nome: ' + nome);
      Memo_Teste.Lines.Add('  celular: ' + celular);
      Memo_Teste.Lines.Add('  email: ' + email);
      Memo_Teste.Lines.Add('  username: ' + username);
      Memo_Teste.Lines.Add('  password: ' + password);
      Memo_Teste.Lines.Add('');
    end;

  Finally
    Lista.Free();
  End;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  FDefaultStyleName:= '';
  if Assigned(TStyleManager.ActiveStyle) then
    FDefaultStyleName:= TStyleManager.ActiveStyle.Name;

end;

procedure TfrmMain.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.Timer_loginTimer(Sender: TObject);
var
  resultLogin                             : TModalResult;

begin

  Timer_login.Enabled:= false;

  if not Uteis.temConexaoDeInternet() then begin
    uteis.SayError('Não foi encontrado conexão com internet. Verifique');
    Application.Terminate;
  end;

  resultLogin:= frmLogin.Execute();

  if resultLogin = mrAbort then
    Application.Terminate;

end;

procedure TfrmMain.SetDefaultStyleName(styleNam: String);
var
  I                                                      : integer;

begin

  try
    FDefaultStyleName:= '';

    if NOT Assigned(TStyleManager.ActiveStyle) then
      exit;

    TStyleManager.TrySetStyle(styleNam);

    FDefaultStyleName:= TStyleManager.ActiveStyle.Name;
  except
    TStyleManager.TrySetStyle(FDefaultStyleName);
  end;

  if Self.DefaultStyleName = '' then
    exit;

//  CalendarView.StyleName:= Self.DefaultStyleName;

//  with Application do begin
//   for I:= 0 to ComponentCount - 1 do
//     if IsPublishedProp(TControl(components[i]), 'StyleName') then Begin
//       TControl(components[i]).StyleName:= Self.DefaultStyleName;
//       TControl(components[i]).Repaint;
//     End;
//  end;

end;

procedure TfrmMain.Windows1Click(Sender: TObject);
begin
  Self.defaultStyleName:= 'Windows10';
end;

procedure TfrmMain.WindowsDark1Click(Sender: TObject);
begin
  Self.defaultStyleName:= 'Windows10 Dark';
end;

end.
