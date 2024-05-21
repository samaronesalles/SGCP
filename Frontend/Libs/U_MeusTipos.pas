unit U_MeusTipos;

interface

uses
  System.SysUtils, System.Classes;

type
  TTipoAcaoAPI = (
    taNenhuma,
    taProfissional_Save,
    taProfissional_Excusao,
    taProfissional_Lista,
    taProfissional_Login,

    taPaciente_Save,
    taPaciente_Excusao,
    taPaciente_Lista,

    taAtendimento_Save,
    taAtendimento_Excusao,
    taAtendimento_Lista
  );

implementation

end.
