unit U_AtendimentoDetail_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Detail, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, ExtDlgs, Vcl.ExtCtrls, U_Atendimento_M, Vcl.ComCtrls, Vcl.printers, Vcl.ToolWin,
  Richedit, U_MeusTipos;

type
  TfrmAtendimentoDetail_V = class(TfrmTemplateForm_Detail)
    PanelBotoesTop: TPanel;
    ButtonAplicarTestePHQ: TButton;
    ButtonEncerrarAtendimento: TButton;
    ButtonImprimirAtendimento: TButton;
    PanelBotoesDir: TPanel;
    ButtonSalvar: TButton;
    ButtonSair: TButton;
    PanelEditor: TPanel;
    Label1: TLabel;
    FindDialog1: TFindDialog;
    ReplaceDialog1: TReplaceDialog;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    ImageListTollBar: TImageList;
    ToolBarTextEditor: TToolBar;
    ComboBox2: TComboBox;
    ToolButton7: TToolButton;
    ToolButton12: TToolButton;
    ToolButton16: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    RichEdit_Texto: TRichEdit;
    Label_di: TLabel;
    ButtonImprimirProntuario: TButton;
    PanelBtnsTopRight: TPanel;
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonProsseguirClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ButtonImprimirAtendimentoClick(Sender: TObject);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RichEdit_TextoClick(Sender: TObject);
    procedure RichEdit_TextoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonAplicarTestePHQClick(Sender: TObject);
    procedure ButtonEncerrarAtendimentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonImprimirProntuarioClick(Sender: TObject);
  private
    { Private declarations }

    FGLB_Atendimento_M                           : TAtendimento_M;
    FJson_BkpAtendimentoEditado                  : String;

    procedure setBtnsToolbar_byCurrText;
    procedure setAtendimentoSomenteLeituraOuNao(SomenteLeitura: Boolean);
  public
    { Public declarations }

    property GLB_Atendimento_M                   : TAtendimento_M Read FGLB_Atendimento_M Write FGLB_Atendimento_M;

    function Execute (VAR Atendimento: TAtendimento_M): Boolean;
  end;

var
  frmAtendimentoDetail_V: TfrmAtendimentoDetail_V;

const
  FILE_ANOTACOES_RTF = 'Anotacao_temp.rtf';

implementation

uses U_frmMain, Uteis, U_ExceptionTratado, U_Prontuario_C;

{$R *.dfm}

procedure TfrmAtendimentoDetail_V.ButtonAplicarTestePHQClick(Sender: TObject);
begin
  inherited;

  Uteis.SayInfo('Em desenvolvimento');
end;

procedure TfrmAtendimentoDetail_V.ButtonEncerrarAtendimentoClick(Sender: TObject);
var
  Encerrado                          : Boolean;

begin

  Try
    Try
      Encerrado:= FALSE;

      ButtonSalvar.Enabled:= FALSE;
      ButtonSair.Enabled:= FALSE;

      if Uteis.SayQuestion('Encerrar atendimento', 'Deseja realmente encerrar este atendimento?' + #13#13 +
                           'ATENÇÃO: Se confirmar, este atendimento NÃO poderá mais ser alterado.', TMsgDlgType.mtConfirmation, mbYesNo, mrNo, 0) <> mrYes then
        Exit;

      if NOT Self.FGLB_Atendimento_M.Encerrar() Then
        Exit;

      Self.FGLB_Atendimento_M.Status:= saRealizado;
      Self.Label_di.Caption:= Self.FGLB_Atendimento_M.Di;

      frmMain.BufferStr:= Self.FGLB_Atendimento_M.ToJSON(FALSE);

      if Self.FGLB_Atendimento_M.DataHoraFim > 0 then begin
        Uteis.SayInfo('Atendimento encerrado som sucesso.' + #13#13 +
                      'ATENÇÃO: Agora o mesmo estará disponível apenas para leitura.');

        Encerrado:= TRUE;
        Exit;
      end;

    Except
      ModalResult:= mrAbort;
    End;
  Finally
    ButtonSalvar.Enabled:= TRUE;
    ButtonSair.Enabled:= TRUE;

    setAtendimentoSomenteLeituraOuNao(Encerrado);
  End;

end;

procedure TfrmAtendimentoDetail_V.ButtonImprimirProntuarioClick(Sender: TObject);
var
  Prontuario_C                        : TProntuario_C;

begin

  Prontuario_C:= Nil;

  try
    Prontuario_C:= TProntuario_C.Create(Self.FGLB_Atendimento_M.Agenda.Paciente.Id);

    Prontuario_C.printHistorico();
  finally
    Prontuario_C.Free();
  end;

end;

procedure TfrmAtendimentoDetail_V.ButtonImprimirAtendimentoClick(Sender: TObject);
var
  FileNameTemp                                         : String;

