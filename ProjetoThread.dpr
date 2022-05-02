program ProjetoThread;

uses
  Vcl.Forms,
  uFrmPrincipal in 'view\uFrmPrincipal.pas' {frmPrincipal},
  Model.DmConexao in 'model\Model.DmConexao.pas' {dmConexao: TDataModule},
  Model.DmLogDownload in 'model\Model.DmLogDownload.pas' {dmLogDownload: TDataModule},
  Controller.LogDownload in 'controller\Controller.LogDownload.pas',
  uFrmVisualizarLogs in 'view\uFrmVisualizarLogs.pas' {frmVisualizarLogs},
  Model.ThreadDownload in 'model\Model.ThreadDownload.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
