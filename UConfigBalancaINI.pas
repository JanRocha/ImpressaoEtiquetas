unit UConfigBalancaINI;

interface

uses Classes;

type
  TConfigBalancaINI = class(TPersistent)
  private
    FBaudRate: integer;
    FParity: integer;
    FModelo: integer;
    FHandshaking: integer;
    FStopBits: integer;
    FPorta: string;
    FDataBits: integer;
    FTimeOut: integer;
    FMonitorarBalanca: Boolean;
  published
    property Modelo: integer read FModelo write FModelo;
    property Porta: string read FPorta write FPorta;
    property BaudRate: integer read FBaudRate write FBaudRate;
    property DataBits: integer read FDataBits write FDataBits;
    property Parity: integer read FParity write FParity;
    property StopBits: integer read FStopBits write FStopBits;
    property Handshaking: integer read FHandshaking write FHandshaking;
    property TimeOut:integer read FTimeOut write FTimeOut;
    property MonitorarBalanca:Boolean read FMonitorarBalanca write FMonitorarBalanca;
  end;

implementation

end.
