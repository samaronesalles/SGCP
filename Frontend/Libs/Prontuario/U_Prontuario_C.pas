unit U_Prontuario_C;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  Vcl.ComCtrls, U_ObjectList, U_MeusTipos, U_Atendimento_M;

type
  TProntuario_C = class(TObject)
  private
    FPacienteId                                            : Longint;
    FAtendimentos                                          : TAtendimento_List_M;

    FTexto                                                 : TStringList;
    FRichEditProntuario                                    : TRichEdit;

    procedure printCabecalhoAtendimento(Atendimento: TAtendimento_M);
  public
    procedure printHistorico;

    constructor Create (idPaciente: Longint);
    destructor Destroy; override;
  End;

implementation

uses U_frmMain, Uteis, U_ExceptionTratado;

{ TProntuario_C }

constructor TProntuario_C.Create (idPaciente: Longint);
begin

  Self.FPacienteId:= idPaciente;
  Self.FAtendimentos:= TAtendimento_List_M.Create;

  Self.FTexto:= TStringList.Create();

  Self.FRichEditProntuario:= TRichEdit.Create(Nil);
  Self.FRichEditProntuario.Visible:= FALSE;
  Self.FRichEditProntuario.Parent:= frmMain;
  Self.FRichEditProntuario.Lines.Clear();

  Self.FAtendimentos.Status:= saRealizado;
  Self.FAtendimentos.InicioDe:= 0;
  Self.FAtendimentos.InicioAte:= 0;
  Self.FAtendimentos.ProfissionalID:= 0;
  Self.FAtendimentos.ProfissionalNome:= '';
  Self.FAtendimentos.PacienteID:= idPaciente;
  Self.FAtendimentos.PacienteNome:= '';

end;

destructor TProntuario_C.Destroy;
begin
  Self.FAtendimentos.Free();
  Self.FRichEditProntuario.Free();
  Self.FTexto.Free();

  inherited;
end;

procedure TProntuario_C.printCabecalhoAtendimento(Atendimento: TAtendimento_M);
var
  PrimeiroAtendimento                                      : Boolean;

begin

  if Atendimento = Nil then
    Exit;

  PrimeiroAtendimento:= Self.FTexto.Count = 0;

  Self.FTexto.Add(' ');

  Self.FTexto.Add('{\rtf1\ansi\ansicpg1252\deff0\nouicompat{\fonttbl{\f0\fnil\fcharset0 Arial;}}');
  Self.FTexto.Add('{\*\generator Riched20 10.0.22621}\viewkind4\uc1');

  if NOT PrimeiroAtendimento then
    Self.FTexto.Add('\pard\fs32\lang1046 ================================\par');

  Self.FTexto.Add('\ul\b Atendimento Cod.:\ulnone\b0  ' + FillLeft(5, Atendimento.Id) + ' - \ul\b Data:\ulnone\b0  ' + FormatDateTime('dd/mm/yyyy hh:nn', Atendimento.DataHoraIni) + '\par');
  Self.FTexto.Add('\ul\fs28 Profissional:\ulnone  ' + Atendimento.Agenda.Profissional.Nome + '\fs32\par');
  Self.FTexto.Add('---------------------------------------------------------\par');
  Self.FTexto.Add('\fs28\par');
  Self.FTexto.Add('}');

end;

procedure TProntuario_C.printHistorico;
var
  FileNameTemp                                         : String;
  Atendimento                                          : TAtendimento_M;
  FileStream                                           : TFileStream;
  MemoryStream                                         : TMemoryStream;

begin

  FileNameTemp:= frmMain.TempDir + 'Rel_Prontuario' + ' ' + 'PacienteId=' + IntToStr(Self.FPacienteId) + '.RTF';

  if Self.FAtendimentos = Nil then
    Exit;

  Self.FAtendimentos.RetornoLista();

  if Self.FAtendimentos.Count = 0 then
    raise ExceptionTratado.Create('Não foi encontrado nenhum atendimento encerrado para o paciente selecionado.');

  Self.FRichEditProntuario.Lines.Clear();