begin

  FileNameTemp:= 'Rel_Atendimento' + ' ' + 'id=' + IntToStr(Self.FGLB_Atendimento_M.Id) + ' ' + 'di=' + Trim(Self.FGLB_Atendimento_M.Di) + '.RTF';

  Try
    Try
      if FileExists (frmMain.TempDir + FileNameTemp) then
        DeleteFile(frmMain.TempDir + FileNameTemp);

      if NOT RichEdit_SaveToFile (frmMain.TempDir + FileNameTemp, RichEdit_Texto) then
        raise Exception.Create('');

      Uteis.AbrirArquivoRFT_WORD(frmMain.TempDir + FileNameTemp);
    Except
      On E: Exception Do begin
        if (E is ExceptionTratado) then
          Uteis.SayError(E.Message)
        else
          Uteis.SayError('Ocorreu algum erro ao imprimir o atendimento. Caso o relatório esteja aberto, feche-o e tente novamente.');
      end;
    End;
  Finally
  End;

end;

procedure TfrmAtendimentoDetail_V.ButtonCancelarClick(Sender: TObject);
begin
  // BOTÃO NÃO DEVE SER UTILIZADO...
end;

procedure TfrmAtendimentoDetail_V.ButtonProsseguirClick(Sender: TObject);
begin
  // BOTÃO NÃO DEVE SER UTILIZADO...
end;

procedure TfrmAtendimentoDetail_V.ButtonSairClick(Sender: TObject);
begin
  inherited;

  if NOT ButtonSair.Enabled then
    Exit;

  ModalResult:= mrCancel;

end;

procedure TfrmAtendimentoDetail_V.ButtonSalvarClick(Sender: TObject);
begin

  if NOT ButtonSalvar.Enabled then
    Exit;

  Try
    Try
      ButtonSalvar.Enabled:= FALSE;
      ButtonSair.Enabled:= FALSE;

      Self.FGLB_Atendimento_M.Anotacoes:= Uteis.RichEdit_GetText(frmMain.TempDir + FILE_ANOTACOES_RTF, RichEdit_Texto);

      If Self.FJson_BkpAtendimentoEditado = Self.FGLB_Atendimento_M.ToJSON(FALSE) Then
        ModalResult:= mrCancel;

      if NOT Self.FGLB_Atendimento_M.Save() Then
        Exit;

      Self.Label_di.Caption:= Self.FGLB_Atendimento_M.Di;

      frmMain.BufferStr:= Self.FGLB_Atendimento_M.ToJSON(FALSE);

      ModalResult:= mrOk;
    Except
      ModalResult:= mrAbort;
    End;
  Finally
    ButtonSalvar.Enabled:= TRUE;
    ButtonSair.Enabled:= TRUE;
  End;

end;

procedure TfrmAtendimentoDetail_V.ComboBox2Click(Sender: TObject);
begin
  inherited;
  RichEdit_Texto.SelAttributes.Size:= StrToint(combobox2.Text);
end;

