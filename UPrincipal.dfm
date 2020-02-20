object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Impress'#227'o de Etiquetas'
  ClientHeight = 287
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 287
    Align = alClient
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 336
    Top = 208
    object Etiqueta1: TMenuItem
      Caption = 'Etiqueta'
      object Imprimir1: TMenuItem
        Caption = 'Imprimir'
        OnClick = Imprimir1Click
      end
    end
    object MenuCadastro: TMenuItem
      Caption = 'Cadastro'
      object MenuProdutos: TMenuItem
        AutoCheck = True
        Caption = 'Abrir Cadastro'
        OnClick = MenuProdutosClick
      end
    end
    object MenuConfiguracoes: TMenuItem
      Caption = 'Configura'#231#245'es'
      object MenuBalanca: TMenuItem
        Caption = 'Balan'#231'a'
        OnClick = MenuBalancaClick
      end
      object MenuImpressora: TMenuItem
        Caption = 'Impressora'
        OnClick = MenuImpressoraClick
      end
    end
  end
end
