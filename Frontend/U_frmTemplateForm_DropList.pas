unit U_frmTemplateForm_DropList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Grids;

type
  TfrmTemplateForm_DropList = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ImageList_Icons: TImageList;
    StringGridMain: TStringGrid;
    Label1: TLabel;
    TimerStartUp: TTimer;
    procedure StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TimerStartUpTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTemplateForm_DropList: TfrmTemplateForm_DropList;

implementation

uses Uteis;

{$R *.dfm}

procedure TfrmTemplateForm_DropList.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #27 then begin
    Key:= #0;
    ModalResult:= mrCancel;
  end;

end;

procedure TfrmTemplateForm_DropList.StringGridMainDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  CorFonteLinhaPar               = clBlack;
  CorLinhaPar                    = $00EAEAEA;

  CorFonteLinhaImpar             = clBlack;
  CorLinhaImpar                  = clWhite;

var
  CorFont, CorLinha              : TColor;

begin

  if ARow mod 2 = 0 then begin
    CorFont:= CorFonteLinhaImpar;
    CorLinha:= CorLinhaPar;
  end else begin
    CorFont:= CorFonteLinhaPar;
    CorLinha:= CorLinhaImpar;
  end;

  Uteis.SetCorRowgrid(TStringGrid(Sender), CorFont, CorLinha, ACol, ARow, Rect, State);

end;

procedure TfrmTemplateForm_DropList.StringGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_INSERT then begin
    ModalResult:= mrOk;
    Exit;
  end;

end;

procedure TfrmTemplateForm_DropList.TimerStartUpTimer(Sender: TObject);
begin
  TimerStartUp.Enabled:= FALSE;
end;

end.
