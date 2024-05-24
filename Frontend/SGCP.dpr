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
  U_ObjectList in 'Libs\U_ObjectList.pas',
  U_Profissional_V in 'Libs\Profissional\U_Profissional_V.pas' {frmProfissionais_V},
  U_frmTemplateForm_Detail in 'U_frmTemplateForm_Detail.pas' {frmTemplateForm_Detail},
  U_ProfissionalDetail_V in 'Libs\Profissional\U_ProfissionalDetail_V.pas' {frmProfissionalDetail_V},
  U_ExceptionTratado in 'Libs\U_ExceptionTratado.pas',
  U_Paciente_M in 'Libs\Paciente\U_Paciente_M.pas',
  U_Paciente_V in 'Libs\Paciente\U_Paciente_V.pas' {frmPacientes_V},
  U_PacienteDetail_V in 'Libs\Paciente\U_PacienteDetail_V.pas' {frmPacienteDetail_V},
  U_Atendimento_V in 'Libs\Atendimento\U_Atendimento_V.pas' {frmAtendimentos_V},
  U_Atendimento_M in 'Libs\Atendimento\U_Atendimento_M.pas',
  U_Agenda_M in 'Libs\Agenda\U_Agenda_M.pas',
  U_frmTemplateForm_Filtro in 'U_frmTemplateForm_Filtro.pas' {frmTemplateForm_Filtro},
  U_AtendimentoFiltro_V in 'Libs\Atendimento\U_AtendimentoFiltro_V.pas' {frmAtendimentoFiltro_V},
  U_frmTemplateForm_DropList in 'U_frmTemplateForm_DropList.pas' {frmTemplateForm_DropList},
  U_ProfissionalDropList_V in 'Libs\Profissional\U_ProfissionalDropList_V.pas' {frmProfissionalDropList_V};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SGCP - Sistema Gerencial de Consultórios Psi';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
