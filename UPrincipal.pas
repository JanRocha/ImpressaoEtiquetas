unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus,
  UConfigBalanca,
  UCadastro, ActnList;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuCadastro: TMenuItem;
    MenuProdutos: TMenuItem;
    MenuConfiguracoes: TMenuItem;
    MenuBalanca: TMenuItem;
    MenuImpressora: TMenuItem;
    Panel1: TPanel;
    procedure MenuProdutosClick(Sender: TObject);
    procedure MenuBalancaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.MenuBalancaClick(Sender: TObject);
begin
   frmConfigBalanca:=TfrmConfigBalanca.Create(nil);
   frmConfigBalanca.Parent:= Panel1;
   frmConfigBalanca.Show;
end;

procedure TForm1.MenuProdutosClick(Sender: TObject);
begin
  frmCadastro:= TfrmCadastro.Create(nil);
  frmCadastro.Parent:= Panel1;
  frmCadastro.Show;
end;

end.
