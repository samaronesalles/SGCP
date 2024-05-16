unit Uteis;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
     Vcl.Forms, Vcl.Controls, Vcl.Grids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
     Vcl.Dialogs, System.JSON, Winapi.WinInet;

function  ReturnMachineName: String;
function  MicroDesenvolvimento: Boolean;
function  MicroDesenv_Temporario: Boolean;

function  temConexaoDeInternet: Boolean;
function  iff(Condicao: Boolean; ValorQuando_TRUE, ValorQuando_FALSE: OleVariant): OleVariant;

Procedure SayError(Texto: String);
Procedure SayInfo(Texto: String);
function  SayQuestion(const aCaption: String; const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton: Integer; HelpCtx: Longint): Integer;

function  Hoje: String;

function  BooleanToStr(BoolVar: Boolean): String;
function  CharToBoolean (St: String): Boolean;

function  Str2Num(NumSt: String): Longint;

function  GetJsonValue(JSON, ValorPesquisado: WideString; VAR Resposta, Erro: WideString): Boolean;
function  ReturnValor_EmJSON(JSON, AtributoProcurado: String): String;
function  ConverteTextoToJson(Texto : String) : String;
function  ConverteTextoToJson_ByOpcoes(Texto : String; NullSeVazio : Boolean) : String;
function  ConverteBooleanToJson(Valor : Boolean) : String;

function  UpperKEY (Ch: Char): Char;
function  LowerKEY (Ch: Char): Char;

procedure SetValorToMaskEdit(edit: TMaskedit; valor: String);

procedure OnlyNumbersAccepted (Var Key: Char; AceitarPontoOuVirgula: Boolean; AceitarNegativo: Boolean);
procedure OnlyNumeroLetrasAccepted (Var Key: Char);
function  OnlyNumbersOnString ( Valor : String ) : String;
function  OnlyLetrasOnString ( Valor : String ) : String;

function  Substitua(VAR Texto: String; ValorOriginal, NovoValor: String): Boolean;
function  StrReplace(Texto, ValorOriginal, NovoValor: String): String;

procedure bSleep (MiliSegundos: Longint);

procedure StringGridDeleteRow (AStringGrid: TStringGrid; ARow: integer);
procedure StringGridDelete_AllRows (AStringGrid: TStringGrid);

implementation

function temConexaoDeInternet: Boolean;
begin
  result:= InternetCheckConnection('https://www.google.com/', 1, 0);
end;

function iff(Condicao: Boolean; ValorQuando_TRUE, ValorQuando_FALSE: OleVariant): OleVariant;
begin
   Result:= ValorQuando_FALSE;
   If Condicao Then
     Result:= ValorQuando_TRUE;
end;

Procedure SayError(Texto: String);
begin
  MessageDlg(Texto, MTError, [MBOK], 0);
end;

Procedure SayInfo(Texto: String);
begin
  MessageDlg(Texto, MTInformation, [MBOK], 0);
end;

function Hoje: String;
var
  A,D,M                              : Word;
  A_S,D_S,M_S                        : String[4];
  Dt                                 : TSystemTime;

begin

  GetLocalTime(Dt);

  D:= Dt.wDay;
  A:= Dt.wYear;
  M:= Dt.WMonth;

  A_S:= Inttostr(A);
  M_S:= Inttostr(M);
  D_S:= InttoStr(D);

  if D < 10 Then
    D_S:= '0' + Inttostr(D);

  if M < 10 Then
    M_S:= '0' + Inttostr(M);

  Hoje:= D_S + '/' + M_S + '/' + A_S;

end;

{ Exemplo: if SayQuestion( 'Please confirm', 'Do you want to format your harddisk now?', mtConfirmation, mbYesNoCancel, mrno, 0 ) = mrYes then }
function SayQuestion(const aCaption: String; const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton: Integer; HelpCtx: Longint): Integer;
var
  i   : Integer;
  btn : TButton;
begin

  with CreateMessageDialog(Msg, DlgType, Buttons) do begin
    try
      Caption := aCaption;
      HelpContext := HelpCtx;
      for i:= 0 to ComponentCount - 1 do begin
        if Components[i] is TButton then begin
          btn:= TButton(Components[i]);
          btn.Default:= btn.ModalResult = DefButton;

          if btn.Default then
            ActiveControl := Btn;
        end;
      end;

      Result := ShowModal;
    finally
      Free;
    end;
  end;

end;

function Str2Num(NumSt: String): Longint;
begin
  result:= StrToInt64Def(NumSt, 0);
end;

function GetJsonValue(JSON, ValorPesquisado: WideString; VAR Resposta, Erro: WideString): Boolean;
var
  JSonObject: TJSONObject;
  JSonValue: TJSONValue;
  JSonArray: TJsonArray;
  ListaArray: TStringList;
  Chave: String;
  Posicao: Integer;
