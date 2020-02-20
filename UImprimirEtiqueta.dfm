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
    ExplicitLeft = 8
    ExplicitTop = -8
    object GroupBox1: TGroupBox
      Left = 329
      Top = 10
      Width = 262
      Height = 50
      Caption = 'Produto'
      TabOrder = 0
      object Label1: TLabel
        Left = 56
        Top = 24
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 10
      Width = 97
      Height = 50
      Caption = 'C'#243'digo'
      TabOrder = 1
      object edtCodigo: TEdit
        Left = 6
        Top = 21
        Width = 88
        Height = 21
        Enabled = False
        TabOrder = 0
      end
    end
    object SG: TStringGrid
      Left = 2
      Top = 2
      Width = 321
      Height = 269
      Align = alLeft
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goRangeSelect, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 2
      ColWidths = (
        64
        64
        64
        64
        64)
    end
    object GroupBox3: TGroupBox
      Left = 329
      Top = 74
      Width = 262
      Height = 50
      Caption = 'Peso'
      TabOrder = 3
      object Label2: TLabel
        Left = 48
        Top = 24
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
    end
    object Button1: TButton
      Left = 329
      Top = 229
      Width = 131
      Height = 41
      Caption = 'Inicializar'
      TabOrder = 4
    end
    object Button2: TButton
      Left = 460
      Top = 229
      Width = 131
      Height = 41
      Caption = 'Imprimir'
      TabOrder = 5
    end
  end
end
