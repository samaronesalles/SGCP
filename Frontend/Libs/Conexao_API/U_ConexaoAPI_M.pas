unit U_ConexaoAPI_M;

interface

uses
  System.SysUtils, System.Classes;

type
  TConexaoAPI_M = class(TObject)
  private
    FStatusCode_HTTP                                                            : Longint;
    FStatusCode_Interno                                                         : Longint;
    FErro                                                                       : Boolean;
    FData                                                                       : String;
  public
    property StatusCode_HTTP                                                    : Longint Read FStatusCode_HTTP Write FStatusCode_HTTP;
    property StatusCode_Interno                                                 : Longint Read FStatusCode_Interno Write FStatusCode_Interno;
    property Erro                                                               : Boolean Read FErro Write FErro;
    property Data                                                               : String Read FData Write FData;

    constructor Create;
    destructor Destroy; override;

    function ToJSON: String;
    class function ToObject(JSON: String): TConexaoAPI_M;
  End;

implementation

uses Uteis;

constructor TConexaoAPI_M.Create;
begin

  Self.FStatusCode_HTTP:= 0;
  Self.FStatusCode_Interno:= 0;
  Self.FErro:= FALSE;
  Self.FData:= '';

end;

destructor TConexaoAPI_M.Destroy;
begin
  Inherited;
end;

function TConexaoAPI_M.ToJSON: String;
begin

  Result:= '{' +
               '"statusCode_http": ' + IntToStr(Self.FStatusCode_HTTP) + ',' +
               '"statusCode_interno": ' + IntToStr(Self.FStatusCode_Interno) + ',' +
               '"erro": ' + Uteis.ConverteBooleanToJson(Self.FErro) + ',' +
               '"data": ' + Uteis.ConverteTextoToJson(Self.FData) +
           '}';

end;

class function TConexaoAPI_M.ToObject(JSON: String): TConexaoAPI_M;
var
  Retorno                                            : TConexaoAPI_M;

begin

  Retorno:= Nil;

  Try
    Retorno:= TConexaoAPI_M.Create;

    Retorno.StatusCode_HTTP:= Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'statusCode_http'));
    Retorno.StatusCode_Interno:= Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'statusCode_interno'));
    Retorno.Erro:= Uteis.CharToBoolean(Uteis.ReturnValor_EmJSON(JSON, 'erro'));
    Retorno.Data:= Uteis.ReturnValor_EmJSON(JSON, 'data');

    Result:= Retorno;

  Finally
  End;

end;

end.

