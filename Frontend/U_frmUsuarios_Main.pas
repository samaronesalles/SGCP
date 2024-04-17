unit U_frmUsuarios_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_frmTemplateForm_Main, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids;

type
  TfrmUsuarios_Main = class(TfrmTemplateForm_Main)
    procedure ButtonSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarios_Main: TfrmUsuarios_Main;

implementation

{$R *.dfm}

procedure TfrmUsuarios_Main.ButtonSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarios_Main.FormShow(Sender: TObject);
var
  Row                                          : integer;

begin
  inherited;

  Row:= 0;

  StringGridMain.Cells[0, Row]:= 'Código';
  StringGridMain.Cells[1, Row]:= 'Paciente';
  StringGridMain.Cells[2, Row]:= 'Profssional';
  StringGridMain.Cells[3, Row]:= 'Data';
  StringGridMain.Cells[4, Row]:= 'Hora agendada';
  StringGridMain.Cells[5, Row]:= 'Hora realizada';

  for Row:= 1 to 10 do begin
    StringGridMain.Cells[0, Row]:= IntToStr(Row);
    StringGridMain.Cells[1, Row]:= 'Fernanda';
    StringGridMain.Cells[2, Row]:= 'Maria';
    StringGridMain.Cells[3, Row]:= '15/04/2024';
    StringGridMain.Cells[4, Row]:= '08:30';
    StringGridMain.Cells[5, Row]:= '09:40';
  end;

  StringGridMain.ColCount:= 6;
  StringGridMain.RowCount:= Row;

{
  Row:= 0;

  StringGridMain.Cells[0, Row]:= 'Código';
  StringGridMain.Cells[1, Row]:= 'Nome';
  StringGridMain.Cells[2, Row]:= 'Email';
  StringGridMain.Cells[3, Row]:= 'Celular';
  StringGridMain.Cells[4, Row]:= 'Situação';

  for Row:= 1 to 10 do begin
    StringGridMain.Cells[0, Row]:= IntToStr(Row);
    StringGridMain.Cells[1, Row]:= 'Maria';
    StringGridMain.Cells[2, Row]:= 'maria.silva@gmail.com';
    StringGridMain.Cells[3, Row]:= '(31) 98452-1126';
    StringGridMain.Cells[4, Row]:= 'Ativa';
  end;

  StringGridMain.ColCount:= 5;
  StringGridMain.RowCount:= Row;
}
end;

end.
