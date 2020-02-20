unit UImprimirEtiqueta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ComCtrls, ExtCtrls,
  Uprodutos;

type
  TfrmImprimirEtiqueta = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    edtCodigo: TEdit;
    SG: TStringGrid;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
  private
    FProduto:TProduto;
  public
    { Public declarations }
  end;

var
  frmImprimirEtiqueta: TfrmImprimirEtiqueta;

implementation

{$R *.dfm}

{ TfrmImprimirEtiqueta }


procedure TfrmImprimirEtiqueta.FormShow(Sender: TObject);
begin
   FProduto:= TProduto.Create;
   FProduto.CarregarGrid(SG,1);
end;

end.
