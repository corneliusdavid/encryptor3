object frmEncryptor3: TfrmEncryptor3
  Left = 307
  Top = 245
  Caption = 'The Encryptor3!'
  ClientHeight = 413
  ClientWidth = 519
  Color = clBtnFace
  Constraints.MinHeight = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    519
    413)
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 31
    Top = 333
    Width = 40
    Height = 13
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&Result:'
    FocusControl = edtResultStr
  end
  object Label8: TLabel
    Left = 31
    Top = 184
    Width = 39
    Height = 13
    Caption = '&String:'
    FocusControl = edtSourceStr
  end
  object Label2: TLabel
    Left = 32
    Top = 8
    Width = 456
    Height = 78
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'These use TurboPack LockBox3 components found on GitHub to encry' +
      'pt and decrypt strings.  They are written using the simplest app' +
      'roach and are intended to generate obfuscated strings of data yo' +
      'u can hide in an application and decrypt at run-time.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object lblKey: TLabel
    Left = 31
    Top = 229
    Width = 27
    Height = 13
    Caption = '&Key:'
    FocusControl = edtPassphrase
  end
  object edtSourceStr: TEdit
    Left = 31
    Top = 200
    Width = 445
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object btnDecrypt: TButton
    Left = 315
    Top = 285
    Width = 117
    Height = 35
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&Decrypt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btnDecryptClick
  end
  object edtResultStr: TEdit
    Left = 31
    Top = 349
    Width = 445
    Height = 21
    TabStop = False
    Anchors = [akLeft, akRight, akBottom]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 6
  end
  object btnCopyLBSymmetricResult: TButton
    Left = 359
    Top = 373
    Width = 117
    Height = 27
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&Copy to Clipboard'
    TabOrder = 7
    OnClick = btnCopyLBSymmetricResultClick
  end
  object btnEncrypt: TButton
    Left = 93
    Top = 285
    Width = 117
    Height = 35
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&Encrypt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnEncryptClick
  end
  object radAlgorithm: TRadioGroup
    Left = 32
    Top = 78
    Width = 129
    Height = 100
    Caption = 'Encryption &Type'
    ItemIndex = 3
    Items.Strings = (
      'DES'
      'Blowfish'
      'Twofish'
      'Rijndael (AES)')
    TabOrder = 0
    OnClick = radAlgorithmClick
  end
  object radCipherMode: TRadioGroup
    Left = 264
    Top = 78
    Width = 211
    Height = 116
    Caption = 'Chain &Mode'
    ItemIndex = 0
    Items.Strings = (
      'CBC - Cipher Block Chaining'
      'CFB - Cipher Feedback'
      'CTR - Counter Mode'
      'ECB - Electronic Code Book')
    TabOrder = 1
  end
  object radAESKeySize: TRadioGroup
    Left = 167
    Top = 78
    Width = 91
    Height = 83
    Caption = 'AES Key Size'
    ItemIndex = 2
    Items.Strings = (
      '128'
      '192'
      '256')
    TabOrder = 2
  end
  object btnAbout: TButton
    Left = 31
    Top = 375
    Width = 83
    Height = 27
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&About ...'
    TabOrder = 8
    OnClick = btnAboutClick
  end
  object edtPassphrase: TEdit
    Left = 31
    Top = 248
    Width = 266
    Height = 21
    TabOrder = 9
  end
  object dlgAbout: TTaskDialog
    Buttons = <>
    Caption = 'About this Program'
    ExpandButtonCaption = 'GitHub'
    ExpandedText = 
      'https://github.com/corneliusdavid/encryptor  https://github.com/' +
      'corneliusdavid/LockBox-2.08'
    RadioButtons = <>
    Text = 
      'This program originally started as "Encryptor" and used Turbo Po' +
      'wer'#39's Lockbox 2.x. Encryptor3 now uses LockBox 3.x, the first ve' +
      'rsion supported is Delphi 10.1 Berlin but could quite easily be ' +
      'compiled in earlier versions.'
    Left = 392
    Top = 208
  end
  object lbCodec: TCodec
    AsymetricKeySizeInBits = 0
    AdvancedOptions2 = []
    CryptoLibrary = CryptoLib
    Left = 216
    Top = 192
    StreamCipherId = 'native.StreamToBlock'
    BlockCipherId = 'native.AES-128'
    ChainId = 'native.CBC'
  end
  object CryptoLib: TCryptographicLibrary
    Left = 256
    Top = 208
  end
  object dlgAESKeySizeErr: TTaskDialog
    Buttons = <>
    Caption = 'Invalid AES Key Size'
    RadioButtons = <>
    Text = 'For AES, the length of the key string must be:'
    Left = 440
    Top = 224
  end
end
