object frmConfigBalanca: TfrmConfigBalanca
  Left = 270
  Top = 172
  ActiveControl = btnConectar
  BorderStyle = bsNone
  Caption = 'f'
  ClientHeight = 294
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 211
    Top = 51
    Width = 77
    Height = 13
    Caption = 'Ultima Resposta'
    Color = clBtnFace
    ParentColor = False
  end
  object Label3: TLabel
    Left = 211
    Top = 7
    Width = 81
    Height = 13
    Caption = 'Ultimo Peso Lido:'
    Color = clBtnFace
    ParentColor = False
  end
  object Label9: TLabel
    Left = 343
    Top = 186
    Width = 40
    Height = 13
    Caption = 'TimeOut'
    Color = clBtnFace
    ParentColor = False
  end
  object Label10: TLabel
    Left = 211
    Top = 115
    Width = 51
    Height = 13
    Caption = 'Mensagem'
    Color = clBtnFace
    ParentColor = False
  end
  object btnConectar: TButton
    Left = 211
    Top = 252
    Width = 95
    Height = 32
    Caption = 'Ativar'
    TabOrder = 0
    OnClick = btnConectarClick
  end
  object btnDesconectar: TButton
    Left = 305
    Top = 252
    Width = 94
    Height = 32
    Caption = 'Desativar'
    Enabled = False
    TabOrder = 1
    OnClick = btnDesconectarClick
  end
  object btnLerPeso: TButton
    Left = 398
    Top = 252
    Width = 95
    Height = 32
    Caption = 'Ler Peso'
    Enabled = False
    TabOrder = 2
    OnClick = btnLerPesoClick
  end
  object sttPeso: TStaticText
    Left = 211
    Top = 22
    Width = 375
    Height = 24
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object sttResposta: TStaticText
    Left = 213
    Top = 70
    Width = 375
    Height = 32
    AutoSize = False
    TabOrder = 8
  end
  object edtTimeOut: TEdit
    Left = 343
    Top = 205
    Width = 243
    Height = 21
    TabOrder = 3
    Text = '2000'
    OnKeyPress = edtTimeOutKeyPress
  end
  object chbMonitorar: TCheckBox
    Left = 211
    Top = 207
    Width = 126
    Height = 19
    Caption = 'Monitorar a Balan'#231'a'
    TabOrder = 4
    OnClick = chbMonitorarClick
  end
  object Memo1: TMemo
    Left = 211
    Top = 134
    Width = 375
    Height = 42
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 3
    Top = 3
    Width = 177
    Height = 281
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 6
    object Label1: TLabel
      Left = 16
      Top = 6
      Width = 37
      Height = 13
      Caption = 'Balanca'
      Color = clBtnFace
      ParentColor = False
    end
    object Label4: TLabel
      Left = 16
      Top = 49
      Width = 55
      Height = 13
      Caption = 'Porta Serial'
      Color = clBtnFace
      ParentColor = False
    end
    object Label5: TLabel
      Left = 16
      Top = 92
      Width = 47
      Height = 13
      Caption = 'Baud rate'
      Color = clBtnFace
      ParentColor = False
    end
    object Label6: TLabel
      Left = 16
      Top = 137
      Width = 43
      Height = 13
      Caption = 'Data Bits'
      Color = clBtnFace
      ParentColor = False
    end
    object Label7: TLabel
      Left = 92
      Top = 137
      Width = 28
      Height = 13
      Caption = 'Parity'
      Color = clBtnFace
      ParentColor = False
    end
    object Label8: TLabel
      Left = 16
      Top = 227
      Width = 61
      Height = 13
      Caption = 'Handshaking'
      Color = clBtnFace
      ParentColor = False
    end
    object Label11: TLabel
      Left = 16
      Top = 183
      Width = 42
      Height = 13
      Caption = 'Stop Bits'
      Color = clBtnFace
      ParentColor = False
    end
    object cmbBalanca: TComboBox
      Left = 16
      Top = 22
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Nenhuma'
      Items.Strings = (
        'Nenhuma'
        'Filizola'
        'Toledo')
    end
    object cmbPortaSerial: TComboBox
      Left = 16
      Top = 65
      Width = 145
      Height = 21
      TabOrder = 1
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8')
    end
    object cmbBaudRate: TComboBox
      Left = 16
      Top = 110
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 2
      Text = '300'
      Items.Strings = (
        '110'
        '300'
        '600'
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '38400'
        '56000'
        '57600')
    end
    object cmbDataBits: TComboBox
      Left = 16
      Top = 154
      Width = 70
      Height = 21
      Style = csDropDownList
      ItemIndex = 3
      TabOrder = 3
      Text = '8'
      Items.Strings = (
        '5'
        '6'
        '7'
        '8')
    end
    object cmbHandShaking: TComboBox
      Left = 16
      Top = 246
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 6
      Text = 'Nenhum'
      Items.Strings = (
        'Nenhum'
        'XON/XOFF'
        'RTS/CTS'
        'DTR/DSR')
    end
    object cmbParity: TComboBox
      Left = 90
      Top = 154
      Width = 71
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = 'none'
      Items.Strings = (
        'none'
        'odd'
        'even'
        'mark'
        'space')
    end
    object cmbStopBits: TComboBox
      Left = 16
      Top = 196
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 5
      Text = 's1'
      Items.Strings = (
        's1'
        's1,5'
        's2'
        '')
    end
  end
  object Button1: TButton
    Left = 492
    Top = 252
    Width = 94
    Height = 32
    Caption = 'Gravar'
    CommandLinkHint = 'Gravar'
    TabOrder = 9
    OnClick = Button1Click
  end
  object ACBrBAL1: TACBrBAL
    Porta = 'COM1'
    OnLePeso = ACBrBAL1LePeso
    Left = 520
    Top = 65532
  end
end
