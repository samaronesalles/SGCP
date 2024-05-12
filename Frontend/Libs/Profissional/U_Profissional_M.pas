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

    function ToJSON: String;
    class function ToObject(JSON: String): TProfissional_M;
  End;

  TProfissional_List_M = class(TObjectList)
  public
    function ToJSON: String;
  end;

implementation

uses Uteis;

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

end.
