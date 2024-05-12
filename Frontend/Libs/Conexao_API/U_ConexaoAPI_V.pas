unit U_ConexaoAPI_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, U_ConexaoAPI_M;

type
  TfrmConexaoAPI_V = class(TForm)
    ProgressBar: TProgressBar;
    Label_mensagem: TLabel;
    TimerStartUp: TTimer;
    procedure TimerStartUpTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    FAcao                               : TTipoAcaoAPI;

  public
    { Public declarations }

    property Acao                       : TTipoAcaoAPI Write FAcao;

    function Execute(Acao: TTipoAcaoAPI; mensagem: string): string;
  end;

var
  frmConexaoAPI_V: TfrmConexaoAPI_V;

implementation

uses U_frmMain, Uteis, U_ConexaoAPI_C;

{$R *.dfm}

{ TfrmConexaoAPI_V }

function TfrmConexaoAPI_V.Execute(Acao: TTipoAcaoAPI; mensagem: string): string;
var
  BkpBufferStr                              : String;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;
    frmMain.BufferStr:= '';

    if frmConexaoAPI_V = Nil then
      frmConexaoAPI_V:= TfrmConexaoAPI_V.Create(Application);

    frmConexaoAPI_V.Acao:= Acao;
    frmConexaoAPI_V.Label_mensagem.Caption:= mensagem;

    frmConexaoAPI_V.ShowModal;

    Result:= frmMain.BufferStr;

  Finally
    frmMain.BufferStr:= BkpBufferStr;
  End;

end;

procedure TfrmConexaoAPI_V.FormCreate(Sender: TObject);
begin

  Self.FAcao:= taNenhuma;

end;

procedure TfrmConexaoAPI_V.TimerStartUpTimer(Sender: TObject);
var
  ConexaoAPI_C                                            : TConexaoAPI_C;
  Retorno                                                 : TConexaoAPI_M;

begin

  TimerStartUp.Enabled:= FALSE;

  ConexaoAPI_C:= Nil;
  Retorno:= Nil;

  frmMain.BufferStr:= '';

  Try
    if NOT Uteis.temConexaoDeInternet() then begin
      Uteis.SayError('Não foi encontrada conexão com internet. Verifique!');
      Exit;
    end;

    ConexaoAPI_C:= TConexaoAPI_C.Create(Self.FAcao);

    Retorno:= ConexaoAPI_C.processar();

    frmMain.BufferStr:= Retorno.ToJSON();

  Finally
    ConexaoAPI_C.Free();
    Retorno.Free();

    ModalResult:= mrOk;
  End;

end;

end.
