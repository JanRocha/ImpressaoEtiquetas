unit UConfigImpressoraINI;

interface

uses classes;

type
  TConfigImpressoraINI = class(TPersistent)
  private
    FLimparMemoria: Boolean;
    FDPI: integer;
    FBackFeed: integer;
    FModelo: integer;
    FUnidade: integer;
    FTemperatura: integer;
    FPorta: string;
    FVelocidade: integer;
    FAvanco: integer;
  published
    property DPI: integer read FDPI write FDPI;
    property Modelo: integer read FModelo write FModelo;
    property Porta: string read FPorta write FPorta;
    property LimparMemoria: Boolean read FLimparMemoria write FLimparMemoria;
    property Temperatura: integer read FTemperatura write FTemperatura;
    property Velocidade: integer read FVelocidade write FVelocidade;
    property BackFeed: integer read FBackFeed write FBackFeed;
    property Unidade: integer read FUnidade write FUnidade;
    property Avanco: integer read FAvanco write FAvanco;
  end;

implementation

end.
