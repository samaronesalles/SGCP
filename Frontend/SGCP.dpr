program SGCP;

uses
  Vcl.Forms,
  U_frmMain in 'U_frmMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  U_frmLogin in 'U_frmLogin.pas' {frmLogin},
  U_frmTemplateForm_Main in 'U_frmTemplateForm_Main.pas' {frmTemplateForm_Main},
  Uteis in 'Uteis.pas',
  U_ConexaoAPI_V in 'Libs\Conexao_API\U_ConexaoAPI_V.pas' {frmConexaoAPI_V},
  U_Thr_API in 'Libs\Conexao_API\U_Thr_API.pas',
  U_ConexaoAPI_M in 'Libs\Conexao_API\U_ConexaoAPI_M.pas',
  U_ConexaoAPI_C in 'Libs\Conexao_API\U_ConexaoAPI_C.pas',
  U_Profissional_M in 'Libs\Profissional\U_Profissional_M.pas',
  U_Profissional_C in 'Libs\Profissional\U_Profissional_C.pas',
  U_ObjectList in 'Libs\U_ObjectList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SGCP - Sistema Gerencial de Consultórios Psi';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
