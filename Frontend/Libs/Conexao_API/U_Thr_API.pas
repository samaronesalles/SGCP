unit U_Thr_API;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes,
  System.StrUtils, IdHTTP, IdSSLOpenSSL, IdCoderMIME, IdURI, U_ConexaoAPI_M;

  type
    TThr_Api = class(TThread)
    private
      FUrl                                                          : String;
      FMethod                                                       : String;
      FContentType                                                  : String;
      FEndpoint                                                     : String;
      FRequisicao                                                   : String;
      FResposta                                                     : String;

      FRetorno                                                      : TConexaoAPI_M;

      FConnectTimeOutEmSegundos                                     : LongInt;
      FReadTimeoutEmSegundos                                        : LongInt;
      FVersaoSSL                                                    : LongInt;
      FStatusCode_HTTP                                              : LongInt;
      FStatusCode_Interno                                           : LongInt;

      FRespostaDecodeUTF8                                           : Boolean;

      destructor Destroy; override;
      procedure Execute; override;

      function idHttpSendReq(EnderecoWEB, CustonHeaders: Widestring; VAR Resposta: Widestring; VAR StatusCode_HTTP, StatusCode_Interno: Longint): Boolean;

      procedure enviarRequisicao;

      procedure EnvieResposta;
    public
      property Method                                               : String Write FMethod;
      property Endpoint                                             : String Write FEndpoint;
      property Requisicao                                           : String Write FRequisicao;

      property Retorno                                              : TConexaoAPI_M Read FRetorno Write FRetorno;

      constructor Create(CreateSuspended: Boolean);
    end;

implementation

uses Uteis;

{ TThr_Api }

constructor TThr_Api.Create(CreateSuspended: Boolean);
begin
  Inherited;

  Self.FUrl:= 'http://localhost:3325/api/';
  Self.FMethod:= 'POST';
  Self.FContentType:= 'application/json';
  Self.FEndpoint:= '';
  Self.FRequisicao:= '';
  Self.FResposta:= '';

  Self.FRetorno:= Nil; // NÃO PODE RECEBER FREE AQUI...

  Self.FConnectTimeOutEmSegundos:= 60;
  Self.FReadTimeoutEmSegundos:= 30;
  Self.FVersaoSSL:= -1;
  Self.FStatusCode_HTTP:= 0;
  Self.FStatusCode_Interno:= 0;

  FRespostaDecodeUTF8:= FALSE;

end;

destructor TThr_Api.Destroy;
begin
  inherited;
end;

procedure TThr_Api.enviarRequisicao;
var
  EnderecoWEB, CustonHeaders, Resposta               : Widestring;
  StatusCode_HTTP, StatusCode_Interno                : Longint;

