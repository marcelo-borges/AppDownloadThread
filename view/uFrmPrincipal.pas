unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  IdTCPConnection, IdTCPClient, IdHTTP, IdAntiFreezeBase, Vcl.IdAntiFreeze,
  IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.ComCtrls, Model.ThreadDownload;

type
  TfrmPrincipal = class(TForm)
    edtLinkDownload: TLabeledEdit;
    btnIniciarDownload: TBitBtn;
    btnExibirMensagem: TBitBtn;
    btnParar: TBitBtn;
    btnExibirHistorico: TBitBtn;
    lblMensagem: TLabel;
    BarraProgresso: TProgressBar;
    procedure btnExibirMensagemClick(Sender: TObject);
    procedure btnIniciarDownloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPararClick(Sender: TObject);
    procedure btnExibirHistoricoClick(Sender: TObject);
  private
    { Private declarations }
    FThreadDownload: TThreadDownload;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uFrmVisualizarLogs;

{$R *.dfm}

procedure TfrmPrincipal.btnExibirHistoricoClick(Sender: TObject);
begin
  frmVisualizarLogs := TfrmVisualizarLogs.Create(nil);
  frmVisualizarLogs.ShowModal;
end;

procedure TfrmPrincipal.btnExibirMensagemClick(Sender: TObject);
begin
  lblMensagem.Visible := not lblMensagem.Visible;
end;

procedure TfrmPrincipal.btnIniciarDownloadClick(Sender: TObject);
begin
  if edtLinkDownload.Text = EmptyStr then
  begin
    Application.MessageBox('Necessário incluir a URL para download!', 'Atenção?', MB_ICONINFORMATION);
    edtLinkDownload.SetFocus;
    Abort;
  end
  else
  begin
    FThreadDownload := TThreadDownload.Create(BarraProgresso, lblMensagem);
    FThreadDownload.FazerDownload(edtLinkDownload.Text);
  end;
end;

procedure TfrmPrincipal.btnPararClick(Sender: TObject);
begin
  if Assigned(FThreadDownload) then
  begin
    if FThreadDownload.Status = stExecutando then
      FThreadDownload.CancelarDownload;
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FThreadDownload) then
  begin
    if FThreadDownload.Status = stExecutando then
    begin
      if Application.MessageBox('Existe um download em andamento, deseja interrompe-lo? ' +
       '[Sim, Não]', 'Confirma?', MB_YESNO + MB_ICONINFORMATION) = IDYES then
      begin
        FThreadDownload.CancelarDownload;
      end;
    end;
  end;
end;

end.
