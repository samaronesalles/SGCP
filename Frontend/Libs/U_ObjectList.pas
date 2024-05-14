unit U_ObjectList;

interface

uses
  System.SysUtils, System.Classes;

type
  TObjectList = class(TList)
  private
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TObjectList }

constructor TObjectList.Create;
begin
  Self.Clear();
end;

destructor TObjectList.Destroy;
var
  C        : Longint;
begin

  C:= 0;
  While C < Count do begin
    TObject(Items[C]).Free;
    Inc(C);
  end;

  inherited;

end;

end.
