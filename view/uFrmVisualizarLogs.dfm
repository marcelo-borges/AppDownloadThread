object frmVisualizarLogs: TfrmVisualizarLogs
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderWidth = 5
  Caption = 'Visualizar Logs de Downloads'
  ClientHeight = 419
  ClientWidth = 919
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object dbgDados: TDBGrid
    Left = 0
    Top = 0
    Width = 919
    Height = 419
    Align = alClient
    DataSource = dsLogDownload
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'URL'
        Title.Caption = 'Url'
        Width = 413
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAINICIO'
        Title.Caption = 'Data In'#237'cio'
        Width = 182
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAFIM'
        Title.Caption = 'Data Fim'
        Width = 173
        Visible = True
      end>
  end
  object dsLogDownload: TDataSource
    Left = 352
    Top = 184
  end
end
