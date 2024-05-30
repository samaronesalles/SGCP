unit U_Evento_V;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.DateUtils,
  System.Generics.Collections, U_Agenda_M;

type
  TEvento_V = class(TPanel)
  private
    FLabelNome                         : TLabel;
    FLabelHora                         : TLabel;
  public
    property LabelNome                 : TLabel Read FLabelNome Write FLabelNome;
    property LabelHora                 : TLabel Read FLabelHora Write FLabelHora;

    destructor Destroy; override;

    class function ToObject (parent: TWinControl; const Cor: TColor; const Rect: TRect; const Agenda: TAgenda_M): TEvento_V;
  End;

implementation

uses Uteis, U_frmMain;

{ TEvento_V }

destructor TEvento_V.Destroy;
begin

  inherited;

  try
     FreeAndNil(Self.FLabelNome);
  except
  end;

  try
     FreeAndNil(Self.FLabelHora);
  except
  end;

end;

class function TEvento_V.ToObject (parent: TWinControl; const Cor: TColor; const Rect: TRect; const Agenda: TAgenda_M): TEvento_V;
var
  LabelNome, LabelHorario                  : TLabel;
  NomePaciente, IntervaloStr               : String;
  Evento_V                                 : TEvento_V;

begin

  Evento_V:= Nil;
  Result:= Nil;

  LabelNome:= Nil;
  LabelHorario:= Nil;

  Try
    NomePaciente:= Uteis.RetornaPrimeiroMaisUltimoNome(Agenda.Paciente.Nome);
    IntervaloStr:= FormatDateTime('hh:nn', Agenda.Evento_inicio) + ' - ' + FormatDateTime('hh:nn', Agenda.Evento_fim);

    // TPanel: Evento
    Evento_V:= TEvento_V.Create(Nil);

    Evento_V.Name:= 'pnEvento_' + IntToStr(Agenda.Id);
    Evento_V.Tag:= Agenda.Id;
    Evento_V.Parent:= parent;

    Evento_V.BorderStyle:= bsNone;
    Evento_V.ParentColor:= FALSE;
    Evento_V.ParentBackground:= FALSE;
    Evento_V.Color:= Cor;

    Evento_V.Top:= Rect.Top;
    Evento_V.Left:= Rect.Left;
    Evento_V.Height:= Rect.Height;
    Evento_V.Width:= Rect.Width;
    Evento_V.BevelOuter:= bvNone;

    Evento_V.Hint:= NomePaciente + #13 + IntervaloStr;
    Evento_V.ShowHint:= FALSE;
    Evento_V.Cursor:= crHandPoint;

    Evento_V.Caption:= '';


    // TLabel: Horário
    LabelHorario:= TLabel.Create(Nil);
    LabelHorario.Parent:= Evento_V;
    LabelHorario.Align:= alBottom;
    LabelHorario.Height:=  20;

    LabelHorario.Caption:= IntervaloStr;

    LabelHorario.ParentFont:= FALSE;
    LabelHorario.Alignment:= taCenter;
    LabelHorario.Layout:= tlCenter;
    LabelHorario.Font.Color:= clWhite;
    LabelHorario.Font.Name:= 'Arial';
    LabelHorario.Font.Size:= 9;
    LabelHorario.Font.Style:= [];

    LabelHorario.Hint:= Evento_V.Hint;
    LabelHorario.ShowHint:= TRUE;


    // TLabel: Nome
    LabelNome:= TLabel.Create(Nil);
    LabelNome.Parent:= Evento_V;
    LabelNome.Align:= alClient;

    LabelNome.Caption:= Uteis.RetornaPrimeiroNome(Agenda.Paciente.Nome);

    LabelNome.ParentFont:= FALSE;
    LabelNome.Alignment:= taCenter;
    LabelNome.Layout:= tlCenter;
    LabelNome.Font.Color:= clWhite;
    LabelNome.Font.Name:= 'Arial';
    LabelNome.Font.Size:= 11;
    LabelNome.Font.Style:= [fsBold];

    LabelNome.Hint:= Evento_V.Hint;
    LabelNome.ShowHint:= TRUE;

    Evento_V.LabelNome:= LabelNome;
    Evento_V.LabelHora:= LabelHorario;

    Result:= Evento_V;
  Except
    Evento_V.Free();

    LabelNome.Free();
    LabelHorario.Free();

    Result:= Nil;
  End;

end;

end.
