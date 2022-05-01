unit uThreadDownload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, StrUtils,
  StdCtrls, ComCtrls, ExtCtrls, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerStream,
  System.Threading, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Forms,
  uLogDownload, uLogDownloadController;

type
  TStatus = (stExecutando, stFinalizadoComErro, stCanceladoPeloUsuario, stFinalizadoComSucesso);

  TThreadDownload = class(TThread)
  private
    FPosicao: Integer;
    FProgressBar: TProgressBar;
    FIdHTTP: TIdHTTP;
    FIdAntiFreeze: TIdAntiFreeze;
    FIdSSHandler: TIdSSLIOHandlerSocketOpenSSL;
    FLabel: TLabel;
    FStatus: TStatus;
    FTarefa: itask;
    FlogDownload: TLogDownload;
    FLogDownloadController: TLogDownloadController;

    procedure ConfigurarHTTPDownload;

    function GetNomeArquivo(AUrl: string): string;
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
                              AWorkCountMax: Int64);
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);

    function RetornaPorcentagemDownload(AValorMax, AValorAtual: Double): string;

    procedure AtualizaComponentes;
    procedure SetStatus(const Value: TStatus);
    function GetStatus: TStatus;
  public
    constructor Create(AProgressBar: TProgressBar; ALabel: TLabel); reintroduce;
    destructor Destroy;

    procedure FazerDownload(AUrl: string);
    procedure CancelarDownload;

    property Status: TStatus read GetStatus write SetStatus;
  end;

implementation

{ TThreadDownload }

procedure TThreadDownload.AtualizaComponentes;
begin
  FProgressBar.Position := FPosicao;
  FLabel.Caption := RetornaPorcentagemDownload(FProgressBar.Max, FProgressBar.Position);
end;

procedure TThreadDownload.CancelarDownload;
begin
  FTarefa.Cancel;
  FStatus := stCanceladoPeloUsuario;
  FlogDownload.DataFim := Now;
  FLogDownloadController.Alterar(FlogDownload);
end;

procedure TThreadDownload.ConfigurarHTTPDownload;
begin
  FIdHTTP :=  TIdHTTP.Create(nil);
  FIdSSHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdSSHandler.SSLOptions.Method := sslvSSLv23;
  FIdHTTP.IOHandler := FIdSSHandler;
  FIdHTTP.AllowCookies := True;
  FIdHTTP.HTTPOptions := [hoForceEncodeParams];
  FIdHTTP.OnWorkBegin := IdHTTPWorkBegin;
  FIdHTTP.OnWork := IdHTTPWork;
  FIdHTTP.OnWorkEnd := IdHTTPWorkEnd;

  FIdAntiFreeze := TIdAntiFreeze.Create(nil);
end;

constructor TThreadDownload.Create(AProgressBar: TProgressBar; ALabel: TLabel);
begin
  inherited Create(True);
  FStatus := stExecutando;
  FreeOnTerminate := True;
  FLabel := ALabel;

  FProgressBar := AProgressBar;
  ConfigurarHTTPDownload;
  FLogDownload := TLogDownload.Create;
  FLogDownloadController := TLogDownloadController.Create;
end;


destructor TThreadDownload.Destroy;
begin
  FreeAndNil(FLogDownload);
  FreeAndNil(FLogDownloadController);
end;

procedure TThreadDownload.FazerDownload(AUrl: string);
begin

  FlogDownload.Url := AUrl;
  FlogDownload.DataInicio := Now;
  FLogDownloadController.Inserir(FlogDownload);

  FlogDownload := FLogDownloadController.BuscarUltimoRegistroInserido;

  FTarefa := TTask.Create(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      var
        path: string;
        Arquivo: TStream;
      begin
        path := ExtractFileDir(Application.ExeName) + '\Download\';
        if not DirectoryExists(path) then
          CreateDir(path);

        Arquivo := TFileStream.Create(path + GetNomeArquivo(AUrl), fmcreate);
        try
          try
            FIdHTTP.Get(StringReplace(AUrl,'https','http',[rfReplaceAll]), Arquivo);
            FStatus := stFinalizadoComSucesso;

            FlogDownload.DataFim := Now;
            FLogDownloadController.Alterar(FlogDownload);

          except
            On E: Exception do
            begin
              FStatus := stFinalizadoComErro;
              FlogDownload.DataFim := Now;
              FLogDownloadController.Alterar(FlogDownload);
              raise Exception.Create('Erro ao realizar o download do arquivo.' + sLineBreak + E.Message);
            end;
          end;
        finally
          begin
            FreeAndNil(FIdAntiFreeze);
            FreeAndNil(FIdHTTP);
            FreeAndNil(Arquivo);
          end;
        end;
      end
      );
    end
  );

  try
    FTarefa.Start;
  except
    on E:Exception do
    begin
      FStatus := stFinalizadoComErro;
      FlogDownload.DataFim := Now;
      FLogDownloadController.Alterar(FlogDownload);
      raise Exception.Create('Erro ao rodar thread: ' + E.Message);
    end;
  end;
end;

function TThreadDownload.GetNomeArquivo(AUrl: string): string;
var
  i: Integer;
begin
  i := LastDelimiter('/', AUrl);

  Result := copy(AUrl, i + 1, length(AUrl));
end;

function TThreadDownload.GetStatus: TStatus;
begin
  Result := FStatus;
end;

procedure TThreadDownload.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  FTarefa.CheckCanceled;
  FPosicao := AWorkCount;
  Synchronize(AtualizaComponentes);
end;

procedure TThreadDownload.IdHTTPWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  if (AWorkCountMax > MaxInt) then
    FProgressBar.Max := Trunc(AWorkCountMax / 10)
  else
    FProgressBar.Max := AWorkCountMax;
end;

procedure TThreadDownload.IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  FProgressBar.Position := 0;
  if not (FTarefa.Status = TTaskStatus.Canceled) then
    FLabel.Caption := 'Download finalizado com sucesso ...'
  else
    FLabel.Caption := 'Download cancelado pelo usuário ...';
  FLabel.Visible := True;
end;

function TThreadDownload.RetornaPorcentagemDownload(AValorMax,
  AValorAtual: Double): string;
begin
  Result := FormatFloat('0 %', ((aValorAtual * 100)  / aValorMax))
end;

procedure TThreadDownload.SetStatus(const Value: TStatus);
begin
  FStatus := Value;
end;

end.
