unit U_Atendimento_M;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  U_ObjectList, U_MeusTipos, U_Profissional_M, U_Agenda_M;

type
  TAtendimento_M = class(TObject)
  private
    FId                                                                         : Longint;
    FDi                                                                         : String;
    FStatus                                                                     : TStatusAtendimentos;
    FDataHoraIni                                                                : TDateTime;
    FDataHoraFim                                                                : TDateTime;
    FAnotacoes                                                                  : String;
    FAgenda                                                                     : TAgenda_M;

    function endpoint_Retorno_PorID(VAR MetodoHttp: String): String;
    function endpoint_Novo(VAR MetodoHttp: String): String;
    function endpoint_Edicao(var MetodoHttp: String): String;
    function endpoint_Encerramento(var MetodoHttp: String): String;

  public
    property Id                                                                 : Longint Read FId Write FId;
    property Di                                                                 : String Read FDi Write FDi;
    property Status                                                             : TStatusAtendimentos Read FStatus Write FStatus;
    property Agenda                                                             : TAgenda_M Read FAgenda Write FAgenda;
    property DataHoraIni                                                        : TDateTime Read FDataHoraIni Write FDataHoraIni;
    property DataHoraFim                                                        : TDateTime Read FDataHoraFim Write FDataHoraFim;
    property Anotacoes                                                          : String Read FAnotacoes Write FAnotacoes;

    constructor Create;
    destructor Destroy; override;

    function Save: Boolean;
    function Encerrar: Boolean;

    function ToJSON (EncodeAnotacoes: Boolean): String;
    class function ToObject (const JSON: String): TAtendimento_M;
  End;

  TAtendimento_List_M = class(TObjectList)
  private
    FStatus                                                                     : TStatusAtendimentos;
    FInicioDe                                                                   : TDateTime;
    FInicioAte                                                                  : TDateTime;
    FProfissionalID                                                             : Longint;
    FProfissionalNome                                                           : String;
    FPacienteID                                                                 : Longint;
    FPacienteNome                                                               : String;

    function endpoint_lista (var MetodoHttp: String): String;
  public
    property Status                                                             : TStatusAtendimentos Read FStatus Write FStatus;
    property InicioDe                                                           : TDateTime Read FInicioDe Write FInicioDe;
    property InicioAte                                                          : TDateTime Read FInicioAte Write FInicioAte;
    property ProfissionalID                                                     : Longint Read FProfissionalID Write FProfissionalID;
    property ProfissionalNome                                                   : String Read FProfissionalNome Write FProfissionalNome;
    property PacienteID                                                         : Longint Read FPacienteID Write FPacienteID;
    property PacienteNome                                                       : String Read FPacienteNome Write FPacienteNome;

    constructor Create;

    function RetornoLista: Boolean;
    function FiltraLista(const De, Ate: TDateTime): TList<integer>;

    function ToJSON: String;
    function GetStatusAtendimento(id: Longint): TStatusAtendimentos;

    class function toList(const JSON: String; decifrarAnotacoes: Boolean): TAtendimento_List_M;
  end;

implementation

uses Uteis, U_frmMain, U_RSA, U_ConexaoAPI_M, U_ConexaoAPI_V;

{ TAtendimento_M }

constructor TAtendimento_M.Create;
begin
  Self.FId:= 0;
  Self.FDi:= '';
  Self.FStatus:= saPendenteConfirmacao;
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

