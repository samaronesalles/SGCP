unit U_Profissional_M;

interface

uses
  System.SysUtils, System.Classes, U_ObjectList;

type
  TProfissional_M = class(TObject)
  private
    FId                                                                         : Longint;
    FDi                                                                         : String;
    FNome                                                                       : String;
    FCelular                                                                    : String;
    FEmail                                                                      : String;
    FAtivo                                                                      : Boolean;
    FUsername                                                                   : String;
    FPassword                                                                   : String;

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
    property Username                                                           : String Read FUsername Write FUsername;
    property Password                                                           : String Read FPassword Write FPassword;

    constructor Create;
    destructor Destroy; override;

    function Save: Boolean;
    function Delete: Boolean;

    function ToJSON: String;
    class function ToObject(JSON: String): TProfissional_M;
  End;

  TProfissional_List_M = class(TObjectList)
  private
    function endpoint_lista(VAR MetodoHttp: String): String;
  public
    function RetornoLista: Boolean;

    function ToJSON: String;
    class function toList(JSON: String): TProfissional_List_M;
  end;

implementation

uses Uteis, U_MeusTipos, U_ConexaoAPI_M, U_ConexaoAPI_V;

{ TProfissional_M }

constructor TProfissional_M.Create;
begin
  Self.FId:= 0;
  Self.FDi:= '';
  Self.FNome:= '';
  Self.FCelular:= '';
  Self.FEmail:= '';
  Self.FAtivo:= FALSE;
  Self.FUsername:= '';
  Self.FPassword:= '';
end;


destructor TProfissional_M.Destroy;
begin
  inherited;

end;

