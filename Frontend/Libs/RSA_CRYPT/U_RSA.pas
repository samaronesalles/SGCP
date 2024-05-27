unit U_RSA;

interface

uses
  System.SysUtils, System.Math, System.StrUtils, System.Classes, System.NetEncoding;

type
  TRSAKey = record
    Exponent: Integer;
    Modulus: Integer;
  end;

function  StringToRSAKey (Key: String): TRSAKey;
function  PowerMod (Base, Exponent, Modulus: Integer): Integer;

function  EncodeRSA (decoded_message: String; PublicKey: String): String;
function  DecodeRSA (encoded_message: String; PrivateKey: String): String;

procedure GenerateRSAKeys (out PublicKey, PrivateKey: String);

implementation

uses Uteis;

function StringToRSAKey (Key: String): TRSAKey;
var
  Parts                                         : TArray<String>;

begin

  Key:= TNetEncoding.Base64.Decode(Key);

  Parts:= Key.Split([':']);

  if Length(Parts) <> 2 then
    raise Exception.Create('Invalid key format. Expected format: Exponent:Modulus');

  Result.Exponent:= StrToInt(Parts[0]);
  Result.Modulus:= StrToInt(Parts[1]);

end;

function PowerMod (Base, Exponent, Modulus: Integer): Integer;
begin

  Result:= 1;
  Base:= Base mod Modulus;

  while Exponent > 0 do begin
    if (Exponent mod 2) = 1 then
      Result:= (Result * Base) mod Modulus;

    Exponent:= Exponent shr 1;
    Base:= (Base * Base) mod Modulus;
  end;

  Result:= Result;

end;

function EncodeRSA (decoded_message: String; PublicKey: String): String;
var
  PublicKeyParts                                : TRSAKey;
  i                                             : Integer;
  Code                                          : Integer;
  EncodedPart                                   : String;
  EncodedMessage                                : TStringList;

begin

  PublicKeyParts:= StringToRSAKey(PublicKey);
  EncodedMessage:= TStringList.Create;

  try
    for i:= 1 to Length(decoded_message) do begin
      Code:= Ord(decoded_message[i]);
      EncodedPart:= IntToStr(PowerMod(Code, PublicKeyParts.Exponent, PublicKeyParts.Modulus));

      EncodedMessage.Add(EncodedPart);
    end;

    Result:= TNetEncoding.Base64.Encode(EncodedMessage.DelimitedText);
  finally
    EncodedMessage.Free;
  end;

end;

function DecodeRSA (encoded_message: String; PrivateKey: String): String;
var
  PrivateKeyParts                               : TRSAKey;
  EncodedParts                                  : TArray<String>;
  i                                             : Integer;
  Code                                          : Integer;
  DecodedChar                                   : Char;
  DecodedMessage                                : TStringBuilder;

begin

  encoded_message:= TNetEncoding.Base64.Decode(encoded_message);

  PrivateKeyParts:= StringToRSAKey(PrivateKey);
  EncodedParts:= encoded_message.Split([',']);
  DecodedMessage:= TStringBuilder.Create;

  try
    for i:= 0 to Length(EncodedParts) - 1 do begin
      Code:= StrToInt(EncodedParts[i]);
      DecodedChar:= Chr(PowerMod(Code, PrivateKeyParts.Exponent, PrivateKeyParts.Modulus));

      DecodedMessage.Append(DecodedChar);
    end;

    Result:= DecodedMessage.ToString;
  finally
    DecodedMessage.Free;
  end;

end;

procedure GenerateRSAKeys (out PublicKey, PrivateKey: String);
var
  p, q, n, phi, e, d                            : Integer;

  function GCD (a, b: Integer): Integer;
  begin
    while b <> 0 do begin
      Result:= a mod b;
      a:= b;
      b:= Result;
    end;

    Result:= a;
  end;

  function ModInverse (a, m: Integer): Integer;
  var
    m0, t, q           : Integer;
    x0, x1             : Integer;
  begin
    m0:= m;
    t:= 0;
    x0:= 0;
    x1:= 1;

    if (m = 1) then
      Exit(0);

    while (a > 1) do begin
      q:= a div m;
      t:= m;
      m:= a mod m;
      a:= t;
      t:= x0;
      x0:= x1 - q * x0;
      x1:= t;
    end;

    if (x1 < 0) then
      x1:= x1 + m0;

    Result:= x1;
  end;

begin

  p:= 151; // 61;                    // Prime number
  q:= 97;  // 53;                    // Prime number
  n:= p * q;
  phi:= (p - 1) * (q - 1);
  e:= 17;                    // Public exponent (must be coprime with phi)
  d:= ModInverse(e, phi);    // Private exponent

  PublicKey:= TNetEncoding.Base64.Encode(IntToStr(e) + ':' + IntToStr(n));
  PrivateKey:= TNetEncoding.Base64.Encode(IntToStr(d) + ':' + IntToStr(n));

end;

end.