begin

  Resposta:= JSON;
  Erro:= '';

  if Trim(JSON) = '' then
    Exit;

  if Trim(ValorPesquisado) = '' then
    Exit;

  Chave:= ValorPesquisado;
  Posicao:= Pos('.', ValorPesquisado);

  if Posicao = 0 then begin
    ValorPesquisado:= '';
  end else begin
    Chave:= Copy(Chave, 1, Posicao - 1);
    ValorPesquisado:= StringReplace(ValorPesquisado, Chave + '.', '', []);
  end;

  try
    try
      ListaArray:= TStringList.Create;
      JSonObject:= nil;
      JSonObject:= TJSONObject.ParseJSONValue(json) as TJSONObject;

      //Caso o delphi nao consiga fazer o parse do JSON, é um json inválido e reporto o erro
      if JSonObject = nil then
        raise Exception.Create('JSON inválido.');

      JSonValue:= JSONObject.GetValue(Chave);

      //Se a a chave não for encontrada, reporto o erro.
      if JSonValue = nil then
        raise Exception.Create('Chave "' + Chave + '" não encontrada.');

      if JSonValue is TJSONObject then begin
        if ValorPesquisado = '' then begin
          //Se a chave pesquisada é um objeto, já tenho a resposta e posso sair;
          GetJsonValue(JSonValue.ToString, ValorPesquisado, Resposta, Erro);
          Result:= true;
          Exit;
        end else
          //Se a chave pesquisada é uma chave DENTRO de objeto, volto na função para buscar o valor.
          Result:= GetJsonValue(JSonValue.ToString, ValorPesquisado, Resposta, Erro);
      end else if JSonValue is TJSONArray then begin
        JSonArray:= JSonValue as TJSONArray;

        //Se a chave é um array, percorro este array para montar a resposta.
        for JSonValue in JSonArray do begin
          if (JSonValue is TJSONArray) or (JSonValue is TJSONObject) then
            ListaArray.Add(JSonValue.ToString)
          else
            ListaArray.Add(JSonValue.Value);
        end;

        Resposta:= ListaArray.Text;
        Result:= true;
      end else begin
        //Se a chave nao é array nem objeto, retorno seu valor diretamente.
        Resposta:= JSonValue.Value;
        Result:= true;
      end;
    except
      on E: Exception do begin
        Resposta:= '';
        Erro:= E.Message;
        Result:= false;
      end;
    end;
  finally
    try
      FreeAndNil(ListaArray);
    except
    end;
    try
      FreeAndNil(JSonObject);
    except
    end;
  end;
end;

function BooleanToStr(BoolVar: Boolean): String;
begin
  If BoolVar Then
    Result:= 'True'
  Else
    Result:= 'False';
end;

function CharToBoolean (St: String): Boolean;
begin
  St:= St + 'F';

  If AnsiUpperCase(Copy(St, 1, 1)) = 'T'  Then
    Result:= TRUE
  Else
    Result:= FALSE;
end;

function ReturnValor_EmJSON(JSON, AtributoProcurado: String): String;
var
  St, Erro                                                                      : WideString;

begin

  Result:= '';

  Try
    // Caso o json passado seja uma lista, a DLL não conseguiu entender. Então deu um nome de atributo para ele para que ela consiga ler o conteúdo.
    If Pos('[', Trim(JSON)) = 1 Then Begin
      JSON:= '{"dados": ' + JSON + '}';
      AtributoProcurado:= 'dados';
    End;

    If NOT GetJsonValue(JSON, AtributoProcurado, St, Erro) Then Begin
      Result:= '';
      Exit;
    End;

    Result:= St;
  Except
    Result:= '';
  End;

end;

function Substitua(VAR Texto: String; ValorOriginal, NovoValor: String): Boolean;
var
  Posicao, C                                             : Longint;
  TextoAUX                                               : String;

begin

  Result:= FALSE;

  If ValorOriginal = NovoValor Then Begin
    Result:= TRUE;
    Exit;
  End;

  TextoAUX:= Texto;
  C:= 0;

  Repeat
    Posicao:= Pos(ValorOriginal, Texto);

    If Posicao > 0 Then Begin
      Delete(Texto, Posicao, Length(ValorOriginal));
      Delete(TextoAUX, (Posicao + C), Length(ValorOriginal));

      Insert(NovoValor, TextoAUX, (Posicao + C));
      C:= C + Length(NovoValor);
    End;
  Until Posicao <= 0;

  Texto:= TextoAUX;

  Result:= TRUE;

end;

function StrReplace(Texto, ValorOriginal, NovoValor: String): String;
var
  St                                                     : String;

begin

  Result:= Texto;

  St:= Texto;
  If NOT Substitua(St, ValorOriginal, NovoValor) Then
    Exit;

  Result:= St;

end;