function TAtendimento_M.endpoint_Edicao(var MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then
    Exit;

  St:= 'atendimentos/[id]/[di]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));
  Uteis.Substitua(St, '[di]', Self.Fdi);

  MetodoHttp:= 'PUT';
  Result:= St;

end;

function TAtendimento_M.endpoint_Encerramento(var MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then
    Exit;

  St:= 'atendimentos/encerrar/[id]/[di]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));
  Uteis.Substitua(St, '[di]', Self.Fdi);

  MetodoHttp:= 'PUT';
  Result:= St;

end;

function TAtendimento_M.Save: Boolean;
var
  Endpoint, Metodo, Requisicao         : String;
  RespostaAPI                          : TConexaoAPI_M;
  Atendimento                          : TAtendimento_M;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;
  Atendimento:= Nil;

  Try
    Try
      Endpoint:= Self.endpoint_Edicao(Metodo);

      Requisicao:= Self.ToJSON(TRUE);

      RespostaAPI:= frmConexaoAPI_V.Execute(Endpoint, Metodo, Requisicao, 'Salvando atendimento. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      Atendimento:= TAtendimento_M.ToObject(RespostaAPI.Data);
      If Atendimento = Nil Then
        Exit;

      Self.Id:= Atendimento.Id;
      Self.Di:= Atendimento.Di;
      Self.Status:= Atendimento.Status;
      Self.DataHoraIni:= Atendimento.DataHoraIni;
      Self.DataHoraFim:= Atendimento.DataHoraFim;
      Self.Anotacoes:= DecodeRSA(Atendimento.Anotacoes, frmMain.RSA_PrivateKey);;

      Result:= TRUE;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    RespostaAPI.Free();
    Atendimento.Free();
  End;

end;

function TAtendimento_M.Encerrar: Boolean;
var
  Novo                                 : Boolean;
  Endpoint, Metodo, Requisicao         : String;
  RespostaAPI                          : TConexaoAPI_M;
  Atendimento                          : TAtendimento_M;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;
  Atendimento:= Nil;

  Try
    Try
      Endpoint:= Self.endpoint_Encerramento(Metodo);

      Requisicao:= '{"datahora_fim": ' + Uteis.ConverteTextoToJson(Uteis.DateTime2Str_UTC(Now())) + '}';

      RespostaAPI:= frmConexaoAPI_V.Execute(Endpoint, Metodo, Requisicao, 'Encerrando atendimento. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      Atendimento:= TAtendimento_M.ToObject(RespostaAPI.Data);
      If Atendimento = Nil Then
        Exit;

      Self.Id:= Atendimento.Id;
      Self.Di:= Atendimento.Di;
      Self.Status:= Atendimento.Status;
      Self.DataHoraIni:= Atendimento.DataHoraIni;
      Self.DataHoraFim:= Atendimento.DataHoraFim;
      Self.Anotacoes:= Atendimento.Anotacoes;

      Result:= TRUE;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    RespostaAPI.Free();
    Atendimento.Free();
  End;

end;

function TAtendimento_M.ToJSON (EncodeAnotacoes: Boolean): String;
var
  textoAnotacoes, textoAnotacoesToJSON                    : String;

begin

  textoAnotacoes:= Self.FAnotacoes;

  if EncodeAnotacoes then
    textoAnotacoes:= EncodeRSA(textoAnotacoes, frmMain.RSA_PublicKey);

  textoAnotacoesToJSON:= Uteis.ConverteTextoToJson(textoAnotacoes);

//  try
    Result:= '{' +
                 '"id": ' + IntToStr(Self.FId) + ',' +
                 '"di": ' + Uteis.ConverteTextoToJson(Self.FDi) + ',' +
                 '"agenda": ' + Self.FAgenda.ToJSON() + ',' +
                 '"datahora_inicio": ' + Uteis.ConverteTextoToJson(Uteis.DateTime2Str_UTC(Self.FDataHoraIni)) + ',' +
                 '"datahora_fim": ' + Uteis.ConverteTextoToJson(Uteis.DateTime2Str_UTC(Self.FDataHoraFim)) + ',' +
                 '"anotacoes": ' + textoAnotacoesToJSON +
             '}';
//  except
//    on E: Exception do
//      Uteis.SayError('Atendimento_M.ToJSON: ' + #13 + E.Message);
//  end;

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
    Retorno.Status:= Int2StatusAtendimento(Uteis.Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'status')));
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
  Self.FStatus:= saTodos;
  Self.FInicioDe:= 0;
  Self.FInicioAte:= 0;
  Self.FProfissionalID:= 0;
  Self.FProfissionalNome:= '';
  Self.FPacienteID:= 0;
  Self.FPacienteNome:= '';
end;

function TAtendimento_List_M.endpoint_lista(var MetodoHttp: String): String;
var
  St                                   : String;

begin
  MetodoHttp:= 'GET';

  St:= 'atendimentos/lista/[status]/[profissional_id]/[paciente_id]/[inicio_de]/[inicio_ate]';

  Uteis.Substitua(St, '[status]', IntToStr(StatusAtendimento2Int(Self.FStatus)));
  Uteis.Substitua(St, '[inicio_de]', Uteis.DateTime2Str_UTC(Self.FInicioDe));
  Uteis.Substitua(St, '[inicio_ate]', Uteis.DateTime2Str_UTC(Self.FInicioAte));
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

function TAtendimento_List_M.GetStatusAtendimento(id: Longint): TStatusAtendimentos;
var
  C                                                 : Integer;
  Atendimento                                       : TAtendimento_M;

begin

  try
    Result:= saTodos;

    for Atendimento in Self do begin
      if Atendimento.Id <> id then
        continue;

      result:= Atendimento.Status;
      break;
    end;

  except
    Result:= saTodos;
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

      RespostaAPI:= frmConexaoAPI_V.Execute(Endpoint, Metodo, '', 'Retornando lista de atendimentos. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      JsonLista:= RespostaAPI.Data;

      ListaAtendimentos:= TAtendimento_List_M.toList(JsonLista, TRUE);

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
           Item.ToJSON(FALSE);

    If (C < Self.Count - 1) Then
      Json:= Json + ',';
  End;

  Json:= Json +
        ']';

  Result:= Json;

end;

class function TAtendimento_List_M.toList(const JSON: String; decifrarAnotacoes: Boolean): TAtendimento_List_M;
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

          if ((Trim(Item.Anotacoes) <> '') AND (decifrarAnotacoes)) then
            Item.Anotacoes:= DecodeRSA(Item.Anotacoes, frmMain.RSA_PrivateKey);

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
