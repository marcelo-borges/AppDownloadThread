program ProjetoThread;

uses
  Vcl.Forms,
  uFrmPrincipal in 'view\uFrmPrincipal.pas' {frmPrincipal},
  uDmConexao in 'dao\uDmConexao.pas' {dmConexao: TDataModule},
  uDmLogDownload in 'dao\uDmLogDownload.pas' {dmLogDownload: TDataModule},
  uLogDownload in 'model\uLogDownload.pas',
  uLogDownloadController in 'controller\uLogDownloadController.pas',
  uFrmVisualizarLogs in 'view\uFrmVisualizarLogs.pas' {frmVisualizarLogs},
  uThreadDownload in 'threads\uThreadDownload.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