function TProfissional_M.endpoint_Edicao(VAR MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then Begin
    Result:= Self.endpoint_Novo(MetodoHttp);
    Exit;
  End;

  St:= 'profissionais/[id]/[di]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));
  Uteis.Substitua(St, '[di]', Self.Fdi);

  MetodoHttp:= 'PUT';
  Result:= St;

end;

function TProfissional_M.endpoint_Exclusao(VAR MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then
    Exit;

  St:= 'profissionais/[id]/[di]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));
  Uteis.Substitua(St, '[di]', Self.Fdi);

  MetodoHttp:= 'DELETE';
  Result:= St;

end;

function TProfissional_M.endpoint_Novo(VAR MetodoHttp: String): String;
begin
  MetodoHttp:= 'POST';
  Result:= 'profissionais';
end;

function TProfissional_M.endpoint_Retorno_PorID(var MetodoHttp: String): String;
var
  St                                   : String;

begin

  MetodoHttp:= '';

  if Self.FId <= 0 then
    Exit;

  St:= 'profissionais/[id]';

  Uteis.Substitua(St, '[id]', IntToStr(Self.FId));

  MetodoHttp:= 'GET';
  Result:= St;

end;

function TProfissional_M.Save: Boolean;
var
  Novo                                 : Boolean;
  Endpoint, Metodo, Requisicao         : String;
  RespostaAPI                          : TConexaoAPI_M;
  Profissional                         : TProfissional_M;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;
  Profissional:= Nil;

  Try
    Try
      Novo:= Self.FId <= 0;
      Endpoint:= Uteis.iff(Novo, Self.endpoint_Novo(Metodo), Self.endpoint_Edicao(Metodo));
      Requisicao:= Self.ToJSON();

      RespostaAPI:= frmConexaoAPI_V.Execute(taProfissional_Save, Endpoint, Metodo, Requisicao, 'Salvando profissional. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      Profissional:= TProfissional_M.ToObject(RespostaAPI.Data);
      If Profissional = Nil Then
        Exit;

      Self.Id:= Profissional.Id;
      Self.Di:= Profissional.Di;
      Self.Nome:= Profissional.Nome;
      Self.Celular:= Profissional.Celular;
      Self.Email:= Profissional.Email;
      Self.Ativo:= Profissional.Ativo;
      Self.Username:= Profissional.Username;
      Self.Password:= Profissional.Password;

      Result:= TRUE;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    RespostaAPI.Free();
    Profissional.Free();
  End;

end;

function TProfissional_M.Delete: Boolean;
var
  Endpoint, Metodo                     : String;
  RespostaAPI                          : TConexaoAPI_M;

begin

  Result:= FALSE;

  RespostaAPI:= Nil;

  Try
    Try
      Endpoint:= Self.endpoint_Exclusao(Metodo);

      RespostaAPI:= frmConexaoAPI_V.Execute(taProfissional_Excusao, Endpoint, Metodo, '', 'Excluindo profissional. Aguarde!');

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

function TProfissional_M.ToJSON: String;
begin

  Result:= '{' +
               '"id": ' + IntToStr(Self.FId) + ',' +
               '"di": ' + Uteis.ConverteTextoToJson(Self.FDi) + ',' +
               '"nome": ' + Uteis.ConverteTextoToJson(Self.FNome) + ',' +
               '"celular": ' + Uteis.ConverteTextoToJson(Self.FCelular) + ',' +
               '"email": ' + Uteis.ConverteTextoToJson(Self.FEmail) + ',' +
               '"ativo": ' + Uteis.ConverteBooleanToJson(Self.FAtivo) + ',' +
               '"username": ' + Uteis.ConverteTextoToJson(Self.FUsername) + ',' +
               '"password": ' + Uteis.ConverteTextoToJson(Self.FPassword) +
           '}';

end;

class function TProfissional_M.ToObject(JSON: String): TProfissional_M;
var
  Retorno                                            : TProfissional_M;

begin

  Retorno:= Nil;

  Try
    Retorno:= TProfissional_M.Create;

    Retorno.Id:= Str2Num(Uteis.ReturnValor_EmJSON(JSON, 'id'));
    Retorno.Di:= Uteis.ReturnValor_EmJSON(JSON, 'di');
    Retorno.Nome:= Uteis.ReturnValor_EmJSON(JSON, 'nome');
    Retorno.Celular:= Uteis.ReturnValor_EmJSON(JSON, 'celular');
    Retorno.Email:= Uteis.ReturnValor_EmJSON(JSON, 'email');
    Retorno.Ativo:= Uteis.CharToBoolean(Uteis.ReturnValor_EmJSON(JSON, 'ativo'));
    Retorno.Username:= Uteis.ReturnValor_EmJSON(JSON, 'username');
    Retorno.Password:= Uteis.ReturnValor_EmJSON(JSON, 'password');

    Result:= Retorno;
  Except
    Retorno.Free();
    Result:= Nil;
  End;

end;

{ TProfissional_List_M }

function TProfissional_List_M.endpoint_lista(var MetodoHttp: String): String;
begin
  MetodoHttp:= 'GET';
  Result:= 'profissionais/lista';
end;

function TProfissional_List_M.RetornoLista: Boolean;
var
  Endpoint, Metodo                     : String;
  RespostaAPI                          : TConexaoAPI_M;

  JsonLista                            : String;
  ListaProfissionais                   : TProfissional_List_M;

  C                                    : Longint;
  
begin

  Result:= FALSE;

  RespostaAPI:= Nil;

  JsonLista:= '';
  ListaProfissionais:= Nil;

  Try
    Try
      Endpoint:= Self.endpoint_lista(Metodo);

      RespostaAPI:= frmConexaoAPI_V.Execute(taProfissional_Lista, Endpoint, Metodo, '', 'Retornando lista de profissionais. Aguarde!');

      If RespostaAPI = Nil Then
        Exit;

      If RespostaAPI.StatusCode_HTTP <> 200 Then
        Exit;

      JsonLista:= RespostaAPI.Data;

      ListaProfissionais:= TProfissional_List_M.toList(JsonLista);

      If ListaProfissionais = Nil Then
        Raise Exception.Create('');
        
      Self.Clear();

      for C:= 0 to ListaProfissionais.Count - 1 do
        Self.Add(TProfissional_M(ListaProfissionais[C]));

      Result:= TRUE;
    Except
      ListaProfissionais.Free();
    End;
  Finally
    RespostaAPI.Free();
  End;

end;

function TProfissional_List_M.ToJSON: String;
var
  C                                                                             : Longint;
  Json                                                                          : String;
  Item                                                                          : TProfissional_M;

begin

  Json:= '[';

  For C:= 0 To Self.Count - 1 Do Begin
    If Self[C] = Nil Then
      Continue;

    Item:= TProfissional_M(Self[C]);

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
class function TProfissional_List_M.toList(JSON: String): TProfissional_List_M;
var
  Retorno                                            : TProfissional_List_M;
  ListaJsons                                         : TStringlist;
  Item                                               : TProfissional_M;
  C                                                  : Longint;

begin

  Retorno:= Nil;
  ListaJsons:= Nil;

  Try
    Try
      ListaJsons:= TStringlist.Create;

      Retorno:= TProfissional_List_M.Create;
      Retorno.Clear;

      ListaJsons.Text:= JSON;

      If ListaJsons.Count = 0 Then
        Exit;

      for C:= 0 to ListaJsons.Count - 1 do begin
        Try
          Item:= TProfissional_M.ToObject(ListaJsons.Strings[C]);

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
