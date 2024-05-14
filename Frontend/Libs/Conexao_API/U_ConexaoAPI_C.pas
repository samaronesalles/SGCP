unit U_ConexaoAPI_C;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, U_MeusTipos, U_ConexaoAPI_M;

type
  TConexaoAPI_C = class(TObject)
  private
    FAcao                                                : TTipoAcaoAPI;
    FEndpoint                                            : String;
    FMethod                                              : String;
    FRequisicao                                          : String;
  public
    constructor Create(Acao: TTipoAcaoAPI; Endpoint, MetodoHttp, Requisicao: String);
    destructor Destroy; override;

    function processar: TConexaoAPI_M;
  End;

implementation

uses Uteis, U_Thr_API,
     U_Profissional_C;

{ TConexaoAPI_C }

constructor TConexaoAPI_C.Create(Acao: TTipoAcaoAPI; Endpoint, MetodoHttp, Requisicao: String);
begin
  Self.FAcao:= Acao;
  Self.FEndpoint:= Endpoint;
  Self.FMethod:= MetodoHttp;
  Self.FRequisicao:= Requisicao;
end;

destructor TConexaoAPI_C.Destroy;
begin
  inherited;
end;

function TConexaoAPI_C.processar: TConexaoAPI_M;
var
  Thr_API                                            : TThr_API;

begin

  Result:= TConexaoAPI_M.Create();  // Não pode ser morta aqui...

  Thr_API:= Nil;

  If Self.FAcao = taNenhuma Then
    Exit;

  Try
    Thr_API:= TThr_API.Create(TRUE);

    Thr_API.Method:= Self.FMethod;
    Thr_API.Endpoint:= Self.FEndpoint;
    Thr_API.Requisicao:= Self.FRequisicao;

    Thr_API.Retorno:= Nil;

// Algum processamento específico para cada ação...
//    case Self.FAcao of
//      taProfissional_Lista:
//    end;

    Thr_API.Resume();

    Repeat
      Uteis.bSleep(500);
    Until Thr_API.Retorno <> Nil;

    Result:= Thr_API.Retorno;

  Finally
    Thr_API.Free();
  End;

end;

end.
