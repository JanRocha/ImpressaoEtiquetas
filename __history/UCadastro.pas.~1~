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
    SG: TStringGrid;
    Panel2: TPanel;
    btnNovo: TBitBtn;
    btnExcluir: TBitBtn;
    btnGravar: TBitBtn;
    btnEditar: TBitBtn;
    edtDias: TEdit;
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
    FProduto: TProduto;
    FEditar: boolean;
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
  FEditar                  := true;
  edtDescricao.Enabled     := true;
  edtCodigo.Enabled        := true;
  edtValorUnitario.Enabled := true;
  edtDias.Enabled          := true;
  btnNovo.Enabled          := false;
  btnEditar.Enabled        := false;
  btnGravar.Enabled        := true;
  btnExcluir.Enabled       := true;
  edtDescricao.SetFocus;
end;

procedure TfrmCadastro.btnExcluirClick(Sender: TObject);
begin
  if FLinha > 0 then
  begin
    SG.Cells[4, FLinha] := '1';
    Gravar();
    FProduto.CarregarGrid(SG);
  end;
  edtDescricao.Enabled     := false;
  edtCodigo.Enabled        := false;
  edtValorUnitario.Enabled := false;
  edtDias.Enabled          := false;
  btnNovo.Enabled          := true;
  btnEditar.Enabled        := true;
  btnGravar.Enabled        := false;
  btnExcluir.Enabled       := false;
  edtDescricao.Text        := '';
  edtCodigo.Text           := '';
  edtValorUnitario.Text    := '';
  edtDias.text             := '';
end;

procedure TfrmCadastro.btnGravarClick(Sender: TObject);
var i:integer;
begin
  if FEditar then
  begin
    SG.Cells[0, FLinha ] := edtCodigo.Text;
    SG.Cells[1, FLinha ] := edtDescricao.Text;
    SG.Cells[2 ,FLinha ] := edtValorUnitario.Text;
    SG.Cells[3, FLinha ] := edtDias.Text;
  end
  else
  begin
    for i := 1 to SG.RowCount do
    begin
       if trim(SG.Cells[0,i]) = trim(edtCodigo.Text) then
       begin
          Application.MessageBox('Codigo já em uso verifique','Atenção');
          edtCodigo.SetFocus;
          Exit;
       end;
       if trim(SG.Cells[1,i]) = trim(edtDescricao.Text) then
       begin
          Application.MessageBox('descrição já em uso verifique','Atenção');
          edtDescricao.SetFocus;
          Exit;
       end;
    end;
    SG.Cells[0, SG.RowCount] := edtCodigo.Text;
    SG.Cells[1, SG.RowCount] := edtDescricao.Text;
    SG.Cells[2, SG.RowCount] := edtValorUnitario.Text;
    SG.Cells[3, SG.RowCount] := edtDias.Text;
    SG.RowCount              := SG.RowCount + 1;
  end;
  Application.ProcessMessages;
  Gravar();

  edtDescricao.Enabled     := false;
  edtCodigo.Enabled        := false;
  edtValorUnitario.Enabled := false;
  edtDias.Enabled          := false;
  btnNovo.Enabled          := true;
  btnEditar.Enabled        := true;
  btnGravar.Enabled        := false;
  btnExcluir.Enabled       := false;
  edtDescricao.Text        := '';
  edtCodigo.Text           := '';
  edtValorUnitario.Text    := '';
  edtDias.text             := '';
end;

procedure TfrmCadastro.btnNovoClick(Sender: TObject);
begin
  FEditar                  := false;
  edtDescricao.Text        := '';
  edtCodigo.Text           := '';
  edtValorUnitario.Text    := '';
  edtDias.text             := '';
  edtDescricao.Enabled     := true;
  edtCodigo.Enabled        := true;
  edtValorUnitario.Enabled := true;
  edtDias.Enabled          := true;
  edtCodigo.SetFocus;
  btnNovo.Enabled          := false;
  btnEditar.Enabled        := false;
  btnGravar.Enabled        := true;
  btnEditar.Enabled        := false;
end;

procedure TfrmCadastro.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', Chr(8), Chr(46), Chr(44)]) then
    Key := #0
end;

procedure TfrmCadastro.FormDestroy(Sender: TObject);
begin
  Flista.Free;
  FProduto.Free;
end;

procedure TfrmCadastro.FormShow(Sender: TObject);
begin
  FProduto:= TProduto.Create;
  FProduto.CarregarGrid(SG,0);
end;

procedure TfrmCadastro.Gravar;
var
  oJSList: TlkJSONlist;
  js: TlkJSONobject;
  i: Integer;
  lstProdutos: TStringList;
begin
  oJSList := TlkJSONlist.Create;
  for i := 1 to SG.RowCount  do
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
    edtCodigo.Text        := SG.Cells[0, ARow];
    edtDescricao.Text     := SG.Cells[1, ARow];
    edtValorUnitario.Text := SG.Cells[2, ARow];
    edtDias.Text          := SG.Cells[3, ARow];
    FLinha := ARow;
  end;
end;

end.
