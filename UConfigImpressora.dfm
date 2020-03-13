object frmConfigImpressora: TfrmConfigImpressora
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmConfigImpressora'
  ClientHeight = 294
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 264
    Top = 11
    Width = 76
    Height = 13
    Caption = '1'#170' Linha (texto)'
  end
  object Label2: TLabel
    Left = 264
    Top = 38
    Width = 76
    Height = 13
    Caption = '2'#170' Linha (texto)'
  end
  object Label3: TLabel
    Left = 264
    Top = 65
    Width = 76
    Height = 13
    Caption = '3'#170' Linha (texto)'
  end
  object Label4: TLabel
    Left = 264
    Top = 92
    Width = 87
    Height = 13
    Caption = '4'#170' Linha (Numero)'
  end
  object gbConfiguracao: TGroupBox
    Left = 0
    Top = 0
    Width = 246
    Height = 294
    Align = alLeft
    Caption = 'Configura'#231#245'es da Impressora'
    TabOrder = 0
    DesignSize = (
      246
      294)
    object lbModelo: TLabel
      Left = 128
      Top = 114
      Width = 38
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Modelo:'
      Color = clBtnFace
      ParentColor = False
    end
    object lbPorta: TLabel
      Left = 10
      Top = 21
      Width = 30
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Porta:'
      Color = clBtnFace
      ParentColor = False
    end
    object lbAvanco: TLabel
      Left = 10
      Top = 113
      Width = 59
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Avan'#231'o Etq:'
      Color = clBtnFace
      ParentColor = False
    end
    object lbDPI: TLabel
      Left = 10
      Top = 163
      Width = 78
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'DPI Impressora:'
      Color = clBtnFace
      ParentColor = False
    end
    object lbTemperatura: TLabel
      Left = 10
      Top = 65
      Width = 66
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Temperatura:'
      Color = clBtnFace
      ParentColor = False
    end
    object lbBackFeed: TLabel
      Left = 128
      Top = 163
      Width = 50
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'BackFeed:'
      Color = clBtnFace
      ParentColor = False
    end
    object lbTemperatura1: TLabel
      Left = 128
      Top = 65
      Width = 55
      Height = 13
      Hint = 'Utilize '#39'-1'#39' para usar velocidade padr'#227'o da impressora'
      Anchors = [akLeft, akBottom]
      Caption = 'Velocidade:'
      Color = clBtnFace
      ParentColor = False
    end
    object cbModelo: TComboBox
      Left = 128
      Top = 133
      Width = 115
      Height = 21
      Style = csDropDownList
      ItemIndex = 3
      TabOrder = 4
      Text = 'etqZPLII'
      Items.Strings = (
        'etqNenhuma'
        'etqPpla'
        'etqPPlb'
        'etqZPLII'
        'etqEpl2')
    end
    object eAvanco: TEdit
      Left = 10
      Top = 133
      Width = 115
      Height = 21
      TabOrder = 2
    end
    object cbDPI: TComboBox
      Left = 10
      Top = 182
      Width = 115
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 5
      Text = 'dpi203'
      Items.Strings = (
        'dpi203'
        'dpi300'
        'dpi600')
    end
    object eTemperatura: TEdit
      Left = 10
      Top = 84
      Width = 115
      Height = 21
      TabOrder = 0
      Text = '10'
    end
    object cbBackFeed: TComboBox
      Left = 128
      Top = 182
      Width = 115
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 6
      Text = 'bfNone'
      Items.Strings = (
        'bfNone'
        'bfOn'
        'bfOff')
    end
    object eVelocidade: TEdit
      Left = 128
      Top = 84
      Width = 115
      Height = 21
      Hint = 'Utilize '#39'-1'#39' para usar velocidade padr'#227'o da impressora'
      TabOrder = 1
      Text = '-1'
    end
    object ckMemoria: TCheckBox
      Left = 10
      Top = 229
      Width = 94
      Height = 19
      Caption = 'Limpar Mem'#243'ria'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object edtPorta: TEdit
      Left = 10
      Top = 40
      Width = 233
      Height = 21
      TabOrder = 7
    end
  end
  object Button1: TButton
    Left = 477
    Top = 254
    Width = 115
    Height = 32
    Caption = 'Gravar'
    CommandLinkHint = 'Gravar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object btnImprimir: TButton
    Left = 363
    Top = 254
    Width = 115
    Height = 32
    Caption = 'Imprimir teste'
    TabOrder = 2
    OnClick = btnImprimirClick
  end
  object btnConectar: TButton
    Left = 249
    Top = 254
    Width = 115
    Height = 32
    Caption = 'Ativar'
    TabOrder = 3
    OnClick = btnConectarClick
  end
  object edtLinha1: TEdit
    Left = 353
    Top = 8
    Width = 223
    Height = 21
    TabOrder = 4
  end
  object edtLinha2: TEdit
    Left = 353
    Top = 35
    Width = 223
    Height = 21
    TabOrder = 5
  end
  object edtLinha3: TEdit
    Left = 353
    Top = 62
    Width = 223
    Height = 21
    TabOrder = 6
  end
  object edtLinha4: TEdit
    Left = 353
    Top = 89
    Width = 223
    Height = 21
    TabOrder = 7
  end
end
