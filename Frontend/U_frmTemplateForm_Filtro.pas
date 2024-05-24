unit U_frmTemplateForm_Filtro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.ImageList, Vcl.ImgList;

type
  TfrmTemplateForm_Filtro = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ImageList_Icons: TImageList;
    Panel3: TPanel;
    ButtonFiltrar: TButton;
    ButtonSair: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTemplateForm_Filtro: TfrmTemplateForm_Filtro;

implementation

uses U_frmMain, Uteis;

{$R *.dfm}

procedure TfrmTemplateForm_Filtro.ButtonSairClick(Sender: TObject);
begin
  if NOT ButtonSair.Enabled then
    Exit;

  ModalResult:= mrCancel;
end;

procedure TfrmTemplateForm_Filtro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self:= Nil;
  Action:= caFree;
end;

procedure TfrmTemplateForm_Filtro.FormCreate(Sender: TObject);
begin
  KeyPreview:= TRUE;
end;

procedure TfrmTemplateForm_Filtro.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then begin
    SelectNext(ActiveControl as TWinControl, TRUE, TRUE);
    Key:= #0;
  end;

  if Key = #27 then begin
    Key:= #0;
    ButtonSair.OnClick(Self);
  end;

end;

end.
