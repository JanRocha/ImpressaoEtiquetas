object frmImprimirEtiqueta: TfrmImprimirEtiqueta
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmImprimirEtiqueta'
  ClientHeight = 273
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 596
    Height = 273
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 329
      Top = 12
      Width = 262
      Height = 50
      Caption = 'Produto'
      TabOrder = 0
      object lblDescricaoProduto: TLabel
        Left = 19
        Top = 24
        Width = 3
        Height = 13
      end
    end
    object SG: TStringGrid
      Left = 2
      Top = 2
      Width = 321
      Height = 269
      Align = alLeft
      ColCount = 4
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goRangeSelect, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 1
      OnSelectCell = SGSelectCell
      ColWidths = (
        64
        64
        64
        64)
    end
    object GroupBox3: TGroupBox
      Left = 329
      Top = 64
      Width = 262
      Height = 50
      Caption = 'Peso'
      TabOrder = 2
      object lblPeso: TLabel
        Left = 48
        Top = 24
        Width = 3
        Height = 13
      end
    end
    object btnAtivar: TButton
      Left = 329
      Top = 230
      Width = 131
      Height = 41
      Caption = 'Inicializar'
      TabOrder = 3
      OnClick = btnAtivarClick
    end
    object btnimprimir: TButton
      Left = 460
      Top = 230
      Width = 131
      Height = 41
      Caption = 'Imprimir'
      TabOrder = 4
      OnClick = btnimprimirClick
    end
  end
end
