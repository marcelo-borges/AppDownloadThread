unit uFrmVisualizarLogs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Data.DB;

type
  TfrmVisualizarLogs = class(TForm)
    dbgDados: TDBGrid;
    dsLogDownload: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVisualizarLogs: TfrmVisualizarLogs;

implementation

uses Controller.LogDownload;

{$R *.dfm}

procedure TfrmVisualizarLogs.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmVisualizarLogs := nil;
  Action := caFree;
end;

procedure TfrmVisualizarLogs.FormCreate(Sender: TObject);
var
  ALogDownloadController: TLogDownloadController;
begin
  ALogDownloadController := TLogDownloadController.Create;
  try
    try
      dsLogDownload.DataSet := ALogDownloadController.BuscarTodosOsRegistros;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    ALogDownloadController.Free;
  end;
end;

end.
