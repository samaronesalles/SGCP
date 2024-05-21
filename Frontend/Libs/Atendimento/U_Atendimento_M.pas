unit U_Atendimento_M;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  U_ObjectList, U_Agenda_M;

type
  TAtendimento_M = class(TObject)
  private
    FId                                                                         : Longint;
    FDi                                                                         : String;
    FStatus                                                                     : Longint;
    FDataHoraIni                                                                : TDateTime;
    FDataHoraFim                                                                : TDateTime;
    FAnotacoes                                                                  : String;
    FAgenda                                                                     : TAgenda_M;

    function endpoint_Retorno_PorID(VAR MetodoHttp: String): String;
    function endpoint_Novo(VAR MetodoHttp: String): String;
  public
    property Id                                                                 : Longint Read FId Write FId;
    property Di                                                                 : String Read FDi Write FDi;
    property Status                                                             : Longint Read FStatus Write FStatus;
    property Agenda                                                             : TAgenda_M Read FAgenda Write FAgenda;
    property DataHoraIni                                                        : TDateTime Read FDataHoraIni Write FDataHoraIni;
    property DataHoraFim                                                        : TDateTime Read FDataHoraFim Write FDataHoraFim;
    property Anotacoes                                                          : String Read FAnotacoes Write FAnotacoes;

    constructor Create;
    destructor Destroy; override;

    function Save: Boolean;

    function ToJSON: String;
    class function ToObject(const JSON: String): TAtendimento_M;
  End;

  TAtendimento_List_M = class(TObjectList)
  private
    FStatus                                                                     : Longint;  // 0: Todos
                                                                                            // 1: Pendente de confirmação
                                                                                            // 2: Canceladas
                                                                                            // 3: Confirmada não realizada
                                                                                            // 4: Realizada
    FProfissionalID                                                             : Longint;
    FPacienteID                                                                 : Longint;

    function endpoint_lista(var MetodoHttp: String): String;
  public
    property Status                                                             : Longint Read FStatus Write FStatus;
    property ProfissionalID                                                     : Longint Read FProfissionalID Write FProfissionalID;
    property PacienteID                                                         : Longint Read FPacienteID Write FPacienteID;

    constructor Create;

    function RetornoLista: Boolean;
    function FiltraLista(const De, Ate: TDateTime): TList<integer>;

    function ToJSON: String;

    class function toList(const JSON: String): TAtendimento_List_M;
  end;

implementation

uses Uteis, U_MeusTipos, U_ConexaoAPI_M, U_ConexaoAPI_V;

{ TAtendimento_M }

constructor TAtendimento_M.Create;
begin
  Self.FId:= 0;
  Self.FDi:= '';
  Self.FStatus:= 1;
  Self.FDataHoraIni:= 0;
  Self.FDataHoraFim:= 0;
  Self.FAnotacoes:= '';
  Self.FAgenda:= Nil;
end;

destructor TAtendimento_M.Destroy;
begin
  inherited;
  Self.FAgenda.Free();
end;

function TAtendimento_M.endpoint_Novo(var MetodoHttp: String): String;
begin
  MetodoHttp:= 'POST';
  Result:= 'atendimentos';
end;

function TAtendimento_M.endpoint_Retorno_PorID(var MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then
    Exit;

  St:= 'atendimentos/[id]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));

  MetodoHttp:= 'GET';
  Result:= St;

end;

function TAtendimento_M.Save: Boolean;
begin
  // Código para salvar atendimentos avulsos (Sem agenda de origem)
end;

function TAtendimento_M.ToJSON: String;
begin

  Result:= '{' +
               '"id": ' + IntToStr(Self.FId) + ',' +
               '"di": ' + Uteis.ConverteTextoToJson(Self.FDi) + ',' +
               '"agenda": ' + Self.FAgenda.ToJSON() + ',' +
               '"datahora_inicio"' + Uteis.ConverteTextoToJson(Uteis.DateTime2Str_UTC(Self.FDataHoraIni)) + ',' +
               '"datahora_fim"' + Uteis.ConverteTextoToJson(Uteis.DateTime2Str_UTC(Self.FDataHoraFim)) + ',' +
               '"anotacoes": ' + Uteis.ConverteTextoToJson(Self.FAnotacoes) +
           '}';

end;

class function TAtendimento_M.ToObject(const JSON: String): TAtendimento_M;
var
  Retorno                                            : TAtendimento_M;
  DH_ini, DH_fim                                     : String;

begin

  Retorno:= Nil;

  Try
    DH_ini:= Uteis.ReturnValor_EmJSON(JSON, 'datahora_inicio');
    DH_fim:= Uteis.ReturnValor_EmJSON(JSON, 'datahora_fim');

    Retorno:= TAtendimento_M.Create;
    Retorno.Id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'id'));
    Retorno.Di:= Uteis.ReturnValor_EmJSON(JSON, 'di');
    Retorno.Status:= Uteis.Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'status'));
    Retorno.Agenda:= TAgenda_M.ToObject(Uteis.ReturnValor_EmJSON(JSON, 'agenda'));
    Retorno.DataHoraIni:= Uteis.DateTimeUTC2TDatetime(DH_ini);
    Retorno.DataHoraFim:= Uteis.DateTimeUTC2TDatetime(DH_fim);
    Retorno.Anotacoes:= Uteis.ReturnValor_EmJSON(JSON, 'anotacoes');

    Result:= Retorno;
  Except
    Retorno.Free();
    Result:= Nil;
  End;

