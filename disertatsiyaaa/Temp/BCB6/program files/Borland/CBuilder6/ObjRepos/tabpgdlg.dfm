object PagesDlg: TPagesDlg
  Left = 195
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Tabbed Notebook Dialog'
  ClientHeight = 300
  ClientWidth = 427
  ParentFont = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 266
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 5
      Top = 5
      Width = 417
      Height = 256
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'TabSheet1'
      end
      object TabSheet2: TTabSheet
        Caption = 'TabSheet2'
      end
      object TabSheet3: TTabSheet
        Caption = 'TabSheet3'
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 266
    Width = 427
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object OKBtn: TButton
      Left = 187
      Top = 2
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 267
      Top = 2
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object HelpBtn: TButton
      Left = 347
      Top = 2
      Width = 75
      Height = 25
      Caption = '&Help'
      TabOrder = 2
    end
  end
end
