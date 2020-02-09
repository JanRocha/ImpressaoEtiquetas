program ImpressaoEtiquetas;

uses
  Forms,
  UPrincipal in 'UPrincipal.pas' {Form1},
  UFuncoes in 'UFuncoes.pas',
  UCadastro in 'UCadastro.pas' {frmCadastro},
  Uprodutos in 'Uprodutos.pas',
  UConfigBalanca in 'UConfigBalanca.pas' {frmConfigBalanca},
  UConfigBalancaINI in 'UConfigBalancaINI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmCadastro, frmCadastro);
  Application.CreateForm(TfrmCadastro, frmCadastro);
  Application.Run;
end.
