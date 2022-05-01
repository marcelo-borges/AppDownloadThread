object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Download de Arquivos(Thread)'
  ClientHeight = 308
  ClientWidth = 975
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblMensagem: TLabel
    Left = 64
    Top = 192
    Width = 36
    Height = 18
    Caption = '0 %'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object edtLinkDownload: TLabeledEdit
    Left = 20
    Top = 48
    Width = 931
    Height = 24
    EditLabel.Width = 93
    EditLabel.Height = 13
    EditLabel.Caption = 'Link para Download'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnIniciarDownload: TBitBtn
    Left = 56
    Top = 112
    Width = 193
    Height = 41
    Caption = 'Iniciar Download'
    TabOrder = 1
    OnClick = btnIniciarDownloadClick
  end
  object btnExibirMensagem: TBitBtn
    Left = 280
    Top = 112
    Width = 193
    Height = 41
    Caption = 'Exibir Mensagem'
    TabOrder = 2
    OnClick = btnExibirMensagemClick
  end
  object btnParar: TBitBtn
    Left = 504
    Top = 112
    Width = 193
    Height = 41
    Caption = 'Parar Download'
    TabOrder = 3
    OnClick = btnPararClick
  end
  object btnExibirHistorico: TBitBtn
    Left = 720
    Top = 112
    Width = 193
    Height = 41
    Caption = 'Exibir Hist'#243'rico de Downloads'
    TabOrder = 4
    OnClick = btnExibirHistoricoClick
  end
  object BarraProgresso: TProgressBar
    Left = 56
    Top = 248
    Width = 857
    Height = 33
    TabOrder = 5
  end
end
