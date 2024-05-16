unit U_frmTemplateForm_Detail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TfrmTemplateForm_Detail = class(TForm)
    pnBotoes: TPanel;
    ButtonProsseguir: TButton;
    pnDetalhe: TPanel;
    ImageList_Icons: TImageList;
    ButtonCancelar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmTemplateForm_Detail: TfrmTemplateForm_Detail;

implementation

{$R *.dfm}

{ TfrmTemplateForm_Detail }

procedure TfrmTemplateForm_Detail.ButtonCancelarClick(Sender: TObject);
begin
  if NOT ButtonCancelar.Enabled then
    Exit;

  ModalResult:= mrCancel;
end;

procedure TfrmTemplateForm_Detail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self:= Nil;
  Action:= caFree;
end;

procedure TfrmTemplateForm_Detail.FormCreate(Sender: TObject);
begin
  KeyPreview:= TRUE;
end;

procedure TfrmTemplateForm_Detail.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then begin
    SelectNext(ActiveControl as TWinControl, TRUE, TRUE);
    Key:= #0;
  end;

  if Key = #27 then begin
    Key:= #0;
    ButtonCancelar.OnClick(Self);
  end;

end;

end.
