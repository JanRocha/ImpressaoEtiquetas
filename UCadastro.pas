unit UCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Grids, Buttons, uLkJSON, Generics.Collections;

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
    StringGrid1: TStringGrid;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastro: TfrmCadastro;

implementation

uses UFuncoes, Uprodutos;
{$R *.dfm}

procedure TfrmCadastro.FormShow(Sender: TObject);
var
  F: TFuncoes;
  p: TProduto;
  lista: TList<TProduto>;
  oJSList: TlkJSONlist;
  js: TlkJSONobject;
  i: integer;
const
  produto =
    '[{"descricao": "teste", "codigo": 123,"preco": 10.3, "data_validade": ""  }, {  "descricao": "teste", "codigo": 123, "preco": 10.3, "data_validade": ""  } ]';

begin
  oJSList := TlkJSON.ParseText(produto) as TlkJSONlist;
  lista := TList<TProduto>.Create();
  for i := 0 to oJSList.Count - 1 do
  begin
    p := TProduto.Create;
    js := oJSList.Child[i] as TlkJSONobject;
    p.descricao := js['descricao'].Value;
    p.codigo := js['codigo'].Value;
    p.preco := js['preco'].Value;
    p.data_validade := js['data_validade'].Value;
    lista.Insert(lista.Count,p);
  end;

end;

end.
