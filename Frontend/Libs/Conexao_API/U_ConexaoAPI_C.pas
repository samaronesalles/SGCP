unit U_ConexaoAPI_C;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, U_ConexaoAPI_M;

type
  TConexaoAPI_C = class(TObject)
  private
    FAcao                                                : TTipoAcaoAPI;
  public
    constructor Create(Acao: TTipoAcaoAPI);
    destructor Destroy; override;

    function processar: TConexaoAPI_M;
  End;

implementation

uses Uteis, U_Thr_API,
     U_Profissional_C;

{ TConexaoAPI_C }

constructor TConexaoAPI_C.Create(Acao: TTipoAcaoAPI);
begin
  Self.FAcao:= Acao;
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
    Thr_API.Retorno:= Nil;

    case Self.FAcao of
      taProfissional_Lista: Begin
        Thr_API.Method:= 'GET';
        Thr_API.Endpoint:= Endpoint_Profissionais_Lista;
        Thr_API.Requisicao:= '';
      End;
    end;

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
