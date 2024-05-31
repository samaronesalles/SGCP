unit U_frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.Themes, U_RSA,
  Vcl.ExtCtrls, Vcl.WinXCalendars, System.TypInfo, Vcl.StdCtrls, U_Profissional_M;

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
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Windows1Click(Sender: TObject);
    procedure WindowsDark1Click(Sender: TObject);
    procedure Timer_loginTimer(Sender: TObject);
    procedure erapeutas1Click(Sender: TObject);
    procedure Pacientes1Click(Sender: TObject);
    procedure Atendimentos1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Agendamentos1Click(Sender: TObject);
  private
    { Private declarations }

    FMainDir                                            : String;
    FTempDir                                            : String;

    FRSA_PublicKey                                      : String;
    FRSA_PrivateKey                                     : String;

    FDefaultStyleName                                   : String;
    FProfissionalLogado                                 : TProfissional_M;

    procedure SetDefaultStyleName(styleNam: String);

    function  IsChildFormExist(InstanceClass: TFormClass): Boolean;
    procedure ShowChild(MainForm : TForm; InstanceClass: TFormClass; var Reference);

    procedure CriaDiretorios;
  public
    { Public declarations }

    BufferStr                                           : String;

    property MainDir                                    : String Read FMainDir;
    property TempDir                                    : String Read FTempDir;
    property RSA_PublicKey                              : String Read FRSA_PublicKey;
    property RSA_PrivateKey                             : String Read FRSA_PrivateKey;

    property DefaultStyleName                           : String Read FdefaultStyleName Write SetDefaultStyleName;
    property ProfissionalLogado                         : TProfissional_M Read FProfissionalLogado Write FProfissionalLogado;
  end;

var
  frmMain: TfrmMain;

implementation

uses U_frmLogin, Uteis, U_Agenda_V, U_Profissional_V, U_Paciente_V, U_Atendimento_V;

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

procedure TfrmMain.Pacientes1Click(Sender: TObject);
begin
  ShowChild(Self, TfrmPacientes_V, frmPacientes_V);
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

procedure TfrmMain.Agendamentos1Click(Sender: TObject);
begin
  ShowChild(Self, TfrmAgenda_V, frmAgenda_V);
end;

procedure TfrmMain.Atendimentos1Click(Sender: TObject);
begin
  ShowChild(Self, TfrmAtendimentos_V, frmAtendimentos_V);
end;

procedure TfrmMain.CriaDiretorios;
begin

  if not DirectoryExists(Self.FTempDir) then
    MkDir(Self.FTempDir);

end;

procedure TfrmMain.erapeutas1Click(Sender: TObject);
begin
  ShowChild(Self, TfrmProfissionais_V, frmProfissionais_V);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  FDefaultStyleName:= '';
  if Assigned(TStyleManager.ActiveStyle) then
    FDefaultStyleName:= TStyleManager.ActiveStyle.Name;

  Self.FRSA_PublicKey:= 'MTc6MTQ2NDc=';
  Self.FRSA_PrivateKey:= 'MTM1NTM6MTQ2NDc=';

  Self.FMainDir:= ExtractFilePath(ParamStr(0));
  Self.FTempDir:= Self.FMainDir + 'TEMP\';

  Self.FProfissionalLogado:= Nil;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin

//  if Uteis.MicroDesenv_Temporario() then
//    Button_Teste.Visible:= TRUE;

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

  CriaDiretorios();

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
