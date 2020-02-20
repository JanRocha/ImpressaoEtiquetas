program ImpressaoEtiquetas;

uses
  Forms,
  UPrincipal in 'UPrincipal.pas' {Form1},
  UCadastro in 'UCadastro.pas' {frmCadastro},
  Uprodutos in 'Uprodutos.pas',
  UConfigBalanca in 'UConfigBalanca.pas' {frmConfigBalanca},
  UConfigBalancaINI in 'UConfigBalancaINI.pas',
  UConfigImpressora in 'UConfigImpressora.pas' {frmConfigImpressora},
  UImprimirEtiqueta in 'UImprimirEtiqueta.pas' {frmImprimirEtiqueta};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmCadastro, frmCadastro);
  Application.CreateForm(TfrmCadastro, frmCadastro);
  Application.CreateForm(TfrmConfigImpressora, frmConfigImpressora);
  Application.CreateForm(TfrmImprimirEtiqueta, frmImprimirEtiqueta);
  Application.Run;
end.
