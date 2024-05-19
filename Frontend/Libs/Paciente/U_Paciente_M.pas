unit U_Paciente_M;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections, U_ObjectList;

type
  TPaciente_M = class(TObject)
  private
    FId                                                                         : Longint;
    FDi                                                                         : String;
    FNome                                                                       : String;
    FCelular                                                                    : String;
    FEmail                                                                      : String;
    FAtivo                                                                      : Boolean;

    function endpoint_Retorno_PorID(VAR MetodoHttp: String): String;
    function endpoint_Novo(VAR MetodoHttp: String): String;
    function endpoint_Edicao(VAR MetodoHttp: String): String;
    function endpoint_Exclusao(VAR MetodoHttp: String): String;
  public
    property Id                                                                 : Longint Read FId Write FId;
    property Di                                                                 : String Read FDi Write FDi;
    property Nome                                                               : String Read FNome Write FNome;
    property Celular                                                            : String Read FCelular Write FCelular;
    property Email                                                              : String Read FEmail Write FEmail;
    property Ativo                                                              : Boolean Read FAtivo Write FAtivo;

    constructor Create;
    destructor Destroy; override;

    function Save: Boolean;
    function Delete: Boolean;

    function ToJSON: String;
    class function ToObject(const JSON: String): TPaciente_M;
  End;

  TPaciente_List_M = class(TObjectList)
  private
    function endpoint_lista(var MetodoHttp: String): String;
  public
    function RetornoLista: Boolean;
    function FiltraLista(const nome: String): TList<integer>;

    function ToJSON: String;

    class function toList(const JSON: String): TPaciente_List_M;
  end;

implementation

uses Uteis, U_MeusTipos, U_ConexaoAPI_M, U_ConexaoAPI_V;

{ TProfissional_M }

constructor TPaciente_M.Create;
begin
  Self.FId:= 0;
  Self.FDi:= '';
  Self.FNome:= '';
  Self.FCelular:= '';
  Self.FEmail:= '';
  Self.FAtivo:= FALSE;
end;

destructor TPaciente_M.Destroy;
begin
  inherited;

end;

