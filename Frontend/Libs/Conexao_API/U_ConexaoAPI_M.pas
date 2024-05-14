unit U_ConexaoAPI_M;

interface

uses
  System.SysUtils, System.Classes;

type
  TConexaoAPI_M = class(TObject)
  private
    FStatusCode                                                                 : Longint;
    FErro                                                                       : Boolean;
    FData                                                                       : String;
  public
    property StatusCode                                                         : Longint Read FStatusCode Write FStatusCode;
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

  Self.FStatusCode:= 0;
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
               '"statusCode": ' + IntToStr(Self.FStatusCode) + ',' +
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

    Retorno.StatusCode:= Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'statusCode'));
    Retorno.Erro:= Uteis.CharToBoolean(Uteis.ReturnValor_EmJSON(JSON, 'erro'));
    Retorno.Data:= Uteis.ReturnValor_EmJSON(JSON, 'data');

    Result:= Retorno;

  Finally
  End;

end;

end.
