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

    function endpoint_cancelamento(VAR MetodoHttp: String): String;
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

  TAgendas_List_M = class(TObjectList)
  private
    FFiltro_ProfissionalId                                                      : Longint;
    FFiltro_PacienteId                                                          : Longint;
    FFiltro_InicioDe                                                            : TDateTime;
    FFiltro_InicioAte                                                           : TDateTime;

    function endpoint_lista (var MetodoHttp: String): String;
  public
    constructor Create;

    function RetornoLista (ProfissionalId, PacienteId: Longint; InicioDe, InicioAte: TDateTime): Boolean;
    function FiltraLista (const ProfissionalId, PacienteId: Longint; InicioDe, InicioAte: TDate): TList<integer>;

    function ToJSON: String;

    class function toList (const JSON: String): TAgendas_List_M;
  end;

implementation

uses Uteis, U_ConexaoAPI_M, U_ConexaoAPI_V;

{ TAtendimento_M }

function TAgenda_M.CancelarAtendamento: Boolean;
var
  Endpoint, Metodo                     : String;
  RespostaAPI                          : TConexaoAPI_M;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;

  Try
    Try
      Endpoint:= Self.endpoint_cancelamento(Metodo);

      if Endpoint = '' then
        exit;

      RespostaAPI:= frmConexaoAPI_V.Execute(Endpoint, Metodo, '', 'Cancelando atendimento. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      Result:= TRUE;
    Except
    End;
  Finally
    RespostaAPI.Free();
  End;

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

function TAgenda_M.endpoint_cancelamento(var MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then
    Exit;

  St:= 'agenda/cancelar/[id]/[di]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));
  Uteis.Substitua(St, '[di]', Self.Fdi);

  MetodoHttp:= 'PUT';
  Result:= St;

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

{ TAgendas_List_M }

constructor TAgendas_List_M.Create;
begin
  Self.FFiltro_ProfissionalId:= 0;
  Self.FFiltro_PacienteId:= 0;
  Self.FFiltro_InicioDe:= 0;
  Self.FFiltro_InicioAte:= 0;
end;

function TAgendas_List_M.endpoint_lista(var MetodoHttp: String): String;
var
  St                                   : String;

begin
  MetodoHttp:= 'GET';

  St:= 'agenda/lista/[profissional_id]/[paciente_id]/[inicio_de]/[inicio_ate]';

  Uteis.Substitua(St, '[profissional_id]', IntToStr(Self.FFiltro_ProfissionalId));
  Uteis.Substitua(St, '[paciente_id]', IntToStr(Self.FFiltro_PacienteId));
  Uteis.Substitua(St, '[inicio_de]', Uteis.DateTime2Str_UTC(Self.FFiltro_InicioDe));
  Uteis.Substitua(St, '[inicio_ate]', Uteis.DateTime2Str_UTC(Self.FFiltro_InicioAte));

  Result:= St
end;

function TAgendas_List_M.FiltraLista (const ProfissionalId, PacienteId: Longint; InicioDe, InicioAte: TDate): TList<integer>;
var
  C                                                 : Integer;
  Agenda                                            : TAgenda_M;

begin

  try
    Result:= TList<integer>.Create;

    for Agenda in Self do begin
      if NOT Agenda.Ativo then
        Continue;

      if (ProfissionalId > 0) AND (Agenda.Profissional.Id <> ProfissionalId) then
        Continue;

      if (PacienteId > 0) AND (Agenda.Paciente.Id <> PacienteId) then
        Continue;

      if ((InicioDe > 0) AND (InicioAte > 0)) then begin
        if (Agenda.Evento_inicio < InicioDe) OR (Agenda.Evento_inicio > InicioAte) then
          Continue;
      end;

      Result.Add(Agenda.Id);
    end;

  except
    raise;
  end;

end;

function TAgendas_List_M.RetornoLista (ProfissionalId, PacienteId: Longint; InicioDe, InicioAte: TDateTime): Boolean;
var
  Endpoint, Metodo                     : String;
  RespostaAPI                          : TConexaoAPI_M;

  JsonLista                            : String;
  ListaAgendamentos                    : TAgendas_List_M;

  C                                    : Longint;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;

  JsonLista:= '';
  ListaAgendamentos:= Nil;

  Try
    Try
      Self.FFiltro_ProfissionalId:= ProfissionalId;
      Self.FFiltro_PacienteId:= PacienteId;
      Self.FFiltro_InicioDe:= InicioDe;
      Self.FFiltro_InicioAte:= InicioAte;

      Endpoint:= Self.endpoint_lista(Metodo);

      RespostaAPI:= frmConexaoAPI_V.Execute(Endpoint, Metodo, '', 'Retornando agendamentos. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      JsonLista:= RespostaAPI.Data;

      ListaAgendamentos:= TAgendas_List_M.toList(JsonLista);

      If ListaAgendamentos = Nil Then
        Raise Exception.Create('');

      Self.Clear();

      for C:= 0 to ListaAgendamentos.Count - 1 do begin
//        Depois alterar para:
//          1- Remover o "Clear()"
//          2- Atualizar se já existir;
//          3- Criar se não existir;
//          4- Remover se foi excluído

        Self.Add(TAgenda_M(ListaAgendamentos[C]));
      end;

      Result:= TRUE;
    Except
      ListaAgendamentos.Free();
    End;
  Finally
    RespostaAPI.Free();
  End;

end;

function TAgendas_List_M.ToJSON: String;
var
  C                                                                             : Longint;
  Json                                                                          : String;
  Item                                                                          : TAgenda_M;

begin

  Json:= '[';

  For C:= 0 To Self.Count - 1 Do Begin
    If Self[C] = Nil Then
      Continue;

    Item:= TAgenda_M(Self[C]);

    Json:= Json +
           Item.ToJSON();

    If (C < Self.Count - 1) Then
      Json:= Json + ',';
  End;

  Json:= Json +
        ']';

  Result:= Json;

end;

class function TAgendas_List_M.toList(const JSON: String): TAgendas_List_M;
var
  Retorno                                            : TAgendas_List_M;
  ListaJsons                                         : TStringlist;
  Item                                               : TAgenda_M;
  C                                                  : Longint;

begin

  Retorno:= Nil;
  ListaJsons:= Nil;

  Try
    Try
      ListaJsons:= TStringlist.Create;

      Retorno:= TAgendas_List_M.Create;
      Retorno.Clear;

      ListaJsons.Text:= JSON;

      If ListaJsons.Count = 0 Then
        Exit;

      for C:= 0 to ListaJsons.Count - 1 do begin
        Try
          Item:= TAgenda_M.ToObject(ListaJsons.Strings[C]);

          Retorno.Add(Item);
        Except
          Item.Free();
          Item:= Nil;
        End;
      end;

      Result:= Retorno;
    Except
      Retorno.Free();
      Result:= Nil;
    End;
  Finally
    ListaJsons.Free();
  End;

end;

end.