procedure bSleep (MiliSegundos: Longint);
var
  C                                                      : LongInt;

begin

  If MiliSegundos <= 0 Then
    Exit;

  C:= 0;

  WHILE C < MiliSegundos Do Begin
    Sleep(10);

    Application.ProcessMessages;
    C:= C + 10;
  END;

end;

function ConverteTextoToJson(Texto : String) : String;
begin
  Result:= ConverteTextoToJson_ByOpcoes(Texto, FALSE);
end;

function ConverteTextoToJson_ByOpcoes(Texto : String; NullSeVazio : Boolean) : String;
begin

  Result:= 'null';

  If Texto = 'null' Then
    Exit;

  If (Texto = '') AND NullSeVazio Then
    Exit;

  Substitua(Texto, '\', '\\');
  Substitua(Texto, '"', '\"');

  Result:= '"' + Texto + '"';

end;

function ConverteBooleanToJson(Valor : Boolean) : String;
begin
  If Valor Then
    Result:= 'true'
  Else
    Result:= 'false';
end;

procedure StringGridDeleteRow (AStringGrid: TStringGrid; ARow: integer);
var
  nRow: integer;

begin

  with AStringGrid do
    begin
      for nRow:= ARow to RowCount - 2 do
        Rows[nRow].Assign(Rows[nRow + 1]);

//      Rows[RowCount - 1].Clear;
//      RowCount:= RowCount - 1
    end;

end;

procedure StringGridDelete_AllRows (AStringGrid: TStringGrid);
var
  nRow: integer;

begin

  if AStringGrid.RowCount = AStringGrid.FixedRows then
    Exit;

  for nRow:= AStringGrid.RowCount - 1 downto AStringGrid.FixedRows do
    StringGridDeleteRow (AStringGrid, nRow);

end;

function UpperKEY (Ch: Char): Char;
var
  St     : String;

begin
  St:= ' ';
  St[1]:= Ch;

  St:= AnsiUpperCase(St);

  Result:= St[1];
end;


function LowerKEY (Ch: Char): Char;
var
  St     : String;

begin
  St:= ' ';
  St[1]:= Ch;

  St:= AnsiLowerCase(St);

  Result:= St[1];
end;

procedure OnlyNumbersAccepted (Var Key: Char; AceitarPontoOuVirgula: Boolean; AceitarNegativo: Boolean);
var
  St      : String;

begin

  St:= '0123456789' + Chr(8);

  If AceitarPontoOuVirgula then
    St:= St + '.,';

  If AceitarNegativo Then
    St:= St + '-';

  If Pos(Key, St) = 0 Then
    Key:= #0;

end;

procedure OnlyNumeroLetrasAccepted (Var Key: Char);
var
  St      : String;

begin

  Key:= UpperKEY(Key);
  St:= '0123456789 ABCDEFGHIJKLMNOPQRSTUVXYWZ' + Chr(8);

  If Pos(Key, St) = 0 Then
    Key:= #0;

end;

function OnlyNumbersOnString (Valor: String): String;
var
  C      : Longint;
  St     : String;

begin

  Result:= '';

  St:= Valor;
  if Length(St) = 0 then
    Exit;

  C:= 1;
  repeat
    if Pos(St[C], '0123456789') = 0 then
      Delete(St, C, 1)
    else
      Inc(C);
  until C > Length(St);

  Result:= St;

end;


function OnlyLetrasOnString ( Valor : String ) : String;
var
  C      : Longint;
  St     : String;

begin

  Result:= '';

  St:= Valor;
  If Length(St) = 0 Then
    Exit;

  C:= 1;
  repeat
    If Pos(St[C], ' ABCDEFGHIJKLMNOPQRSTUVXYWZabcdefghijklmnopqrstuvxywz') = 0 Then
      Delete(St, C, 1)
    Else
      Inc(C);
  until C > Length(St);

  Result:= St;

end;

procedure SetValorToMaskEdit(edit: TMaskedit; valor: String);
var
  mask                             : String;

begin

  mask:= edit.EditMask;

  edit.EditMask:= '';
  edit.Text:= valor;

  edit.EditMask:= Mask;

end;

function ReturnMachineName: String;
var
  Buffer                                   : Array[0..255] of char;
  Size                                     : DWord;
begin

  Size:= 256;

  If GetComputerName(Buffer, Size) Then
    Result:= AnsiUpperCase(Buffer)
  Else
    Result:= '';

end;

function MicroDesenvolvimento: Boolean;
begin
  Result:= ((Trim(ReturnMachineName()) = 'SAMARONE-NOTE') AND (FileExists('C:\DELPHI\MICRDESENSAMA.CFG')));
end;

function MicroDesenv_Temporario: Boolean;
const
  DiaDeValidade = '15/05/2024';
begin
  Result:= ((MicroDesenvolvimento()) AND (Hoje() = DiaDeValidade));
end;

end.