procedure TfrmAtendimentoDetail_V.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
  If not (Key in ['0'..'9', #8, #0]) then
    Key:= #0;
end;

function TfrmAtendimentoDetail_V.Execute (VAR Atendimento: TAtendimento_M): Boolean;
var
  ResultadoModal                            : TModalResult;

begin

  Try
    Try
      Result:= FALSE;

      if Atendimento = Nil then
        Exit;

      if Atendimento.Id <= 0 then
        Exit;

      if frmAtendimentoDetail_V = Nil then
        frmAtendimentoDetail_V:= TfrmAtendimentoDetail_V.Create(Self);

      frmAtendimentoDetail_V.GLB_Atendimento_M:= Atendimento;
      frmAtendimentoDetail_V.Label_di.Caption:= Atendimento.Di;

      Uteis.RichEdit_SetText(Atendimento.Anotacoes, frmAtendimentoDetail_V.RichEdit_Texto);

      frmAtendimentoDetail_V.FJson_BkpAtendimentoEditado:= Atendimento.ToJSON(FALSE);

      ResultadoModal:= frmAtendimentoDetail_V.ShowModal;

      if ResultadoModal = mrCancel then begin
        Result:= TRUE;
        Exit;
      end;

      if ResultadoModal <> mrOk then
        Exit;

      Atendimento.Free();
      Atendimento:= TAtendimento_M.ToObject(frmMain.BufferStr);

      Result:= TRUE;
    Except
      Atendimento.Free();
      Result:= FALSE;
    End;
  Finally
    frmAtendimentoDetail_V.Free();
  End;

end;

procedure TfrmAtendimentoDetail_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmAtendimentoDetail_V:= Nil;
  Action:= caFree;
end;

procedure TfrmAtendimentoDetail_V.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  if NOT ButtonSair.Enabled then begin
    CanClose:= FALSE;
    exit;
  end;

  inherited;

end;

procedure TfrmAtendimentoDetail_V.FormCreate(Sender: TObject);
begin
  inherited;

  Self.FGLB_Atendimento_M:= Nil;
  Self.Label_di.Caption:= '';

  Self.FJson_BkpAtendimentoEditado:= '';

  if Uteis.MicroDesenv_Temporario() then begin
    Self.Label_di.Visible:= TRUE;
  end;

end;

procedure TfrmAtendimentoDetail_V.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #27 then begin
    Key:= #0;
    ButtonCancelar.OnClick(Self);
  end;

end;

procedure TfrmAtendimentoDetail_V.setAtendimentoSomenteLeituraOuNao(SomenteLeitura: Boolean);
begin
  ButtonAplicarTestePHQ.Enabled:= (NOT SomenteLeitura);
  ButtonEncerrarAtendimento.Enabled:= (NOT SomenteLeitura);
  ButtonImprimirProntuario.Enabled:= (NOT SomenteLeitura);
  ToolBarTextEditor.Enabled:= (NOT SomenteLeitura);
  RichEdit_Texto.ReadOnly:= SomenteLeitura;
  ButtonSalvar.Enabled:= (NOT SomenteLeitura);
end;

procedure TfrmAtendimentoDetail_V.FormShow(Sender: TObject);
begin
  inherited;

  setAtendimentoSomenteLeituraOuNao(FALSE);

  if Self.FGLB_Atendimento_M = Nil then
    Exit;

  if Self.FGLB_Atendimento_M.DataHoraFim > 0 then begin
    Uteis.SayInfo('Este atendimento encontra-se encerrado, e será aberto apenas para leitura.');

    setAtendimentoSomenteLeituraOuNao(TRUE);
  end;

  RichEdit_Texto.SetFocus();

end;

procedure TfrmAtendimentoDetail_V.RichEdit_TextoClick(Sender: TObject);
begin
  inherited;
  setBtnsToolbar_byCurrText();
end;

procedure TfrmAtendimentoDetail_V.RichEdit_TextoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  setBtnsToolbar_byCurrText();
end;

procedure TfrmAtendimentoDetail_V.setBtnsToolbar_byCurrText;
begin

  // Reset
  combobox2.ItemIndex:= 0;

  ToolButton13.Down:= FALSE;
  ToolButton14.Down:= FALSE;
  ToolButton15.Down:= FALSE;

  ToolButton9.Down:= FALSE;
  ToolButton10.Down:= FALSE;
  ToolButton11.Down:= FALSE;

  if Trim(RichEdit_Texto.Text) = '' then
    Exit;

  // Font size
  combobox2.ItemIndex:= combobox2.Items.IndexOf(IntToStr(RichEdit_Texto.SelAttributes.Size));

  // Text align
  ToolButton13.Down:= RichEdit_Texto.Paragraph.Alignment = taLeftJustify;
  ToolButton14.Down:= RichEdit_Texto.Paragraph.Alignment = taCenter;
  ToolButton15.Down:= RichEdit_Texto.Paragraph.Alignment = taRightJustify;

  // Font style
  ToolButton9.Down:= fsbold in RichEdit_Texto.SelAttributes.Style;
  ToolButton10.Down:= fsitalic in RichEdit_Texto.SelAttributes.Style;
  ToolButton11.Down:= fsunderline in RichEdit_Texto.SelAttributes.Style;
end;

procedure TfrmAtendimentoDetail_V.ToolButton10Click(Sender: TObject);
begin
  inherited;

  if ToolButton10.Down then
    RichEdit_Texto.SelAttributes.Style:= RichEdit_Texto.SelAttributes.Style + [fsitalic]
  else
    RichEdit_Texto.SelAttributes.Style:= RichEdit_Texto.SelAttributes.Style - [fsitalic];

end;

procedure TfrmAtendimentoDetail_V.ToolButton11Click(Sender: TObject);
begin
  inherited;

  if ToolButton11.Down then
    RichEdit_Texto.SelAttributes.Style:= RichEdit_Texto.SelAttributes.Style + [fsunderline]
  else
    RichEdit_Texto.SelAttributes.Style:= RichEdit_Texto.SelAttributes.Style - [fsunderline];

end;

procedure TfrmAtendimentoDetail_V.ToolButton12Click(Sender: TObject);
begin
  inherited;
  ColorDialog1.Execute;
  RichEdit_Texto.SelAttributes.Color:= ColorDialog1.Color;
end;

procedure TfrmAtendimentoDetail_V.ToolButton13Click(Sender: TObject);
begin
  inherited;
  RichEdit_Texto.Paragraph.Alignment:= taLeftJustify;
end;

procedure TfrmAtendimentoDetail_V.ToolButton14Click(Sender: TObject);
begin
  inherited;
  RichEdit_Texto.Paragraph.Alignment:= taCenter;
end;

procedure TfrmAtendimentoDetail_V.ToolButton15Click(Sender: TObject);
begin
  inherited;
  RichEdit_Texto.Paragraph.Alignment:= taRightJustify;
end;

procedure TfrmAtendimentoDetail_V.ToolButton9Click(Sender: TObject);
begin
  inherited;

  if ToolButton9.Down then
    RichEdit_Texto.SelAttributes.Style:= RichEdit_Texto.SelAttributes.Style + [fsbold]
  else
    RichEdit_Texto.SelAttributes.Style:= RichEdit_Texto.SelAttributes.Style - [fsbold];

end;

end.

