object frmCadastro: TfrmCadastro
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmCadastro'
  ClientHeight = 273
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 596
    Height = 273
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 106
      Top = 10
      Width = 256
      Height = 50
      Caption = 'Descri'#231#227'o'
      TabOrder = 0
      object edtDescricao: TEdit
        Left = 5
        Top = 21
        Width = 245
        Height = 24
        TabOrder = 0
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
        Height = 24
        TabOrder = 0
      end
    end
    object GroupBox3: TGroupBox
      Left = 363
      Top = 10
      Width = 110
      Height = 50
      Caption = 'Valor unit'#225'rio'
      TabOrder = 2
      object edtValorUnitario: TEdit
        Left = 6
        Top = 21
        Width = 98
        Height = 24
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 474
      Top = 10
      Width = 115
      Height = 50
      Caption = 'Data de Validade'
      TabOrder = 3
      object edtValidade: TDateTimePicker
        Left = 5
        Top = 21
        Width = 105
        Height = 24
        Date = 43863.813479606480000000
        Time = 43863.813479606480000000
        TabOrder = 0
      end
    end
    object StringGrid1: TStringGrid
      Left = 2
      Top = 61
      Width = 592
      Height = 169
      Align = alBottom
      ColCount = 4
      FixedCols = 0
      TabOrder = 4
      ColWidths = (
        64
        64
        64
        64)
    end
    object Panel2: TPanel
      Left = 2
      Top = 230
      Width = 592
      Height = 41
      Align = alBottom
      TabOrder = 5
      object BitBtn1: TBitBtn
        Left = 291
        Top = 1
        Width = 75
        Height = 39
        Align = alRight
        Caption = 'Novo'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
      end
      object BitBtn2: TBitBtn
        Left = 441
        Top = 1
        Width = 75
        Height = 39
        Align = alRight
        Caption = 'Excluir'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
      end
      object BitBtn3: TBitBtn
        Left = 516
        Top = 1
        Width = 75
        Height = 39
        Align = alRight
        Caption = 'Gravar'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
      end
      object BitBtn4: TBitBtn
        Left = 366
        Top = 1
        Width = 75
        Height = 39
        Align = alRight
        Caption = 'Editar'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 3
      end
    end
  end
end