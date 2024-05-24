unit U_MeusTipos;

interface

uses
  System.SysUtils, System.Classes;

type
  TStatusAtendimentos = (
    saTodos,                         // 0: Todos
    saPendenteConfirmacao,           // 1: Pendente de confirmação
    saCancelado,                     // 2: Canceladas
    saConfirmadoNaoRealizado,        // 3: Confirmada não realizada
    saRealizado                      // 4: Realizada
  );

function  StatusAtendimento2Int (Status: TStatusAtendimentos): Longint;
function  StatusAtendimento2Str (Status: TStatusAtendimentos): String;
function  Int2StatusAtendimento (Status: Longint): TStatusAtendimentos;

implementation

uses Uteis;

function StatusAtendimento2Int (Status: TStatusAtendimentos): Longint;
begin
  case Status of
    saTodos: Result:= 0;
    saPendenteConfirmacao: Result:= 1;
    saCancelado: Result:= 2;
    saConfirmadoNaoRealizado: Result:= 3;
    saRealizado: Result:= 4;
  end;
end;

function  StatusAtendimento2Str (Status: TStatusAtendimentos): String;
begin
  case Status of
    saTodos: Result:= 'Todos';
    saPendenteConfirmacao: Result:= 'Pendente de confirmação';
    saCancelado: Result:= 'Cancelado';
    saConfirmadoNaoRealizado: Result:= 'Confirmado não realizado';
    saRealizado: Result:= 'Realizado';
  end;
end;

function Int2StatusAtendimento (Status: Longint): TStatusAtendimentos;
begin
  case Status of
    0: Result:= saTodos;
    1: Result:= saPendenteConfirmacao;
    2: Result:= saCancelado;
    3: Result:= saConfirmadoNaoRealizado;
    4: Result:= saRealizado;
  end;
end;


end.

