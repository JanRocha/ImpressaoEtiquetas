unit Uprodutos;

interface

uses Classes;

type

  TProduto = class(TPersistent)
  private
    FCodigo: Extended;
    FData_validade: String;
    FDescricao: String;
    FPreco: Currency;
  public
    property codigo: Extended read FCodigo write FCodigo;
    property data_validade: String read FData_validade write FData_validade;
    property descricao: String read FDescricao write FDescricao;
    property preco: Currency read FPreco write FPreco;
  end;

implementation

end.
