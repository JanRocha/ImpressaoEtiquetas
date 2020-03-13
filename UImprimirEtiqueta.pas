unit UImprimirEtiqueta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ComCtrls, ExtCtrls, StrUtils,DateUtils,
  Uprodutos,
  ACBrDevice,
  ACBrBAL,
  ACBrBase,
  ACBrETQ,
  UConfigBalancaINI,
  UConfigImpressoraINI,
  UFuncoes;

type
  TfrmImprimirEtiqueta = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    SG: TStringGrid;
    lblDescricaoProduto: TLabel;
    GroupBox3: TGroupBox;
    lblPeso: TLabel;
    btnAtivar: TButton;
    btnimprimir: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAtivarClick(Sender: TObject);
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure btnimprimirClick(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    FProduto: TProduto;
    FLog: string;
    FFuncoes: TFuncoes;
    ACBrBAL1: TACBrBAL;
    ACBrETQ: TACBrETQ;
    FConfigBAL: TConfigBalancaINI;
    FConfigImp: TConfigImpressoraINI;
    FLinha: integer;
    FCodigo: string;
    FValidade:string;
    Fpreco: string;
    procedure carregarConfigBalanca();
    procedure CarregarConfigImp();
    function GerarEtiqueta(codigo, valor:string):string;
  public
    { Public declarations }
  end;

var
  frmImprimirEtiqueta: TfrmImprimirEtiqueta;

implementation

{$R *.dfm}
{ TfrmImprimirEtiqueta }

procedure TfrmImprimirEtiqueta.ACBrBAL1LePeso
  (Peso: Double; Resposta: AnsiString);
var valid : integer;
begin
  lblPeso.Caption := formatFloat('##0.000', Peso);
  //lblPeso.Caption := FFuncoes.Converte(Resposta);

  if Peso < 0 then
  begin
    valid := Trunc(ACBrBAL1.UltimoPesoLido);
    case valid of
      0:
        lblPeso.Caption := 'TimeOut !' + sLineBreak +
          'Coloque o produto sobre a Balança!';
      -1:
        lblPeso.Caption := 'Peso Instavel ! ' + sLineBreak +
          'Tente Nova Leitura';
      -2:
        lblPeso.Caption := 'Peso Negativo !';
      -10:
        lblPeso.Caption := 'Sobrepeso !';
    end;
  end;
end;

procedure TfrmImprimirEtiqueta.btnAtivarClick(Sender: TObject);
begin
  if ACBrBAL1.Ativo then
  begin
    ACBrBAL1.Desativar;
    btnAtivar.Caption := 'Inicializar';
  end
  else
  begin
    ACBrBAL1.Ativar;
    btnAtivar.Caption := 'Desativar';
  end;
end;

procedure TfrmImprimirEtiqueta.btnimprimirClick(Sender: TObject);
var sPreco:string;
cPreco:Currency;
begin
  ACBrBAL1.LePeso(FConfigBAL.TimeOut);
  ACBrETQ.Ativar;
  cPreco:= StrToCurr(lblPeso.Caption) * StrToCurr(Fpreco);
  sPreco:=  FormatCurr('0.00', cPreco);
   if ACBrETQ.Modelo in [etqPpla, etqPplb] then
    begin
      ACBrETQ.ImprimirTexto(orNormal, 2, 2, 2, 3, 3, lblDescricaoProduto.Caption, 0, True);
      ACBrETQ.ImprimirTexto(orNormal, 2, 2, 2, 3, 3, '__________________________', 0, True);
      ACBrETQ.ImprimirTexto(orNormal, 3, 3, 2, 18, 32, 'Peso   ' +lblPeso.Caption);
      ACBrETQ.ImprimirTexto(orNormal, 2, 2, 2, 3, 3,'R$ / kg ' + FormatCurr('#0.00', StrToCurr(Fpreco)), 0, True);
      ACBrETQ.ImprimirTexto(orNormal, 3, 4, 4, 15, 50,sPreco );
      ACBrETQ.ImprimirTexto(orNormal, 3, 4, 4, 15, 50,'D. EMB. '+ FormatDateTime('dd.mm.yy',now ));
      ACBrETQ.ImprimirTexto(orNormal, 3, 4, 4, 15, 50,'D. VAL. '+ FormatDateTime('dd.mm.yy',IncDay(now,StrToInt(FValidade )) ));
      ACBrETQ.ImprimirTexto(orNormal, 3, 4, 4, 15, 50,'data hora '+FormatDateTime('hh:mm',now ));
      ACBrETQ.ImprimirBarras(orNormal, barEAN13, 2, 2, 13, 5, '1234567' ,10, becSIM);
    end
   else  //if Modelo = etqZPLII then
    begin
      ACBrETQ.ImprimirTexto(orNormal, '0', 25, 40, 3,  2, lblDescricaoProduto.Caption, 0, True);
      ACBrETQ.ImprimirTexto(orNormal, '0', 5 ,  5, 6,  0, '________________________________________________________________________');
      ACBrETQ.ImprimirTexto(orNormal, '0', 20, 20, 9,  2, 'PESO       ' +lblPeso.Caption);
      ACBrETQ.ImprimirTexto(orNormal, '0', 20, 20, 12, 2, 'R$ / KG    ' + FormatCurr('#0.00', StrToCurr(Fpreco)), 0, True);
      ACBrETQ.ImprimirTexto(orNormal, '0', 40, 20, 17, 2, 'TOTAL   R$ ' + FormatCurr('#0.00', StrToCurr(sPreco)));
      ACBrETQ.ImprimirTexto(orNormal, '0',  5,  5, 19, 0, '________________________________________________________________________');
      ACBrETQ.ImprimirTexto(orNormal, '0', 15, 15, 21, 2, 'D. EMB. '+ FormatDateTime('dd.mm.yy',now ));
      ACBrETQ.ImprimirTexto(orNormal, '0', 15, 15, 23, 2, 'D. VAL. '+ FormatDateTime('dd.mm.yy',IncDay(now,StrToInt(FValidade )) ));
      //ACBrETQ.ImprimirTexto(orNormal, '0', 10, 10, 21, 2, 'data hora '+ FormatDateTime('hh:mm',now ));
      ACBrETQ.ImprimirBarras(orNormal, barEAN13, 2, 2, 25, 10,GerarEtiqueta(FCodigo,sPreco), 10, becSIM);
    end;
   ACBrETQ.Imprimir();
   ACBrETQ.Desativar;
end;

procedure TfrmImprimirEtiqueta.carregarConfigBalanca;
begin
  FConfigBAL := TConfigBalancaINI
    (FFuncoes.SerializarINI('BALANCA.INI', 'CONFIG', FConfigBAL));
  // configura porta de comunicação
  ACBrBAL1.Modelo := TACBrBALModelo(FConfigBAL.Modelo);
  ACBrBAL1.Device.HandShake := TACBrHandShake(FConfigBAL.Handshaking);
  ACBrBAL1.Device.Parity := TACBrSerialParity(FConfigBAL.Parity);
  ACBrBAL1.Device.Stop := TACBrSerialStop(FConfigBAL.StopBits);
  ACBrBAL1.Device.Data := FConfigBAL.DataBits;
  ACBrBAL1.Device.Baud := FConfigBAL.BaudRate;
  ACBrBAL1.Device.Porta := FConfigBAL.Porta;
  ACBrBAL1.ArqLOG := FLog;
  ACBrBAL1.MonitorarBalanca := true;
  ACBrBAL1.OnLePeso:= Self.ACBrBAL1LePeso;
end;

procedure TfrmImprimirEtiqueta.CarregarConfigImp;
begin
  FConfigImp := TConfigImpressoraINI(FFuncoes.SerializarINI('IMPRESSORA.INI', 'CONFIG', FConfigImp));
  ACBrETQ.Desativar;
  ACBrETQ.DPI := TACBrETQDPI(FConfigImp.DPI);
  ACBrETQ.Modelo := TACBrETQModelo(FConfigImp.Modelo);
  ACBrETQ.Porta := FConfigImp.Porta;
  ACBrETQ.LimparMemoria := FConfigImp.LimparMemoria;
  ACBrETQ.Temperatura := FConfigImp.Temperatura;
  ACBrETQ.Velocidade := FConfigImp.Velocidade;
  ACBrETQ.BackFeed := TACBrETQBackFeed(FConfigImp.BackFeed);
  ACBrETQ.Unidade := etqMilimetros;
end;

procedure TfrmImprimirEtiqueta.FormDestroy(Sender: TObject);
begin
  FProduto.Free;
  FFuncoes.Free;
  ACBrBAL1.Free;
  ACBrETQ.Free;
  FConfigBAL.Free;
  FConfigImp.Free;
end;

procedure TfrmImprimirEtiqueta.FormShow(Sender: TObject);
begin
  FProduto := TProduto.Create;
  FFuncoes := TFuncoes.Create;
  ACBrBAL1 := TACBrBAL.Create(ACBrBAL1);
  ACBrETQ := TACBrETQ.Create(ACBrETQ);
  FConfigBAL := TConfigBalancaINI.Create;
  FConfigImp := TConfigImpressoraINI.Create;
  FProduto.CarregarGrid(SG, 1);
  FLog := FormatDateTime('DD-MM-YYYY', Now) + '_' + StringReplace(ExtractFileName(Application.ExeName),'.exe','',[rfReplaceAll]) + '.log';
  carregarConfigBalanca();
  CarregarConfigImp();
end;

function TfrmImprimirEtiqueta.GerarEtiqueta(codigo, valor: string): string;
begin
   valor:= StringReplace(valor,',','',[rfReplaceAll]);
   Result:= '2'+ FormatFloat('000000',StrToFloat(codigo));
   Result:= Result + FormatFloat('00000',StrToFloat(valor))+'4';
end;

procedure TfrmImprimirEtiqueta.SGSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
FLinha:= 0;
  if ARow > 0 then
  begin
    FCodigo                     := SG.Cells[0, ARow];
    lblDescricaoProduto.Caption := SG.Cells[1, ARow];
    Fpreco := SG.Cells[2, ARow];
    FValidade := SG.Cells[3, ARow];
    FLinha := ARow;
  end;
end;

end.
