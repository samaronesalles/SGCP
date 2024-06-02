unit Uteis;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
     Vcl.Forms, Vcl.Controls, Vcl.Grids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
     Vcl.Dialogs, System.JSON, System.DateUtils, Winapi.WinInet, U_ExceptionTratado,
     System.Variants, ShellAPI, System.StrUtils, Vcl.Graphics, Vcl.ExtCtrls,
     SynPDF, RichEdit, Registry;

function  ReturnMachineName: String;
function  MicroDesenvolvimento: Boolean;
function  MicroDesenv_Temporario: Boolean;

function  temConexaoDeInternet: Boolean;
function  iff(Condicao: Boolean; ValorQuando_TRUE, ValorQuando_FALSE: OleVariant): OleVariant;

Procedure SayError(Texto: String);
Procedure SayInfo(Texto: String);
function  SayQuestion(const aCaption: String; const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton: Integer; HelpCtx: Longint): Integer;

function  Hoje: String;
function  CheckDate(datastr: String): Boolean;
function  DateTime2Str(dataHora: TDateTime): String;
function  DateTime2Str_UTC(dataHora: TDateTime): String;
function  DateTimeUTC2TDatetime(dataHoraSt: String): TDateTime;
procedure RetornaDiasDaSemana (DataBase: TDate; var Dom, Seg, Ter, Qua, Qui, Sex, Sab: TDate);
procedure RetornaIntervaloDaSemana (DataBase: TDate; var Dom, Sab: TDate);
function  RetornaDiaSemanaNaSemana (DataBase: TDate; DiaSemanaDesejado: Word): TDate;
function  FormatDate(data: String): String;

function  CheckTime(Timestr: String): Boolean;

function  BooleanToStr(BoolVar: Boolean): String;
function  CharToBoolean (St: String): Boolean;

function  Replicate (xChar: String; xQtde: Word): String;

function  FillLeft (tam, Num: Longint): String;
function  isNum (Numero: String): Boolean;
function  Str2Num (NumSt: String): Longint;

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

