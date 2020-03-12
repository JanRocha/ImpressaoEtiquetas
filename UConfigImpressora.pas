unit UConfigImpressora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UConfigImpressoraINI,
  UFuncoes,
  typinfo,
  ACBrDevice,
  ACBrETQ,
  ACBrBase;

type
  TfrmConfigImpressora = class(TForm)
    gbConfiguracao: TGroupBox;
    lbModelo: TLabel;
    lbPorta: TLabel;
    lbAvanco: TLabel;
    lbDPI: TLabel;
    lbTemperatura: TLabel;
    lbBackFeed: TLabel;
    lbTemperatura1: TLabel;
    cbModelo: TComboBox;
    cbPorta: TComboBox;
    eAvanco: TEdit;
    cbDPI: TComboBox;
    eTemperatura: TEdit;
    cbBackFeed: TComboBox;
    eVelocidade: TEdit;
    ckMemoria: TCheckBox;
    Button1: TButton;
    btnImprimir: TButton;
    btnConectar: TButton;
    Label1: TLabel;
    edtLinha1: TEdit;
    edtLinha2: TEdit;
    Label2: TLabel;
    edtLinha3: TEdit;
    Label3: TLabel;
    edtLinha4: TEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ACBrETQ: TACBrETQ;
    FFuncoes:TFuncoes;
    FConfigIni:TConfigImpressoraINI;
    procedure CarregarConfigPadrao();
    procedure LerConfigINI();
    procedure ativarEtiqueta;
  public
    { Public declarations }
  end;

var
  frmConfigImpressora: TfrmConfigImpressora;

implementation

{$R *.dfm}
{ TfrmConfigImpressora }

procedure TfrmConfigImpressora.ativarEtiqueta;
begin
  ACBrETQ.Desativar;
  ACBrETQ.DPI := TACBrETQDPI(cbDPI.ItemIndex);
  ACBrETQ.Modelo := TACBrETQModelo(cbModelo.ItemIndex);
  ACBrETQ.Porta := cbPorta.Text;
  ACBrETQ.LimparMemoria := ckMemoria.Checked;
  ACBrETQ.Temperatura := StrToInt(eTemperatura.Text);
  ACBrETQ.Velocidade := StrToInt(eVelocidade.Text);
  ACBrETQ.BackFeed := TACBrETQBackFeed(cbBackFeed.ItemIndex);
  ACBrETQ.Unidade := etqMilimetros;
  //ACBrETQ.Ativar;
end;

procedure TfrmConfigImpressora.btnConectarClick(Sender: TObject);
begin
   ativarEtiqueta();
end;

procedure TfrmConfigImpressora.btnImprimirClick(Sender: TObject);
begin
   ACBrETQ.Ativar;
   if ACBrETQ.Modelo in [etqPpla, etqPplb] then
    begin
      ACBrETQ.ImprimirTexto(orNormal, 2, 2, 2, 3, 3, edtLinha1.Text, 0, True);
      //ACBrETQ.ImprimirTexto(orNormal, 3, 3, 2, 18, 32, edtLinha2.Text);
      //ACBrETQ.ImprimirTexto(orNormal, 3, 4, 4, 15, 50, edtLinha3.Text);
      ACBrETQ.ImprimirBarras(orNormal, barEAN13, 2, 2, 13, 5, edtLinha4.Text, 10, becSIM);
    end
   else  //if Modelo = etqZPLII then
    begin
      ACBrETQ.ImprimirTexto(orNormal, 12, 1, 1, 5, 5, edtLinha1.Text, 0, True);
      ACBrETQ.ImprimirTexto(orNormal, 12, 1, 1, 10, 5, edtLinha2.Text);
      ACBrETQ.ImprimirTexto(orNormal, 12, 1, 1, 15, 5, edtLinha2.Text);
      ACBrETQ.ImprimirBarras(orNormal, barEAN13, 2, 2, 20, 5, edtLinha4.Text, 10, becSIM);
    end;
    ACBrETQ.Imprimir();
   ACBrETQ.Desativar;
