object FrPedidosVendasDataValor: TFrPedidosVendasDataValor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Data de Vencimento / Valor'
  ClientHeight = 204
  ClientWidth = 425
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object RzPanel5: TRzPanel
    AlignWithMargins = True
    Left = 3
    Top = 40
    Width = 419
    Height = 121
    Margins.Top = 0
    Align = alTop
    BorderOuter = fsNone
    Color = clSilver
    TabOrder = 0
    object Label1: TLabel
      Left = 3
      Top = 2
      Width = 76
      Height = 19
      Caption = 'Vencimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 139
      Top = 2
      Width = 33
      Height = 19
      Caption = 'Valor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 288
      Top = 2
      Width = 55
      Height = 19
      Caption = 'Parcelas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 355
      Top = 2
      Width = 29
      Height = 19
      Caption = 'Dias'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object eValor: TJvCalcEdit
      AlignWithMargins = True
      Left = 139
      Top = 23
      Width = 143
      Height = 31
      DisplayFormat = ',0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      ButtonWidth = 28
      ParentFont = False
      TabOrder = 1
      DecimalPlacesAlwaysShown = True
    end
    object eData: TJvDateEdit
      AlignWithMargins = True
      Left = 3
      Top = 23
      Width = 130
      Height = 31
      CheckOnExit = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      ButtonWidth = 28
      ParentFont = False
      ShowNullDate = False
      TabOrder = 0
    end
    object eObservacao: TRzMemo
      AlignWithMargins = True
      Left = 3
      Top = 59
      Width = 413
      Height = 59
      Margins.Top = 0
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object ed_parcelas: TJvSpinEdit
      Left = 288
      Top = 23
      Width = 61
      Height = 31
      Alignment = taCenter
      DisplayFormat = '0'
      ButtonKind = bkClassic
      MaxValue = 100.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnChange = ed_parcelasChange
    end
    object ed_dias_entre: TJvSpinEdit
      Left = 355
      Top = 23
      Width = 61
      Height = 31
      Alignment = taCenter
      DisplayFormat = '0'
      ButtonKind = bkClassic
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    AlignWithMargins = True
    Left = 3
    Top = 165
    Width = 419
    HotTrack = True
    OKDefault = False
    ModalResultOk = 0
    OnClickOk = RzDialogButtons1ClickOk
    Color = clSilver
    TabOrder = 1
  end
  object pnTitulo: TRzPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 419
    Height = 34
    Align = alTop
    BorderOuter = fsNone
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object ACBrEnterTab1: TACBrEnterTab
    EnterAsTab = True
    Left = 17
    Top = 115
  end
end