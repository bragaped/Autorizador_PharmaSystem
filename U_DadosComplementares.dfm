object F_DadosComplementares: TF_DadosComplementares
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Dados Complementares'
  ClientHeight = 172
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LEstado: TLabel
    Left = 36
    Top = 12
    Width = 33
    Height = 13
    Caption = 'Estado'
  end
  object lConselho: TLabel
    Left = 25
    Top = 39
    Width = 44
    Height = 13
    Caption = 'Conselho'
  end
  object LNRegistro: TLabel
    Left = 14
    Top = 66
    Width = 55
    Height = 13
    Caption = 'N'#186' Registro'
  end
  object LDataReceita: TLabel
    Left = 7
    Top = 93
    Width = 62
    Height = 13
    Caption = 'Data Receita'
    FocusControl = eDataReceita
  end
  object LComplemento: TLabel
    Left = 4
    Top = 118
    Width = 65
    Height = 13
    Caption = 'Complemento'
  end
  object btOK: TBitBtn
    Left = 129
    Top = 143
    Width = 75
    Height = 25
    Caption = '&OK'
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = btOKClick
  end
  object eDataReceita: TJvDateEdit
    Left = 75
    Top = 89
    Width = 120
    Height = 21
    CheckOnExit = True
    DefaultToday = True
    TabOrder = 3
  end
  object eEstado: TComboBox
    Left = 75
    Top = 8
    Width = 73
    Height = 21
    AutoCloseUp = True
    Style = csDropDownList
    TabOrder = 0
    OnKeyDown = eEstadoKeyDown
    Items.Strings = (
      'AC'
      'AL'
      'AM'
      'AP'
      'BA'
      'CE'
      'DF'
      'ES'
      'GO'
      'MA'
      'MG'
      'MS'
      'MT'
      'PA'
      'PB'
      'PE'
      'PI'
      'PR'
      'RJ'
      'RN'
      'RO'
      'RR'
      'RS'
      'SC'
      'SE'
      'SP'
      'TO')
  end
  object eConselho: TComboBox
    Left = 75
    Top = 35
    Width = 73
    Height = 21
    AutoCloseUp = True
    Style = csDropDownList
    TabOrder = 1
    OnKeyDown = eEstadoKeyDown
    Items.Strings = (
      'CRM'
      'CRO')
  end
  object eNRegistro: TEdit
    Left = 75
    Top = 62
    Width = 120
    Height = 21
    MaxLength = 9
    TabOrder = 2
    OnKeyPress = eNRegistroKeyPress
  end
  object eComplemento: TEdit
    Left = 75
    Top = 116
    Width = 250
    Height = 21
    MaxLength = 40
    TabOrder = 4
  end
end
