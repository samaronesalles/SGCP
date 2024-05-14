unit U_Profissional_C;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, U_Profissional_M;

type
  TProfissional_C = class(TObject)
  private
  public
    constructor Create;
    destructor Destroy; override;
  End;

implementation

uses Uteis;


{ TProfissional_C }

constructor TProfissional_C.Create;
begin
  //
end;

destructor TProfissional_C.Destroy;
begin

  inherited;
end;

end.