//  Self.printCabecalhoAtendimento(TAtendimento_M(Self.FAtendimentos[0]));

//  for Atendimento in Self.FAtendimentos do begin
//    Self.printCabecalhoAtendimento(Atendimento);
//
//    Self.FTexto.Text:= Self.FTexto.Text +
//                       Atendimento.Anotacoes;
//  end;

//  Uteis.RichEdit_SetText(Self.FTexto.GetText(), Self.FRichEditProntuario);

//  if Self.FRichEditProntuario.Lines.Count = 0 then
//    Exit;

  Try
    Try
      MemoryStream:= TMemoryStream.Create();

      if FileExists (FileNameTemp) then
        DeleteFile(FileNameTemp);

      Self.printCabecalhoAtendimento(TAtendimento_M(Self.FAtendimentos[0]));

      Self.FTexto.SaveToStream(MemoryStream);
      MemoryStream.Position:= 0;

      Self.FRichEditProntuario.Lines.LoadFromStream(MemoryStream);

      if Self.FRichEditProntuario.Lines.Count = 0 then
        Exit;

      FileStream:= TFileStream.Create(FileNameTemp, fmCreate);
      Self.FRichEditProntuario.Lines.SaveToStream(FileStream);

      Uteis.AbrirArquivoRFT_WORD(FileNameTemp);
    Except
      On E: Exception Do begin
        if (E is ExceptionTratado) then
          Uteis.SayError(E.Message)
        else
          Uteis.SayError('Ocorreu algum erro ao imprimir o prontuário. Caso o relatório esteja aberto, feche-o e tente novamente.');
      end;
    End;
  Finally
    FileStream.Free;
    MemoryStream.Free;
  End;

end;

//procedure Teste;
//var
//  RichEditTeste   : TRichEdit;
//  TextoTeste      : TStringlist;
//  FileStream      : TFileStream;
//  StringStream    : TStringStream;
//
//begin
//
//  Try
//    TextoTeste:= TStringlist.Create();
//    RichEditTeste:= TRichEdit.Create(Nil);
//
//    RichEditTeste:= TRichEdit.Create(Nil);
//    RichEditTeste.Visible:= FALSE;
//    RichEditTeste.Parent:= frmMain;   // Aqui, eu precisei adicionar um parent qualquer pois estava dando erro. "frmMain" é um formulário qualquer que possuo em minha aplicação.
//    RichEditTeste.Lines.Clear();
//
//    TextoTeste.Add('{\rtf1\ansi\ansicpg1252\deff0\nouicompat{\fonttbl{\f0\fnil\fcharset0 Arial;}}');
//    TextoTeste.Add('{\*\generator Riched20 10.0.22621}\viewkind4\uc1');
//    TextoTeste.Add('\pard\fs32\lang1046 ================================\par');
//    TextoTeste.Add('\ul\b Atendimento Cod.:\ulnone\b0  003 - \ul\b Data:\ulnone\b0  02/06/2024\par');
//    TextoTeste.Add('\ul\fs28 Profissional:\ulnone  Samarone Salles\fs32\par');
//    TextoTeste.Add('---------------------------------------------------------\par');
//    TextoTeste.Add('\fs28\par');
//    TextoTeste.Add('}');
//
//    StringStream:= TStringStream.Create(TextoTeste.Text);
//    FileStream:= TFileStream.Create('C:\Teste\MeuArquivo.RTF', fmCreate);
//
//    RichEditTeste.Lines.LoadFromStream(StringStream);
//    RichEditTeste.Lines.SaveToStream(FileStream);
//
//    AbrirArquivoRFT('C:\Teste\MeuArquivo.RTF');
//
//  Finally
//    FileStream.Free;
//    StringStream.Free;
//    TextoTeste.Free;
//    RichEditTeste.Free;
//  End;
//
//end;

end.
