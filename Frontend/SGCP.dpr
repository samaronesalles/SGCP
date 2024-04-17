program SGCP;

uses
  Vcl.Forms,
  U_frmMain in 'U_frmMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  U_frmLogin in 'U_frmLogin.pas' {frmLogin},
  U_frmTemplateForm_Main in 'U_frmTemplateForm_Main.pas' {frmTemplateForm_Main},
  U_frmUsuarios_Main in 'U_frmUsuarios_Main.pas' {frmUsuarios_Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SGCP - Sistema Gerencial de Consultórios Psi';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
