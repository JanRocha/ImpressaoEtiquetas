unit UConfigBalanca;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls, ACBrDevice, ACBrBAL, ACBrBase, StrUtils ,
  UConfigBalancaINI,
  UFuncoes;

type

  { TForm1 }

  TfrmConfigBalanca = class(TForm)
    ACBrBAL1: TACBrBAL;
    btnConectar: TButton;
    btnDesconectar: TButton;
    btnLerPeso: TButton;
    sttPeso: TStaticText;
    sttResposta: TStaticText;
    Label2: TLabel;
    Label3: TLabel;
    edtTimeOut: TEdit;
    Label9: TLabel;
    chbMonitorar: TCheckBox;
    Label10: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cmbBalanca: TComboBox;
    cmbPortaSerial: TComboBox;
    cmbBaudRate: TComboBox;
    cmbDataBits: TComboBox;
    cmbHandShaking: TComboBox;
    cmbParity: TComboBox;
    Label11: TLabel;
    cmbStopBits: TComboBox;
    Button1: TButton;
    procedure btnConectarClick(Sender: TObject);
    procedure btnLerPesoClick(Sender: TObject);
    procedure btnDesconectarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure edtTimeOutKeyPress(Sender: TObject; var Key: Char);
    procedure chbMonitorarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SbArqLogClick(Sender: TObject);
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FFuncao: TFuncoes;
    FConfigBalanca: TConfigBalancaINI;
  public
    { public declarations }
  end;

var
  frmConfigBalanca: TfrmConfigBalanca;

implementation

{$R *.dfm}

Uses
  typinfo, ACBrUtil;

procedure TfrmConfigBalanca.ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
var
  valid: Integer;
begin
  sttPeso.Caption := formatFloat('##0.000', Peso);
  sttResposta.Caption := FFuncao.Converte(Resposta);

  if Peso > 0 then
    Memo1.Lines.Text := 'Leitura OK !'
  else
  begin
    valid := Trunc(ACBrBAL1.UltimoPesoLido);
    case valid of
      0:
        Memo1.Lines.Text := 'TimeOut !' + sLineBreak +
          'Coloque o produto sobre a Balança!';
      -1:
        Memo1.Lines.Text := 'Peso Instavel ! ' + sLineBreak +
          'Tente Nova Leitura';
      -2:
        Memo1.Lines.Text := 'Peso Negativo !';
      -10:
        Memo1.Lines.Text := 'Sobrepeso !';
    end;
  end;
end;

procedure TfrmConfigBalanca.btnConectarClick(Sender: TObject);
begin
  // se houver conecção aberta, Fecha a conecção
  if ACBrBAL1.Ativo then
    ACBrBAL1.Desativar;

  // configura porta de comunicação
  ACBrBAL1.Modelo := TACBrBALModelo(cmbBalanca.ItemIndex);
  ACBrBAL1.Device.HandShake := TACBrHandShake(cmbHandShaking.ItemIndex);
  ACBrBAL1.Device.Parity := TACBrSerialParity(cmbParity.ItemIndex);
  ACBrBAL1.Device.Stop := TACBrSerialStop(cmbStopBits.ItemIndex);
  ACBrBAL1.Device.Data := StrToInt(cmbDataBits.Text);
  ACBrBAL1.Device.Baud := StrToInt(cmbBaudRate.Text);
  ACBrBAL1.Device.Porta := cmbPortaSerial.Text;
  ACBrBAL1.ArqLOG :=FormatDateTime('DD-MM-YYYY', Now) + '_'+ ExtractFileName(Application.ExeName);

  // Conecta com a balança
  ACBrBAL1.Ativar;

  btnConectar.Enabled := false;
  Panel1.Enabled := false;
  btnDesconectar.Enabled := true;
  btnLerPeso.Enabled := true;
end;

procedure TfrmConfigBalanca.btnLerPesoClick(Sender: TObject);
Var
  TimeOut: Integer;
begin
  try
    TimeOut := StrToInt(edtTimeOut.Text);
  except
    TimeOut := 2000;
  end;

  ACBrBAL1.LePeso(TimeOut);
end;

procedure TfrmConfigBalanca.Button1Click(Sender: TObject);
begin
  if not(Assigned(FConfigBalanca)) then
    FConfigBalanca := TConfigBalancaINI.Create;
  FConfigBalanca.Modelo := cmbBalanca.ItemIndex;
  FConfigBalanca.Porta  := cmbPortaSerial.Text;
  FConfigBalanca.BaudRate:= StrToInt(cmbBaudRate.Text);
  FConfigBalanca.DataBits := StrToInt(cmbDataBits.Text);
  FConfigBalanca.Parity:= cmbParity.ItemIndex;
  FConfigBalanca.StopBits := cmbStopBits.ItemIndex;
  FConfigBalanca.Handshaking := cmbHandShaking.ItemIndex;
  FConfigBalanca.TimeOut     := StrToIntDef(edtTimeOut.Text,2000);
  FConfigBalanca.MonitorarBalanca := StrToBool( IfThen(chbMonitorar.checked, 'True', 'False'));
  FFuncao.GravarINI('BALANCA.INI','CONFIG',FConfigBalanca);
end;

procedure TfrmConfigBalanca.btnDesconectarClick(Sender: TObject);
begin
  ACBrBAL1.Desativar;

  btnConectar.Enabled := true;
  Panel1.Enabled := true;
  btnDesconectar.Enabled := false;
  btnLerPeso.Enabled := false;
end;

procedure TfrmConfigBalanca.edtTimeOutKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #13, #8]) then
    Key := #0;
end;

procedure TfrmConfigBalanca.chbMonitorarClick(Sender: TObject);
begin
  ACBrBAL1.MonitorarBalanca := chbMonitorar.Checked;
end;

procedure TfrmConfigBalanca.FormCreate(Sender: TObject);
var
  I: TACBrBALModelo;
begin
  FFuncao := TFuncoes.Create;
  FConfigBalanca := TConfigBalancaINI.Create;

  FConfigBalanca := TConfigBalancaINI
    (FFuncao.SerializarINI('BALANCA.INI', 'CONFIG', FConfigBalanca));
  cmbBalanca.Items.Clear;
  For I := Low(TACBrBALModelo) to High(TACBrBALModelo) do
    cmbBalanca.Items.Add(GetEnumName(TypeInfo(TACBrBALModelo), Integer(I)));
  cmbBalanca.ItemIndex := FConfigBalanca.Modelo;
  cmbPortaSerial.ItemIndex:= cmbBalanca.Items.IndexOf(FConfigBalanca.Porta);
  cmbBaudRate.ItemIndex:= FConfigBalanca.BaudRate;
  cmbDataBits.ItemIndex:= FConfigBalanca.BaudRate;
  cmbHandShaking.ItemIndex:= FConfigBalanca.Handshaking;
  cmbParity.ItemIndex:= FConfigBalanca.Parity;
  cmbStopBits.ItemIndex:= FConfigBalanca.StopBits;
  chbMonitorar.Checked:= FConfigBalanca.MonitorarBalanca;
end;

procedure TfrmConfigBalanca.FormDestroy(Sender: TObject);
begin
  FFuncao.Free;
  FConfigBalanca.Free;
end;

procedure TfrmConfigBalanca.SbArqLogClick(Sender: TObject);
begin
  // OpenURL(ExtractFilePath(Application.ExeName) + edLog.Text);
end;

procedure TfrmConfigBalanca.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  ACBrBAL1.Desativar;
end;

end.