function TPaciente_M.endpoint_Edicao(VAR MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then Begin
    Result:= Self.endpoint_Novo(MetodoHttp);
    Exit;
  End;

  St:= 'pacientes/[id]/[di]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));
  Uteis.Substitua(St, '[di]', Self.Fdi);

  MetodoHttp:= 'PUT';
  Result:= St;

end;

function TPaciente_M.endpoint_Exclusao(VAR MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then
    Exit;

  St:= 'pacientes/[id]/[di]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));
  Uteis.Substitua(St, '[di]', Self.Fdi);

  MetodoHttp:= 'DELETE';
  Result:= St;

end;

function TPaciente_M.endpoint_Novo(VAR MetodoHttp: String): String;
begin
  MetodoHttp:= 'POST';
  Result:= 'pacientes';
end;

function TPaciente_M.endpoint_Retorno_PorID(var MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then
    Exit;

  St:= 'pacientes/[id]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));

  MetodoHttp:= 'GET';
  Result:= St;

end;

function TPaciente_M.Save: Boolean;
var
  Novo                                 : Boolean;
  Endpoint, Metodo, Requisicao         : String;
  RespostaAPI                          : TConexaoAPI_M;
  Paciente                             : TPaciente_M;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;
  Paciente:= Nil;

  Try
    Try
      Novo:= Self.FId <= 0;

      if Novo then
        Endpoint:= Self.endpoint_Novo(Metodo)
      else
        Endpoint:= Self.endpoint_Edicao(Metodo);

      Requisicao:= Self.ToJSON();

      RespostaAPI:= frmConexaoAPI_V.Execute(taProfissional_Save, Endpoint, Metodo, Requisicao, 'Salvando paciente. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      Paciente:= TPaciente_M.ToObject(RespostaAPI.Data);
      If Paciente = Nil Then
        Exit;

      Self.Id:= Paciente.Id;
      Self.Di:= Paciente.Di;
      Self.Nome:= Paciente.Nome;
      Self.Celular:= Paciente.Celular;
      Self.Email:= Paciente.Email;
      Self.Ativo:= Paciente.Ativo;

      Result:= TRUE;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    RespostaAPI.Free();
    Paciente.Free();
  End;

end;

function TPaciente_M.Delete: Boolean;
var
  Endpoint, Metodo                     : String;
  RespostaAPI                          : TConexaoAPI_M;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;

  Try
    Try
      Endpoint:= Self.endpoint_Exclusao(Metodo);

      RespostaAPI:= frmConexaoAPI_V.Execute(taProfissional_Excusao, Endpoint, Metodo, '', 'Excluindo paciente. Aguarde!');

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

function TPaciente_M.ToJSON: String;
begin

  Result:= '{' +
               '"id": ' + IntToStr(Self.FId) + ',' +
               '"di": ' + Uteis.ConverteTextoToJson(Self.FDi) + ',' +
               '"nome": ' + Uteis.ConverteTextoToJson(Self.FNome) + ',' +
               '"celular": ' + Uteis.ConverteTextoToJson(Self.FCelular) + ',' +
               '"email": ' + Uteis.ConverteTextoToJson(Self.FEmail) + ',' +
               '"ativo": ' + Uteis.ConverteBooleanToJson(Self.FAtivo) +
           '}';

end;

class function TPaciente_M.ToObject(const JSON: String): TPaciente_M;
var
  Retorno                                            : TPaciente_M;

begin

  Retorno:= Nil;

  Try
    Retorno:= TPaciente_M.Create;

    Retorno.Id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'id'));
    Retorno.Di:= Uteis.ReturnValor_EmJSON(JSON, 'di');
    Retorno.Nome:= Uteis.ReturnValor_EmJSON(JSON, 'nome');
    Retorno.Celular:= Uteis.ReturnValor_EmJSON(JSON, 'celular');
    Retorno.Email:= Uteis.ReturnValor_EmJSON(JSON, 'email');
    Retorno.Ativo:= Uteis.CharToBoolean(Uteis.ReturnValor_EmJSON(JSON, 'ativo'));

    Result:= Retorno;
  Except
    Retorno.Free();
    Result:= Nil;
  End;

end;


{ TProfissional_List_M }

function TPaciente_List_M.endpoint_lista(var MetodoHttp: String): String;
begin
  MetodoHttp:= 'GET';
  Result:= 'pacientes/lista';
end;

function TPaciente_List_M.RetornoLista: Boolean;
var
  Endpoint, Metodo                     : String;
  RespostaAPI                          : TConexaoAPI_M;

  JsonLista                            : String;
  ListaPacientes                       : TPaciente_List_M;

  C                                    : Longint;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;

  JsonLista:= '';
  ListaPacientes:= Nil;

  Try
    Try
      Endpoint:= Self.endpoint_lista(Metodo);

      RespostaAPI:= frmConexaoAPI_V.Execute(taProfissional_Lista, Endpoint, Metodo, '', 'Retornando lista de pacientes. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      JsonLista:= RespostaAPI.Data;

      ListaPacientes:= TPaciente_List_M.toList(JsonLista);

      If ListaPacientes = Nil Then
        Raise Exception.Create('');

      Self.Clear();

      for C:= 0 to ListaPacientes.Count - 1 do
        Self.Add(TPaciente_M(ListaPacientes[C]));

      Result:= TRUE;
    Except
      ListaPacientes.Free();
    End;
  Finally
    RespostaAPI.Free();
  End;

end;

function TPaciente_List_M.ToJSON: String;
var
  C                                                                             : Longint;
  Json                                                                          : String;
  Item                                                                          : TPaciente_M;

begin

  Json:= '[';

  For C:= 0 To Self.Count - 1 Do Begin
    If Self[C] = Nil Then
      Continue;

    Item:= TPaciente_M(Self[C]);

    Json:= Json +
           Item.ToJSON();

    If (C < Self.Count - 1) Then
      Json:= Json + ',';
  End;

  Json:= Json +
        ']';

  Result:= Json;

end;

// "JSON" deverá receber uma stringlist contendo em cada elemento um obejeto "{}"
class function TPaciente_List_M.toList(const JSON: String): TPaciente_List_M;
var
  Retorno                                            : TPaciente_List_M;
  ListaJsons                                         : TStringlist;
  Item                                               : TPaciente_M;
  C                                                  : Longint;

begin

  Retorno:= Nil;
  ListaJsons:= Nil;

  Try
    Try
      ListaJsons:= TStringlist.Create;

      Retorno:= TPaciente_List_M.Create;
      Retorno.Clear;

      ListaJsons.Text:= JSON;

      If ListaJsons.Count = 0 Then
        Exit;

      for C:= 0 to ListaJsons.Count - 1 do begin
        Try
          Item:= TPaciente_M.ToObject(ListaJsons.Strings[C]);

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

// Retorna lista de "id"s que foram encontrados com o nome.
function TPaciente_List_M.FiltraLista(const nome: String): TList<integer>;
var
  C                                                 : Integer;
  Paciente                                          : TPaciente_M;

begin

  try
    Result:= TList<integer>.Create;

    for Paciente in Self do begin
      if AnsiContainsText(Paciente.Nome, Nome) then
        Result.Add(Paciente.Id);
    end;

  except
    raise;
  end;

end;

end.
