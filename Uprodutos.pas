unit Uprodutos;

interface

uses Classes,
     SysUtils,
     uLkJSON,
     UFuncoes,
     Grids;

type

  TProduto = class(TPersistent)
  private
    FCodigo: integer;
    FData_validade: String;
    FDescricao: String;
    FPreco: Currency;
  public
    property codigo: integer read FCodigo write FCodigo;
    property data_validade: String read FData_validade write FData_validade;
    property descricao: String read FDescricao write FDescricao;
    property preco: Currency read FPreco write FPreco;
    procedure CarregarGrid(SG: TStringGrid;Tipo:integer = 0);
  end;

implementation

{ TProduto }

procedure TProduto.CarregarGrid(SG: TStringGrid;Tipo:integer);
var
  F: TFuncoes;
  oJSList: TlkJSONlist;
  js: TlkJSONobject;
  i: Integer;
  lstProdutos: TStringList;
begin
  SG.Cells[0, 0] := 'Cod�go';
  SG.Cells[1, 0] := 'Descri��o';
  SG.Cells[2, 0] := 'Preco';
  SG.Cells[3, 0] := 'Validade';
  if Tipo = 0  then
  begin
    SG.ColWidths[0] := 100;
    SG.ColWidths[1] := 285;
    SG.ColWidths[2] := 100;
    SG.ColWidths[3] := 100;
    SG.ColWidths[4] := 0;
  end
  else
  begin
    SG.ColWidths[0] := 50;
    SG.ColWidths[1] := 200;
    SG.ColWidths[2] := 100;
    SG.ColWidths[3] := 0;
  end;
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

end.
