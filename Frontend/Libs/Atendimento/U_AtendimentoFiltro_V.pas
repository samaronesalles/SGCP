unit U_AtendimentoFiltro_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Filtro, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAtendimentoFiltro_V = class(TfrmTemplateForm_Filtro)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox_FiltroStatus: TComboBox;
    ComboBox_FiltroProfissional: TComboBox;
    ComboBox_FiltroPaciente: TComboBox;
    procedure ButtonFiltrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

    function Execute(Status: Longint): string;
  end;

var
  frmAtendimentoFiltro_V: TfrmAtendimentoFiltro_V;

implementation

uses U_frmMain, Uteis;

{$R *.dfm}

{ TfrmAtendimentoFiltro_V }

procedure TfrmAtendimentoFiltro_V.ButtonFiltrarClick(Sender: TObject);
var
  Status, profissional, paciente                 : Longint;

begin

  Status:= iff(ComboBox_FiltroStatus.ItemIndex < 0, 0, ComboBox_FiltroStatus.ItemIndex);
  profissional:= iff(ComboBox_FiltroProfissional.ItemIndex < 0, 0, ComboBox_FiltroProfissional.ItemIndex);
  paciente:= iff(ComboBox_FiltroPaciente.ItemIndex < 0, 0, ComboBox_FiltroPaciente.ItemIndex);

  frmMain.BufferStr:= '{' +
                          '"status": ' + IntToStr(Status) + ',' +
                          '"profissionalId": ' + IntToStr(profissional) + ',' +
                          '"pacienteId": ' + IntToStr(paciente) +
                      '}';

  ModalResult:= mrOk;

end;

function TfrmAtendimentoFiltro_V.Execute(Status: Longint): string;
var
  BkpBufferStr                              : String;

begin

  Try
    BkpBufferStr:= frmMain.BufferStr;

    Try
      Result:= '';
      frmMain.BufferStr:= '';

      if frmAtendimentoFiltro_V = Nil then
        frmAtendimentoFiltro_V:= TfrmAtendimentoFiltro_V.Create(Nil);

      frmAtendimentoFiltro_V.ComboBox_FiltroStatus.ItemIndex:= Status;

      if frmAtendimentoFiltro_V.ShowModal <> mrOk Then
        Exit;

      Result:= frmMain.BufferStr;
    Except
      Result:= '';
    End;
  Finally
    frmMain.BufferStr:= BkpBufferStr;
  End;

end;

procedure TfrmAtendimentoFiltro_V.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  frmAtendimentoFiltro_V:= Nil;
  Action:= caFree;

end;

end.
