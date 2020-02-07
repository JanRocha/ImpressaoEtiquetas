unit UCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Grids, Buttons, uLkJSON,
  Generics.Collections,
  UFuncoes,
  Uprodutos;

type
  TfrmCadastro = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtDescricao: TEdit;
    GroupBox2: TGroupBox;
    edtCodigo: TEdit;
    GroupBox3: TGroupBox;
    edtValorUnitario: TEdit;
    GroupBox4: TGroupBox;
    edtValidade: TDateTimePicker;
    SG: TStringGrid;
    Panel2: TPanel;
    btnNovo: TBitBtn;
    btnExcluir: TBitBtn;
    btnGravar: TBitBtn;
    btnEditar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure SGSelectCeell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
  private
    Flista: TList<TProduto>;
    FLinha: Integer;
    procedure CarregarGrid();
    procedure Gravar();
  public
    { Public declarations }
  end;

var
  frmCadastro: TfrmCadastro;

implementation

{$R *.dfm}

procedure TfrmCadastro.btnEditarClick(Sender: TObject);
begin
  edtDescricao.Enabled := true;
  edtCodigo.Enabled := true;
  edtValorUnitario.Enabled := true;
  edtValidade.Enabled := true;
  edtDescricao.SetFocus;
  btnNovo.Enabled := false;
  btnEditar.Enabled := false;
  btnGravar.Enabled := true;
  btnExcluir.Enabled := true;
end;

procedure TfrmCadastro.btnExcluirClick(Sender: TObject);
begin
  if FLinha > 0 then
  begin
    SG.Cells[4, FLinha] := '1';
    Gravar();
    CarregarGrid();
  end;
  edtDescricao.Enabled := false;
  edtCodigo.Enabled := false;
  edtValorUnitario.Enabled := false;
  edtValidade.Enabled := false;
  btnNovo.Enabled := true;
  btnEditar.Enabled := true;
  btnGravar.Enabled := false;
  btnExcluir.Enabled := false;
  edtDescricao.Text := '';
  edtCodigo.Text := '';
  edtValorUnitario.Text := '';
  edtValidade.DateTime := now;
end;

procedure TfrmCadastro.btnGravarClick(Sender: TObject);
begin
  SG.Cells[0, SG.RowCount] := edtCodigo.Text;
  SG.Cells[1, SG.RowCount] := edtDescricao.Text;
  SG.Cells[2, SG.RowCount] := edtValorUnitario.Text;
  SG.Cells[3, SG.RowCount] := DateToStr(edtValidade.Date);
  Application.ProcessMessages;
  Gravar();
  SG.RowCount := SG.RowCount + 1;
  edtDescricao.Enabled := false;
  edtCodigo.Enabled := false;
  edtValorUnitario.Enabled := false;
  edtValidade.Enabled := false;
  btnNovo.Enabled := true;
  btnEditar.Enabled := true;
  btnGravar.Enabled := false;
  btnExcluir.Enabled := false;
  edtDescricao.Text := '';
  edtCodigo.Text := '';
  edtValorUnitario.Text := '';
  edtValidade.DateTime := now;
end;

procedure TfrmCadastro.btnNovoClick(Sender: TObject);
begin
  edtDescricao.Text := '';
  edtCodigo.Text := '';
  edtValorUnitario.Text := '';
  edtValidade.DateTime := now;
  edtDescricao.Enabled := true;
  edtCodigo.Enabled := true;
  edtValorUnitario.Enabled := true;
  edtValidade.Enabled := true;
  edtCodigo.SetFocus;
  btnNovo.Enabled := false;
  btnEditar.Enabled := false;
  btnGravar.Enabled := true;
  btnEditar.Enabled := false;
end;

procedure TfrmCadastro.CarregarGrid;
var
  F: TFuncoes;
  oJSList: TlkJSONlist;
  js: TlkJSONobject;
  i: Integer;
  lstProdutos: TStringList;

begin
  SG.ColWidths[0] := 100;
  SG.ColWidths[1] := 285;
  SG.ColWidths[2] := 100;
  SG.ColWidths[3] := 100;
  SG.ColWidths[4] := 0;
  SG.Cells[0, 0] := 'Codígo';
  SG.Cells[1, 0] := 'Descrição';
  SG.Cells[2, 0] := 'Preco';
  SG.Cells[3, 0] := 'Validade';
  if FileExists(GetCurrentDir + '\produtos.json') then
  begin
    lstProdutos := TStringList.Create;
    lstProdutos.LoadFromFile(GetCurrentDir + '\produtos.json');
    oJSList := TlkJSON.ParseText(lstProdutos.Text) as TlkJSONlist;
    SG.RowCount := oJSList.Count + 1;
    try
      for i := 0 to oJSList.Count - 1 do
      begin
        js := oJSList.Child[i] as TlkJSONobject;
        SG.Cells[0, i + 1] := js['codigo'].Value;
        SG.Cells[1, i + 1] := js['descricao'].Value;
        SG.Cells[2, i + 1] := js['preco'].Value;
        SG.Cells[3, i + 1] := js['data_validade'].Value;
      end;
    finally
      oJSList.Free;
      lstProdutos.Free;
    end;
  end;
end;

procedure TfrmCadastro.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', Chr(8), Chr(46)]) then
    Key := #0
end;

procedure TfrmCadastro.FormDestroy(Sender: TObject);
begin
  Flista.Free;
end;

procedure TfrmCadastro.FormShow(Sender: TObject);
begin
  CarregarGrid();
end;

procedure TfrmCadastro.Gravar;
var
  oJSList: TlkJSONlist;
  js: TlkJSONobject;
  i: Integer;
  lstProdutos: TStringList;
begin
  oJSList := TlkJSONlist.Create;
  for i := 1 to SG.RowCount -1 do
  begin
    if SG.Cells[4, i] <> '1' then
    begin
      js := TlkJSONobject.Create();
      js.Add('codigo', SG.Cells[0, i]);
      js.Add('descricao', SG.Cells[1, i]);
      js.Add('preco', SG.Cells[2, i]);
      js.Add('data_validade', SG.Cells[3, i]);
      oJSList.Add(js);
    end;
  end;
  lstProdutos := TStringList.Create;
  try
    lstProdutos.Text := TlkJSON.GenerateText(oJSList);
    DeleteFile('produtos.json');
    lstProdutos.SaveToFile('produtos.json');
  finally
    lstProdutos.Free;
  end;
end;

procedure TfrmCadastro.SGSelectCeell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  FLinha:= 0;
  if ARow > 0 then
  begin
    edtCodigo.Text := SG.Cells[0, ARow];
    edtDescricao.Text := SG.Cells[1, ARow];
    edtValorUnitario.Text := SG.Cells[2, ARow];
    edtValidade.Date := StrToDateDef(SG.Cells[3, ARow], now);
    FLinha := ARow;
  end;
end;

end.
