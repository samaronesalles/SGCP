unit U_Agenda_M;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  U_Profissional_M, U_Paciente_M, U_ObjectList;

type
  TAgenda_M = class(TObject)
  private
    FId                                                                         : Longint;
    FDi                                                                         : String;
    FDescricao                                                                  : String;
    FObservacao                                                                 : String;
    FEvento_inicio                                                              : TDateTime;
    FEvento_fim                                                                 : TDateTime;
    FEvento_confirmado                                                          : Boolean;
    FAtivo                                                                      : Boolean;
    FProfissional                                                               : TProfissional_M;
    FPaciente                                                                   : TPaciente_M;
  public
    property Id                                                                 : Longint Read FId Write FId;
    property Di                                                                 : String Read FDi Write FDi;
    property Descricao                                                          : String Read FDescricao Write FDescricao;
    property Observacao                                                         : String Read FObservacao Write FObservacao;
    property Evento_inicio                                                      : TDateTime Read FEvento_inicio Write FEvento_inicio;
    property Evento_fim                                                         : TDateTime Read FEvento_fim Write FEvento_fim;
    property Evento_confirmado                                                  : Boolean Read FEvento_confirmado Write FEvento_confirmado;
    property Ativo                                                              : Boolean Read FAtivo Write FAtivo;
    property Profissional                                                       : TProfissional_M Read FProfissional Write FProfissional;
    property Paciente                                                           : TPaciente_M Read FPaciente Write FPaciente;

    constructor Create;
    destructor Destroy; override;

    function Save: Boolean;
    function CancelarAtendamento: Boolean;

    function ToJSON: String;
    class function ToObject(const JSON: String): TAgenda_M;
  End;

implementation

uses Uteis, U_ConexaoAPI_M, U_ConexaoAPI_V;

{ TAtendimento_M }

function TAgenda_M.CancelarAtendamento: Boolean;
begin
  Result:= TRUE;
  Uteis.SayInfo('Em desenvolvimento: TAgenda_M.CancelarAtendamento()');
end;

constructor TAgenda_M.Create;
begin
  Self.FId:= 0;
  Self.FDi:= '';
  Self.FDescricao:= '';
  Self.FObservacao:= '';
  Self.FEvento_inicio:= 0;
  Self.FEvento_fim:= 0;
  Self.FEvento_confirmado:= FALSE;
  Self.FAtivo:= FALSE;
  Self.FProfissional:= Nil;
  Self.FPaciente:= Nil;
end;

destructor TAgenda_M.Destroy;
begin
  inherited;

  Self.FProfissional.Free();
  Self.FPaciente.Free();
end;

function TAgenda_M.Save: Boolean;
begin
  // Código aqui...
end;

function TAgenda_M.ToJSON: String;
begin
  Result:= '{' +
               '"id": ' + IntToStr(Self.FId) + ',' +
               '"di": ' + Uteis.ConverteTextoToJson(Self.FDi) + ',' +
               '"descricao": ' + Uteis.ConverteTextoToJson(Self.FDescricao) + ',' +
               '"observacao": ' + Uteis.ConverteTextoToJson(Self.FObservacao) + ',' +
               '"evento_inicio": ' + Uteis.ConverteTextoToJson(Uteis.DateTime2Str_UTC(Self.FEvento_inicio)) + ',' +
               '"evento_fim": ' + Uteis.ConverteTextoToJson(Uteis.DateTime2Str_UTC(Self.FEvento_fim)) + ',' +
               '"evento_confirmado": ' + Uteis.ConverteBooleanToJson(Self.FEvento_confirmado) + ',' +
               '"ativo": ' + Uteis.ConverteBooleanToJson(Self.FAtivo) + ',' +
               '"profissional": ' + Self.FProfissional.ToJSON() + ',' +
               '"paciente": ' + Self.FPaciente.ToJSON() +
           '}';
end;

class function TAgenda_M.ToObject(const JSON: String): TAgenda_M;
var
  Retorno                                            : TAgenda_M;
  DH_ini, DH_fim                                     : String;

begin

  Retorno:= Nil;

  Try
    DH_ini:= Uteis.ReturnValor_EmJSON(JSON, 'evento_inicio');
    DH_fim:= Uteis.ReturnValor_EmJSON(JSON, 'evento_fim');

    Retorno:= TAgenda_M.Create;

    Retorno.Id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'id'));
    Retorno.Di:= Uteis.ReturnValor_EmJSON(JSON, 'di');
    Retorno.Descricao:= Uteis.ReturnValor_EmJSON(JSON, 'descricao');
    Retorno.Observacao:= Uteis.ReturnValor_EmJSON(JSON, 'observacao');
    Retorno.Evento_inicio:= Uteis.DateTimeUTC2TDatetime(DH_ini);
    Retorno.Evento_fim:= Uteis.DateTimeUTC2TDatetime(DH_fim);
    Retorno.Evento_confirmado:= Uteis.CharToBoolean(Uteis.ReturnValor_EmJSON(JSON, 'evento_confirmado'));
    Retorno.Ativo:= Uteis.CharToBoolean(Uteis.ReturnValor_EmJSON(JSON, 'ativo'));
    Retorno.Profissional:= TProfissional_M.ToObject(Uteis.ReturnValor_EmJSON(JSON, 'profissional'));
    Retorno.Paciente:= TPaciente_M.ToObject(Uteis.ReturnValor_EmJSON(JSON, 'paciente'));

    Result:= Retorno;
  Except
    Retorno.Free();
    Result:= Nil;
  End;

end;

end.
