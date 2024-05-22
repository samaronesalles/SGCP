unit U_ConexaoAPI_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, U_ConexaoAPI_M;

type
  TfrmConexaoAPI_V = class(TForm)
    ProgressBar: TProgressBar;
    Label_mensagem: TLabel;
    TimerStartUp: TTimer;
    procedure TimerStartUpTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    FEndpoint                           : String;
    FMethod                             : String;
    FRequisicao                         : String;

  public
    { Public declarations }

    property Endpoint                   : String Write FEndpoint;
    property Method                     : String Write FMethod;
    property Requisicao                 : String Write FRequisicao;

    function Execute(Endpoint, Method, Requisicao, Mensagem: string): TConexaoAPI_M;
  end;

var
  frmConexaoAPI_V: TfrmConexaoAPI_V;

implementation

uses U_frmMain, Uteis, U_ExceptionTratado, U_ConexaoAPI_C;

{$R *.dfm}

{ TfrmConexaoAPI_V }

function TfrmConexaoAPI_V.Execute(Endpoint, Method, Requisicao, Mensagem: string): TConexaoAPI_M;
var
  BkpBufferStr                              : String;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;

    Try
      Result:= Nil;
      frmMain.BufferStr:= '';

      if frmConexaoAPI_V = Nil then
        frmConexaoAPI_V:= TfrmConexaoAPI_V.Create(Application);

      frmConexaoAPI_V.Endpoint:= Endpoint;
      frmConexaoAPI_V.Method:= Method;
      frmConexaoAPI_V.Requisicao:= Requisicao;

      frmConexaoAPI_V.Label_mensagem.Caption:= mensagem;

      frmConexaoAPI_V.ShowModal;

      Result:= TConexaoAPI_M.ToObject(frmMain.BufferStr);
    Except
      Result.Free();
      Result:= Nil;
    End;
  Finally
    frmMain.BufferStr:= BkpBufferStr;
  End;

end;

procedure TfrmConexaoAPI_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmConexaoAPI_V:= Nil;
  Action:= caFree;
end;

procedure TfrmConexaoAPI_V.FormCreate(Sender: TObject);
begin

  Self.FEndpoint:= '';
  Self.FMethod:= '';
  Self.FRequisicao:= '';

end;

procedure TfrmConexaoAPI_V.FormShow(Sender: TObject);
begin
  Self.TimerStartUp.Enabled:= TRUE;
end;

procedure TfrmConexaoAPI_V.TimerStartUpTimer(Sender: TObject);
var
  ConexaoAPI_C                                            : TConexaoAPI_C;
  Retorno                                                 : TConexaoAPI_M;

begin

  TimerStartUp.Enabled:= FALSE;

  ConexaoAPI_C:= Nil;
  Retorno:= Nil;

  frmMain.BufferStr:= '';

  Try
    Try
      If NOT Uteis.temConexaoDeInternet() Then Begin
        Uteis.SayError('Não foi encontrada conexão com internet. Verifique!');
        Exit;
      End;

      ConexaoAPI_C:= TConexaoAPI_C.Create(Self.FEndpoint, Self.FMethod, Self.FRequisicao);

      Retorno:= ConexaoAPI_C.processar();
      If Retorno = Nil Then
        raise Exception.Create('');

      if Retorno.Erro Then begin
        if Retorno.StatusCode_Interno > 0 Then
          raise ExceptionTratado.Create(Retorno.Data)
        else
          raise Exception.Create(Retorno.Data);
      end;

      frmMain.BufferStr:= Retorno.ToJSON();
    Except
      On E: Exception Do Begin
        frmMain.BufferStr:= '';

        if (E is ExceptionTratado) then
          Uteis.SayError(E.Message)
        else
          Uteis.SayError('Ocorreu um erro durante comunicação com a API. Entre em contato com o suporte');

      End;
    End;
  Finally
    ConexaoAPI_C.Free();
    Retorno.Free();

    ModalResult:= mrOk;
  End;

end;

end.