begin

  Try
    Try
      Self.FResposta:= '{}';
      Self.FStatusCode_HTTP:= 0;
      Self.FStatusCode_Interno:= 0;

      EnderecoWEB:= Self.FUrl + Self.FEndpoint;
      CustonHeaders:= '';
      Resposta:= Self.FResposta;

      StatusCode_HTTP:= Self.FStatusCode_HTTP;
      StatusCode_Interno:= Self.FStatusCode_Interno;

      if NOT idHttpSendReq(EnderecoWEB, CustonHeaders, Resposta, StatusCode_HTTP, StatusCode_Interno) then
        Exit;

      Self.FResposta:= Resposta;

      Self.FStatusCode_HTTP:= StatusCode_HTTP;
      Self.FStatusCode_Interno:= StatusCode_Interno;

    Except
      On E: Exception Do
        RAISE Exception.Create('Ao enviar requisição para a API: ' + #13 + E.Message);
    End;
  Finally
  End;

end;

procedure TThr_Api.Execute;
begin

  Try
    Try
      enviarRequisicao();
    Except
      On E: Exception Do
        SayError('Ocorreu um erro ao comunicar-se com a API.');
    End;
  Finally
    Synchronize(EnvieResposta);
    Self.Terminate();
  End;

end;

procedure TThr_Api.EnvieResposta;
begin

  Self.FRetorno:= TConexaoAPI_M.Create();

  Self.FRetorno.StatusCode_HTTP:= Self.FStatusCode_HTTP;
  Self.FRetorno.StatusCode_Interno:= Self.FStatusCode_Interno;
  Self.FRetorno.Erro:= Self.FStatusCode_HTTP <> 200;
  Self.FRetorno.Data:= Uteis.ReturnValor_EmJSON(Self.FResposta, 'data');

end;

function TThr_Api.idHttpSendReq(EnderecoWEB, CustonHeaders: Widestring; VAR Resposta: Widestring; VAR StatusCode_HTTP, StatusCode_Interno: Longint): Boolean;
var
  lHTTP                                                                         : TIdHTTP;
  ExIdHttp                                                                      : EIdHTTPProtocolException;
  LHandler                                                                      : TIdSSLIOHandlerSocketOpenSSL;
  IdEncoder                                                                     : TIdEncoderMIME;

var
  C                                                                             : Longint;
  St                                                                            : String;
  Params                                                                        : TStringStream;
  StrSplit, HeaderList                                                          : TStringlist;

begin

  Result:= FALSE;

  StatusCode_HTTP:= 0;
  StatusCode_Interno:= 0;

  LHandler:= Nil;
  IdEncoder:= Nil;

  Try
    Try
      lHTTP:= TIdHTTP.Create();

      If Self.FVersaoSSL >= 0 Then Begin
        LHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(nil);

        Case Self.FVersaoSSL Of
          0 : LHandler.SSLOptions.Method:= sslvSSLv2;
          1 : LHandler.SSLOptions.Method:= sslvSSLv23;
          2 : LHandler.SSLOptions.Method:= sslvSSLv3;
          3 : LHandler.SSLOptions.Method:= sslvTLSv1;
          4 : LHandler.SSLOptions.Method:= sslvTLSv1_1;
          5 : LHandler.SSLOptions.Method:= sslvTLSv1_2;
        End;

        LHandler.SSLOptions.Mode:= sslmUnassigned;
        LHandler.SSLOptions.VerifyMode := [];
        LHandler.SSLOptions.VerifyDepth := 0;
        LHandler.Host := '';
        lHTTP.IOHandler:= LHandler;
      End;

      StrSplit:= TStringlist.Create;
      HeaderList:= TStringlist.Create;
      IdEncoder:= TIdEncoderMIME.Create;

      // Body
      Params:= TStringStream.Create(Self.FRequisicao, TEncoding.UTF8);

      // Content-type
      lHTTP.Request.ContentType:= Self.FContentType;
      lHTTP.Request.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36';
      lHTTP.Request.Accept:= '*/*';

      // Header
      If CustonHeaders <> '' Then Begin
        HeaderList.Text:= CustonHeaders;

        C:= 0;
        If HeaderList.Count > 0 Then Begin
          REPEAT
            Try
              St:= HeaderList.Strings[C];

              // Caso a requisição utilize autenticação "Basic", vamos adiciona-la já passando o usuário e a senha para Base64.
              // Pra isto, será necessário que o parâmetro "CustonHeaders" tenha uma linha no seguinte formato: "Basic=user:pass" onde "user" e "pass" deve
              // conter o login e senha real da autenticação.
              If AnsiPos('Basic=', St) = 1 Then Begin
                EnderecoWEB:= TIdURI.URLEncode(EnderecoWEB);
                lHTTP.Request.CustomHeaders.AddValue('Authorization', 'Basic ' + IdEncoder.EncodeString(Trim(Copy(St, Length('Basic=') + 1, Length(St)))));
                Continue;
              End;

              StrSplit.Clear;
              ExtractStrings(['|'],[], PChar(St), StrSplit);

              If StrSplit.Count = 2 Then
                lHTTP.Request.CustomHeaders.AddValue(StrSplit[0], StrSplit[1]);
            Finally
              Inc(C);
            End;
          UNTIL (C >= HeaderList.Count);
        End;
      End;

      lHTTP.ConnectTimeout:= Self.FConnectTimeOutEmSegundos * 1000;
      lHTTP.ReadTimeout:= Self.FReadTimeoutEmSegundos * 1000;

      // Send request
      case AnsiIndexStr(UpperCase(Self.FMethod),
             [Id_HTTPMethodGet, Id_HTTPMethodPost, Id_HTTPMethodPut,
              Id_HTTPMethodHead, Id_HTTPMethodDelete, Id_HTTPMethodTrace,
              Id_HTTPMethodOptions, Id_HTTPMethodConnect, Id_HTTPMethodPatch]) of
        0: Resposta:= lHTTP.Get(EnderecoWEB);
        1: Resposta:= lHTTP.Post(EnderecoWEB, Params);
        2: Resposta:= lHTTP.Put(EnderecoWEB, Params);
        3: lHTTP.Head(EnderecoWEB);
        4: Resposta:= lHTTP.Delete(EnderecoWEB);
        5: lHTTP.Trace(EnderecoWEB, Params);
        6: lHTTP.Options(EnderecoWEB, Params);
        7: lHTTP.Connect(EnderecoWEB);
        8: Resposta:= lHTTP.Patch(EnderecoWEB, Params);
        else Resposta:= lHTTP.Post(EnderecoWEB, Params);
      end;

      if Self.FRespostaDecodeUTF8 then
        Resposta:= UTF8Decode(Resposta);

      Result:= TRUE;

      StatusCode_HTTP:= lHTTP.ResponseCode;
      StatusCode_Interno:= Uteis.Str2Num(Uteis.ReturnValor_EmJSON(Resposta, 'statusCode'));

    Except
      On E: Exception do Begin
        Result:= FALSE;

        StatusCode_HTTP:= lHTTP.ResponseCode;

        If E is EIdHTTPProtocolException Then Begin
          ExIdHttp:= EIdHTTPProtocolException(E);

          Resposta:= ExIdHttp.ErrorMessage;

          StatusCode_HTTP:= ExIdHttp.ErrorCode;
          StatusCode_Interno:= Uteis.Str2Num(Uteis.ReturnValor_EmJSON(Resposta, 'statusCode'));

          Result:= StatusCode_Interno > 0;
        End;
      End;
    End;

  Finally
    Try
      FreeAndNil(LHandler);
    Except
    End;

    Try
      FreeAndNil(Params);
    Except
    End;

    Try
      FreeAndNil(lHTTP);
    Except
    End;

    Try
      FreeAndNil(StrSplit);
    Except
    End;

    Try
      FreeAndNil(HeaderList);
    Except
    End;

    Try
      FreeAndNil(IdEncoder);
    Except
    End;
  End;

end;

end.
