object FrPercursoUF: TFrPercursoUF
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'UF de Percurso.'
  ClientHeight = 88
  ClientWidth = 172
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 166
    Height = 46
    Align = alClient
    Caption = 'UF'
    TabOrder = 0
    object Uf: TRzComboBox
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 156
      Height = 21
      Align = alTop
      Style = csDropDownList
      TabOrder = 0
      Items.Strings = (
        'AC'
        'AL'
        'AP'
        'AM'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MT'
        'MS'
        'MG'
        'PA'
        'PB'
        'PR'
        'PE'
        'PI'
        'RJ'
        'RN'
        'RS'
        'RO'
        'RR'
        'SC'
        'SP'
        'SE'
        'TO')
      Values.Strings = (
        'AC'
        'AL'
        'AP'
        'AM'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MT'
        'MS'
        'MG'
        'PA'
        'PB'
        'PR'
        'PE'
        'PI'
        'RJ'
        'RN'
        'RS'
        'RO'
        'RR'
        'SC'
        'SP'
        'SE'
        'TO')
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 52
    Width = 172
    HotTrack = True
    OKDefault = False
    ModalResultOk = 0
    OnClickOk = RzDialogButtons1ClickOk
    TabOrder = 1
  end
end