procedure SetCorRowgrid(Grid: TStringGrid; CorFont, CorLinha: TColor; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
procedure StringGridDeleteRow (AStringGrid: TStringGrid; ARow: integer);
procedure StringGridDelete_AllRows (AStringGrid: TStringGrid);

function  RichEdit_SaveToFile (FilePath: String; var RichEdit: TRichEdit): Boolean;
function  RichEdit_GetText (FilePath: String; var RichEdit: TRichEdit): String;
procedure RichEdit_SetText (Texto: String; var RichEdit: TRichEdit);

function  READ_TXTFILE_FIELD (CaracterSeparador: Char; VAR Linha: String): String;
procedure READ_TXTFILE_FIELDS (CaracterSeparador: Char; Linha: String; VAR Fields: TStringList);

function  Qde_Pos (Subst: String; Texto: String): Longint;
function  LastPos (Substr: String; S: String): Longint;
function  FORMATPATH (Path: String): String;

procedure RoundCornerOf (Control: TWinControl);

function  RetornaPrimeiroNome (NomeCompleto: String): String;
function  RetornaPrimeiroMaisUltimoNome (NomeCompleto: String): String;

procedure AbrirArquivoRFT_PDF (FilePath: String);
procedure AbrirArquivoRFT_WORD (FilePath: String);

procedure StrinArrayAdd(var stArray: TArray<String>; valor: String);

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

function CheckDate(datastr: String): Boolean;
begin
  Try
    StrToDate(datastr);
    Result:= TRUE
  Except
    Result:= FALSE;
  End;
end;

function DateTime2Str(dataHora: TDateTime): String;
begin
  Try
    Result:= FormatDateTime('dd/mm/yyyy hh:nn:ss', dataHora);
  Except
    Result:= '';
  End;
end;

function DateTime2Str_UTC(dataHora: TDateTime): String;
begin
  Result:= System.DateUtils.DateToISO8601(datahora);
end;

function DateTimeUTC2TDatetime(dataHoraSt: String): TDateTime;
begin
  Try
    Result:= ISO8601ToDate(dataHoraSt);
  Except
    Result:= 0;
  End;
end;

procedure RetornaDiasDaSemana (DataBase: TDate; var Dom, Seg, Ter, Qua, Qui, Sex, Sab: TDate);
begin

  Dom:= 0;
  Seg:= 0;
  Ter:= 0;
  Qua:= 0;
  Qui:= 0;
  Sex:= 0;
  Sab:= 0;

  if DataBase <= 0 then
    Exit;

  case DayOfTheWeek(DataBase) of
       DaySunday: begin
                    Dom:= DataBase;
                    Seg:= IncDay(DataBase, 1);
                    Ter:= IncDay(DataBase, 2);
                    Qua:= IncDay(DataBase, 3);
                    Qui:= IncDay(DataBase, 4);
                    Sex:= IncDay(DataBase, 5);
                    Sab:= IncDay(DataBase, 6);
                  end;
       DayMonday: begin
                    Dom:= IncDay(DataBase, -1);
                    Seg:= DataBase;
                    Ter:= IncDay(DataBase, 1);
                    Qua:= IncDay(DataBase, 2);
                    Qui:= IncDay(DataBase, 3);
                    Sex:= IncDay(DataBase, 4);
                    Sab:= IncDay(DataBase, 5);
                  end;
      DayTuesday: begin
                    Dom:= IncDay(DataBase, -2);
                    Seg:= IncDay(DataBase, -1);
                    Ter:= DataBase;
                    Qua:= IncDay(DataBase, 1);
                    Qui:= IncDay(DataBase, 2);
                    Sex:= IncDay(DataBase, 3);
                    Sab:= IncDay(DataBase, 4);
                  end;
    DayWednesday: begin
                    Dom:= IncDay(DataBase, -3);
                    Seg:= IncDay(DataBase, -2);
                    Ter:= IncDay(DataBase, -1);
                    Qua:= DataBase;
                    Qui:= IncDay(DataBase, 1);
                    Sex:= IncDay(DataBase, 2);
                    Sab:= IncDay(DataBase, 3);
                  end;
     DayThursday: begin
                    Dom:= IncDay(DataBase, -4);
                    Seg:= IncDay(DataBase, -3);
                    Ter:= IncDay(DataBase, -2);
                    Qua:= IncDay(DataBase, -1);
                    Qui:= DataBase;
                    Sex:= IncDay(DataBase, 1);
                    Sab:= IncDay(DataBase, 2);
                  end;
       DayFriday: begin
                    Dom:= IncDay(DataBase, -5);
                    Seg:= IncDay(DataBase, -4);
                    Ter:= IncDay(DataBase, -3);
                    Qua:= IncDay(DataBase, -2);
                    Qui:= IncDay(DataBase, -1);
                    Sex:= DataBase;
                    Sab:= IncDay(DataBase, 1);
                  end;
     DaySaturday: begin
                    Dom:= IncDay(DataBase, -6);
                    Seg:= IncDay(DataBase, -5);
                    Ter:= IncDay(DataBase, -4);
                    Qua:= IncDay(DataBase, -3);
                    Qui:= IncDay(DataBase, -2);
                    Sex:= IncDay(DataBase, -1);
                    Sab:= DataBase;
                  end;
  end;

end;

procedure RetornaIntervaloDaSemana (DataBase: TDate; var Dom, Sab: TDate);
var
  Seg, Ter, Qua, Qui, Sex                 : TDate;
begin
  RetornaDiasDaSemana (DataBase, Dom, Seg, Ter, Qua, Qui, Sex, Sab);
end;

function RetornaDiaSemanaNaSemana (DataBase: TDate; DiaSemanaDesejado: Word): TDate;
var
  Seg, Ter, Qua, Qui, Sex, Sab, Dom       : TDate;

begin

  Result:= 0;

  if DataBase <= 0 then
    Exit;

  RetornaDiasDaSemana (DataBase, Dom, Seg, Ter, Qua, Qui, Sex, Sab);

  case DiaSemanaDesejado of
       DaySunday: Result:= Dom;
       DayMonday: Result:= Seg;
      DayTuesday: Result:= Ter;
    DayWednesday: Result:= Qua;
     DayThursday: Result:= Qui;
       DayFriday: Result:= Sex;
     DaySaturday: Result:= Sab;
  end;

end;

function FormatDate(data: String): String;
var
  Dia, Mes, Ano       : Word;
  Dt                  : String;

begin

  Result:= '';

  if Data = '' then
    Exit;

  if (Pos('/', Data) = 0) AND (Length(Data) <> 8) then
    Exit;

  if Pos('/', Data) = 0 Then Begin
    if NOT isNum(Data) Then
      Exit;

    Insert('/', Data, 3);
    Insert('/', Data, 6);
  end;

  Repeat
    if Pos(' ', Data) <> 0 then
      Delete(Data, Pos(' ', Data), 1);
  Until Pos(' ', Data) = 0;

  Dia:= Str2Num(Copy(Data, 1, Pos('/', Data) - 1));
  Delete(Data, 1, Pos('/', Data));

  Mes:= Str2Num(Copy(Data, 1, Pos('/', Data) - 1));
  Delete(Data, 1, Pos('/', Data));

  Ano:= Str2Num(Data);

  if (Dia = 0) AND (Mes = 0) then
    if Ano = 0 then begin
      Result:= Hoje;
      Exit;
    end;

  if (Dia = 0) OR (Dia > 31) then
    Dia:= Str2Num(Copy(Hoje, 1, 2));

  if (Mes = 0) OR (Mes > 12) then
    Mes:= Str2Num(Copy(Hoje, 4, 2));

  if (Ano = 0) then
    Ano:= Str2Num(Copy(Hoje, 9, 2));

  if Ano < 1000 then begin
    if Ano < 60 then
      Ano:= Ano + 2000
    else
      Ano:= Ano + 1900;
  end;

  Dt:= FillLeft(2, Dia) + '/' + FillLeft(2, Mes) + '/' + FillLeft(4, Ano);

  If Not CheckDate(Dt) Then
    Dt:= Hoje;

  Result:= Dt;

end;

function CheckTime(Timestr: String): Boolean;
var
  Timesplit                 : TArray<String>;

begin
  try
    Result:= FALSE;

    Timesplit:= SplitString(Timestr, ':');

    if Length(Timesplit) < 2 then
      Exit;

    if Length(Trim(Timesplit[0])) <> 2 then
      Exit;

    if Length(Trim(Timesplit[1])) <> 2 then
      Exit;

    StrToTime(Timestr);
    Result:= TRUE;
  except
    Result:= FALSE;
  end;
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

    if St = 'null' then
      St:= '';

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
var
  i                                         : Integer;
  C                                         : Char;
  resultStr                                 : String;

begin

  Result:= 'null';

  If Texto = 'null' Then
    Exit;

  If (Texto = '') AND NullSeVazio Then
    Exit;

  resultStr := '';

  for i:= 1 to Length(Texto) do begin
    C:= Texto[i];

    case C of
      '"': resultStr := resultStr + '\"';
      '\': resultStr := resultStr + '\\';
      #8: resultStr := resultStr + '\b';   // backspace
      #9: resultStr := resultStr + '\t';   // tab
      #10: resultStr := resultStr + '\n';  // newline
      #12: resultStr := resultStr + '\f';  // form feed
      #13: resultStr := resultStr + '\r';  // carriage return
      else
        if Ord(C) < 32 then
          resultStr := resultStr + '\u' + IntToHex(Ord(C), 4)
        else
          resultStr := resultStr + C;
    end;
  end;

  Result:= '"' + resultStr + '"';

end;

function ConverteBooleanToJson(Valor : Boolean) : String;
begin
  If Valor Then
    Result:= 'true'
  Else
    Result:= 'false';
end;

procedure SetCorRowgrid(Grid: TStringGrid; CorFont, CorLinha: TColor; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  yCalc                                                                 : integer;
  Texto                                                                 : String;
  lCanvas                                                               : TCanvas;

begin

  { Salva em variáveis locais por questão de clareza do código }
  texto:= Grid.Cells[ACol, ARow];
  lCanvas:= Grid.Canvas;

  if gdFixed in State then begin
    { Cor do fonte e de fundo para linhas e colunas fixas }
    lCanvas.Font.Color:= clWhite;
    lCanvas.Font.Style:= [TFontStyle.fsBold];

    lCanvas.Brush.Color:= Grid.FixedColor;
  end else begin
    if gdSelected in State then begin
      { Cor do fonte e de fundo para linhas e colunas selecionadas }
      lCanvas.Font.Color:= clWhite;
      lCanvas.Brush.Color:= clHighlight;
    end else begin
      { Cor do fonte e de fundo para linhas e colunas com dados }
      lCanvas.Font.Color:= CorFont;
      lCanvas.Brush.Color:= CorLinha;
    end;
  end;

  { Preenche com a cor de fundo }
  lCanvas.FillRect(Rect);

  { Calcula posição para centralizar o texto na vertical }
  yCalc:= lCanvas.TextHeight (texto);
  yCalc:= Rect.Top + (Rect.Bottom - Rect.Top - yCalc) div 2;

  lCanvas.TextRect (Rect, Rect.Left + 3, yCalc, texto);

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
  DiaDeValidade = '17/06/2024';
begin
  Result:= ((MicroDesenvolvimento()) AND (StrToDateDef(Hoje(), 0) <= StrToDateDef(DiaDeValidade, 0)));
end;

function RichEdit_GetText (FilePath: String; var RichEdit: TRichEdit): String;
var
  Stream                     : TFileStream;
  FileText                   : TStringlist;

begin

  Result:= '';

  Stream:= Nil;
  FileText:= Nil;

  try
    try
      FileText:= Tstringlist.Create();

      try
        Stream:= TFileStream.Create(FilePath, fmCreate);
        RichEdit.Lines.SaveToStream(Stream);
      finally
        Stream.Free();
      end;

      FileText.LoadFromFile(FilePath);
      Result:= FileText.Text;
    except
      on E: Exception do begin
        if MicroDesenvolvimento() then
          SayError('"RichEdit_GetText" erro: ' + E.Message);

        Result:= '';
      end;
    end;
  finally
    if FileExists(FilePath) then
      DeleteFile(FilePath);

    FileText.Free();
  end;

end;

procedure RichEdit_SetText (Texto: String; var RichEdit: TRichEdit);
var
  Stream                     : TStringStream;

begin

  try
    try
      RichEdit.Lines.Clear();

      Stream:= TStringStream.Create(Texto);

      RichEdit.Lines.LoadFromStream(Stream);
    except
      RichEdit.Lines.Clear();
    end;
  finally
    Stream.Free;
  end;

end;

function READ_TXTFILE_FIELD (CaracterSeparador: Char; VAR Linha: String): String;
var
  Leitura                   : String;

begin

  Result:= '';

  If Pos(CaracterSeparador, Linha) = 0 Then
    Exit;

  If Pos(CaracterSeparador, Linha) = 1 Then Begin
    Delete(Linha, 1, 1);
    Leitura:= Copy(Linha, 1, Pos(CaracterSeparador, Linha));

    Delete(Leitura, Length(Leitura), 1);
    Leitura:= Trim(Leitura);

    Delete(Linha, 1, Pos(CaracterSeparador,Linha));
    Result:= Leitura;
  End Else Begin
    Delete(Linha, 1, Pos(CaracterSeparador,Linha));
  End;

end;

procedure READ_TXTFILE_FIELDS (CaracterSeparador: Char; Linha: String; VAR Fields: TStringList);
var
  St      : String;
begin

  Fields.Clear;

  REPEAT
    St:= Read_TXTFILE_FIEld(CaracterSeparador, Linha);
    Fields.Add(St);
  UNTIL (Linha = '') or (Pos(CaracterSeparador, Linha) = 0);

end;

function Qde_Pos (Subst: String; Texto: String): Longint;
var
  St                         : String;
  Posicao, Qde               : Longint;

begin

  Result:= 0;

  if Length(Subst) = 0 then
    Exit;

  if Length(Texto) = 0 then
    Exit;

  if Length(Subst)>Length(Texto) then
    Exit;

  Posicao:= 1;
  Qde:= 0;

  St:= '';
  REPEAT
    St:= St + Copy(Texto, Posicao, 1);

    If Pos(Subst, St) <> 0 Then
      Inc(Qde);

    If Length(St) = Length(Subst) Then
      Delete(St, 1, 1);

    Inc(Posicao);
  UNTIL Posicao > Length(Texto);

  Result:= QDE;

end;

function LastPos (Substr: String; S: String): Longint;
var
  C              : Longint;
  ToCheck        : String;

begin

  Result:= 0;

  if Length(S) = 0 then
    Exit;

  C:= Length(S);
  REPEAT
    ToCheck:= Copy(S, C, Length(S) + 1);

    if Pos(Substr, ToCheck) = 1 then begin
      Result:= C;
      Exit;
    end;

    Dec(C);
  UNTIL C <= 0;

end;

function FORMATPATH(Path: String): String;
var
  CH                       : String[2];
begin

  CH:= Copy(Path, Length(Path), 1);

  if Ch <> '\' then
    Path:= Path + '\';

  if Path = '\' then
    Path:= '';

  FormatPath:= Path;

end;

function Replicate (xChar: String; xQtde: Word): String;
Var
  X           : Word;
  xRet        : String;

Begin

  Result:= '';

  if xQtde = 0 then
    Exit;

  xRet:= '';
  For x:= 1 to xQtde Do
    xRet:= xRet + xChar;

  Result:= xRet;

End;

function FillLeft (tam, Num: Longint): String;
begin
  Result:= FormatFloat(Replicate('0', tam), Num);
end;

// Retorna True se a string for um número e falso se não. (NAO Aceita negativo)
function isNum (Numero: String): Boolean;
var
  C                         : Word;

begin

  if Length(Numero) = 0 then begin
    Result:= False;
    Exit;
  end;

  Result:= True;
  C:= 1;

  Repeat
    if Pos(Numero[C], '0123456789') = 0 then begin
      Result:= False;
      Exit;
    end;

    Inc(C);
  Until C > Length(Numero);

END;

procedure RoundCornerOf(Control: TWinControl);
var
  R                              : TRect;
  Rgn                            : HRGN;

begin

 with Control do begin
   R:= ClientRect;
   rgn:= CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);

   Perform (EM_GETRECT, 0, lParam(@r));
   InflateRect (r, - 4, - 4);

   Perform (EM_SETRECTNP, 0, lParam(@r));
   SetWindowRgn(Handle, rgn, True);

   Invalidate;
 end;

end;

function RetornaPrimeiroNome (NomeCompleto: String): String;
var
  Nomes                          : TArray<String>;

begin

  Result:= '';

  NomeCompleto:= Trim(NomeCompleto);
  Nomes:= SplitString(NomeCompleto, ' ');

  if Length(Nomes) = 0 then
    Exit;

  Result:= Nomes[0];

end;

function RetornaPrimeiroMaisUltimoNome (NomeCompleto: String): String;
var
  Nomes                          : TArray<String>;
  PrimeiroNome, UltimoNome       : String;
begin

  Result:= '';

  NomeCompleto:= Trim(NomeCompleto);
  Nomes:= SplitString(NomeCompleto, ' ');

  if Length(Nomes) = 0 then
    Exit;

  PrimeiroNome:= Nomes[0];
  UltimoNome:= Nomes[High(Nomes)];

  Result:= PrimeiroNome + ' ' + UltimoNome;

end;

function RichEdit_SaveToFile (FilePath: String; var RichEdit: TRichEdit): Boolean;
var
  Stream                     : TFileStream;
  FileText                   : TStringlist;

begin

  Result:= FALSE;

  Stream:= Nil;
  FileText:= Nil;

  try
    try
      FileText:= Tstringlist.Create();

      try
        Stream:= TFileStream.Create(FilePath, fmCreate);
        RichEdit.Lines.SaveToStream(Stream);
      finally
        Stream.Free();
      end;

      Result:= FileExists(FilePath);
    except
      on E: Exception do begin
//        if MicroDesenvolvimento() then
//          SayError('"RichEdit_SaveToFile" erro: ' + E.Message);

        Result:= FALSE;
      end;
    end;
  finally
    FileText.Free();
  end;

end;

procedure AbrirArquivoRFT_PDF (FilePath: String);
const
  MarginTop                   = 50;    // Margem superior em pixels
  MarginBottom                = 50; // Margem inferior em pixels

var
  PDFFilePath                                    : String;
  PDFDoc                                         : TPdfDocumentGDI;
  RichEdit                                       : TRichEdit;
  PageBitmap                                     : TBitmap;
  PageWidth, PageHeight                          : Integer;
  CharRange                                      : TFormatRange;
  LastChar, CurrentChar                          : Integer;
  RenderDC                                       : HDC;
  PageRect                                       : TRect;
  ContentWidth, MarginLeft, MarginRight          : Integer;

begin

  if not FileExists(FilePath) then
    raise ExceptionTratado.Create('Arquivo RFT não encontrado.');

  // Caminho para o arquivo PDF temporário
  PDFFilePath:= ChangeFileExt(FilePath, '.pdf');

  // Criar um TRichEdit para carregar o conteúdo do RTF
  RichEdit:= TRichEdit.Create(nil);
  PDFDoc:= TPdfDocumentGDI.Create;
  PageBitmap:= TBitmap.Create;

  try
    RichEdit.Visible:= False;
    RichEdit.Parent:= Application.MainForm;
    RichEdit.Lines.LoadFromFile(FilePath);

    // Definir tamanho da página A4 em pixels (considerando 96 DPI)
    PageWidth:= 794;   // A4 width in pixels
    PageHeight:= 1123; // A4 height in pixels

    // Calcular as margens para centralizar o conteúdo
    ContentWidth:= PageWidth - 2 * 50; // Largura do conteúdo sem margem
    MarginLeft:= (PageWidth - ContentWidth) div 2;
    MarginRight:= MarginLeft;

    // Configurar o bitmap para renderizar o conteúdo do TRichEdit
    PageBitmap.Width:= PageWidth;
    PageBitmap.Height:= PageHeight;
    PageBitmap.Canvas.Font.Assign(RichEdit.Font);

    // Inicializar o TFormatRange
    FillChar(CharRange, SizeOf(TFormatRange), 0);
    RenderDC:= PageBitmap.Canvas.Handle;
    CharRange.hdc:= RenderDC;
    CharRange.hdcTarget:= RenderDC;

    CharRange.rc:= Rect (MarginLeft * 1440 div Screen.PixelsPerInch,
                         MarginTop * 1440 div Screen.PixelsPerInch,
                         (PageWidth - MarginRight) * 1440 div Screen.PixelsPerInch,
                         (PageHeight - MarginBottom) * 1440 div Screen.PixelsPerInch
                        );

    CharRange.rcPage:= Rect(0, 0,
                            PageWidth * 1440 div Screen.PixelsPerInch,
                            PageHeight * 1440 div Screen.PixelsPerInch
                           );

    CurrentChar:= 0;
    LastChar:= RichEdit.GetTextLen;

    // Renderizar cada página do RTF no PDF
    while CurrentChar < LastChar do begin
      PDFDoc.AddPage;
      CharRange.chrg.cpMin:= CurrentChar;
      CharRange.chrg.cpMax:= -1;

      // Renderizar no bitmap
      PageBitmap.Canvas.FillRect(Rect(0, 0, PageWidth, PageHeight));
      CurrentChar:= RichEdit.Perform(EM_FORMATRANGE, 1, Longint(@CharRange));

      // Desenhar o bitmap no PDF
      PageRect:= Rect(MarginLeft, MarginTop, PageWidth - MarginRight, PageHeight - MarginBottom);
      PDFDoc.VCLCanvas.StretchDraw(PageRect, PageBitmap);

      if CurrentChar <= CharRange.chrg.cpMin then
        Break;
    end;

    // Salvar o documento PDF
    PDFDoc.SaveToFile(PDFFilePath);
  finally
    RichEdit.Perform(EM_FORMATRANGE, 0, 0); // Libera a memória usada por EM_FORMATRANGE
    PageBitmap.Free;
    RichEdit.Free;
    PDFDoc.Free;
  end;

  // Abrir o arquivo PDF no leitor padrão de PDF
  if ShellExecute(0, 'open', PChar(PDFFilePath), nil, nil, SW_SHOWNORMAL) <= 32 then
    raise ExceptionTratado.Create('Não foi possível abrir o arquivo PDF no leitor padrão.');

end;

procedure AbrirArquivoRFT_WORD (FilePath: String);
var
  WordPath                                : String;
  Reg                                     : TRegistry;
  CommandLine                             : String;

begin

  if NOT FileExists(FilePath) then
    raise ExceptionTratado.Create('Arquivo RFT não encontrado.');

  // Verifica se o Microsoft Word está instalado
  Reg:= TRegistry.Create(KEY_READ);
  try
    Reg.RootKey:= HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Winword.exe') then
      WordPath:= Reg.ReadString('')
    else
      WordPath:= '';
  finally
    Reg.Free;
  end;

  // Se o Microsoft Word estiver instalado, abre o arquivo com ele
  if WordPath <> '' then begin
    CommandLine:= '"' + WordPath + '" "' + FilePath + '"';

    if ShellExecute(0, 'open', PChar(WordPath), PChar('"' + FilePath + '"'), nil, SW_SHOWNORMAL) <= 32 then
      raise ExceptionTratado.Create('Não foi possível abrir o arquivo RFT com o Microsoft Word.');
  end else begin
    if ShellExecute(0, 'open', 'write', PChar(FilePath), nil, SW_SHOWNORMAL) <= 32 then
      raise ExceptionTratado.Create('Não foi possível abrir o arquivo RFT com o WordPad.');
  end;

end;

procedure StrinArrayAdd(var stArray: TArray<String>; valor: String);
begin
  SetLength(stArray, Length(stArray) + 1);
  stArray[High(stArray)] := valor;
end;

end.