end;

procedure TfrmConfigImpressora.Button1Click(Sender: TObject);
begin
   FConfigIni.DPI:= cbDPI.ItemIndex;
   FConfigIni.Modelo:= cbModelo.ItemIndex;
   FConfigIni.Porta:= cbPorta.Text;
   FConfigIni.LimparMemoria:= ckMemoria.Checked;
   FConfigIni.Temperatura:= StrToInt( eTemperatura.Text);
   FConfigIni.Velocidade:= StrToInt(eVelocidade.Text);
   FConfigIni.BackFeed:= cbBackFeed.ItemIndex;
   FConfigIni.Unidade:= 0;
   FFuncoes.GravarINI('IMPRESSORA.INI','CONFIG',FConfigIni);
end;

procedure TfrmConfigImpressora.CarregarConfigPadrao;
var
  I: TACBrETQModelo;
  J: TACBrETQDPI;
  L: TACBrETQBackFeed;
begin
  cbModelo.Items.Clear;
  For I := Low(TACBrETQModelo) to High(TACBrETQModelo) do
    cbModelo.Items.Add(GetEnumName(TypeInfo(TACBrETQModelo), integer(I)));

  cbDPI.Items.Clear;
  For J := Low(TACBrETQDPI) to High(TACBrETQDPI) do
    cbDPI.Items.Add(GetEnumName(TypeInfo(TACBrETQDPI), integer(J)));

  cbBackFeed.Items.Clear;
  For L := Low(TACBrETQBackFeed) to High(TACBrETQBackFeed) do
    cbBackFeed.Items.Add(GetEnumName(TypeInfo(TACBrETQBackFeed), integer(L)));

  ACBrETQ.Device.AcharPortasSeriais(cbPorta.Items);
  cbPorta.Items.Add('LPT1');
  cbPorta.Items.Add('LPT2');
  cbPorta.Items.Add('LPT3');
  cbPorta.Items.Add('/dev/ttyS0');
  cbPorta.Items.Add('/dev/ttyS1');
  cbPorta.Items.Add('/dev/ttyUSB0');
  cbPorta.Items.Add('/dev/ttyUSB1');
  cbPorta.Items.Add('c:\temp\etq.txt');
  cbPorta.Items.Add('/tmp/etq.txt');

  cbDPI.ItemIndex := 0;
  cbModelo.ItemIndex := 1;
  cbPorta.ItemIndex := 0;
end;

procedure TfrmConfigImpressora.FormCreate(Sender: TObject);
begin
  ACBrETQ := TACBrETQ.Create(self);
  FFuncoes:=TFuncoes.Create;
  FConfigIni:= TConfigImpressoraINI.create;
end;

procedure TfrmConfigImpressora.FormDestroy(Sender: TObject);
begin
  FFuncoes.Free;
  FConfigIni.free;
  ACBrETQ.Free;
end;

procedure TfrmConfigImpressora.FormShow(Sender: TObject);
begin
CarregarConfigPadrao;
LerConfigINI;
end;

procedure TfrmConfigImpressora.LerConfigINI;
begin
  FConfigIni:= TConfigImpressoraINI(FFuncoes.SerializarINI('IMPRESSORA.INI','CONFIG',FConfigIni));

  cbModelo.ItemIndex:=  FConfigIni.Modelo;
  cbPorta.Items.Add(FConfigIni.Porta);
  cbPorta.ItemIndex:=cbPorta.Items.Count;
  cbDPI.ItemIndex:= FConfigIni.DPI;
  cbBackFeed.ItemIndex:= FConfigIni.BackFeed;
  ckMemoria.Checked:= FConfigIni.LimparMemoria;
  eVelocidade.Text:= IntToStr( FConfigIni.Velocidade);
  eAvanco.Text:= IntToStr(FConfigIni.Avanco);
  eVelocidade.Text:= IntToStr(FConfigIni.Velocidade);
end;

end.