end;

{ TAtendimento_List_M }

constructor TAtendimento_List_M.Create;
begin
  Self.FStatus:= 0;
  Self.FProfissionalID:= 0;
  Self.FPacienteID:= 0;
end;

function TAtendimento_List_M.endpoint_lista(var MetodoHttp: String): String;
var
  St                                   : String;

begin
  MetodoHttp:= 'GET';

  St:= 'atendimentos/lista/[status]/[profissional_id]/[paciente_id]';

  Uteis.Substitua(St, '[status]', IntToStr(Self.FStatus));
  Uteis.Substitua(St, '[profissional_id]', IntToStr(Self.FProfissionalID));
  Uteis.Substitua(St, '[paciente_id]', IntToStr(Self.FPacienteID));

  Result:= St
end;

function TAtendimento_List_M.FiltraLista(const De, Ate: TDateTime): TList<integer>;
var
  C                                                 : Integer;
  Atendimento                                       : TAtendimento_M;

begin

  try
    Result:= TList<integer>.Create;

    for Atendimento in Self do begin
      if ((Atendimento.DataHoraIni >= De) AND (Atendimento.DataHoraIni <= Ate)) then
        Result.Add(Atendimento.Id);
    end;

  except
    raise;
  end;

end;

function TAtendimento_List_M.RetornoLista: Boolean;
var
  Endpoint, Metodo                     : String;
  RespostaAPI                          : TConexaoAPI_M;

  JsonLista                            : String;
  ListaAtendimentos                    : TAtendimento_List_M;

  C                                    : Longint;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;

  JsonLista:= '';
  ListaAtendimentos:= Nil;

  Try
    Try
      Endpoint:= Self.endpoint_lista(Metodo);

      RespostaAPI:= frmConexaoAPI_V.Execute(taAtendimento_Lista, Endpoint, Metodo, '', 'Retornando lista de atendimentos. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      JsonLista:= RespostaAPI.Data;

      ListaAtendimentos:= TAtendimento_List_M.toList(JsonLista);

      If ListaAtendimentos = Nil Then
        Raise Exception.Create('');

      Self.Clear();

      for C:= 0 to ListaAtendimentos.Count - 1 do
        Self.Add(TAtendimento_M(ListaAtendimentos[C]));

      Result:= TRUE;
    Except
      ListaAtendimentos.Free();
    End;
  Finally
    RespostaAPI.Free();
  End;

end;

function TAtendimento_List_M.ToJSON: String;
var
  C                                                                             : Longint;
  Json                                                                          : String;
  Item                                                                          : TAtendimento_M;

begin

  Json:= '[';

  For C:= 0 To Self.Count - 1 Do Begin
    If Self[C] = Nil Then
      Continue;

    Item:= TAtendimento_M(Self[C]);

    Json:= Json +
           Item.ToJSON();

    If (C < Self.Count - 1) Then
      Json:= Json + ',';
  End;

  Json:= Json +
        ']';

  Result:= Json;

end;

class function TAtendimento_List_M.toList(const JSON: String): TAtendimento_List_M;
var
  Retorno                                            : TAtendimento_List_M;
  ListaJsons                                         : TStringlist;
  Item                                               : TAtendimento_M;
  C                                                  : Longint;

begin

  Retorno:= Nil;
  ListaJsons:= Nil;

  Try
    Try
      ListaJsons:= TStringlist.Create;

      Retorno:= TAtendimento_List_M.Create;
      Retorno.Clear;

      ListaJsons.Text:= JSON;

      If ListaJsons.Count = 0 Then
        Exit;

      for C:= 0 to ListaJsons.Count - 1 do begin
        Try
          Item:= TAtendimento_M.ToObject(ListaJsons.Strings[C]);

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
