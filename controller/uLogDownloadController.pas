unit uLogDownloadController;

interface

uses uLogDownload, uDmLogDownload, System.SysUtils, Data.DB;

type
  TLogDownloadController = class
    private
      FLogDownload: TdmLogDownload;
    public
      constructor Create;
      destructor Destroy;
      function Inserir(ALogDownload: TLogDownload): Boolean;
      function Alterar(ALogDownload: TLogDownload): Boolean;
      function BuscarTodosOsRegistros: TDataset;
      function BuscarUltimoRegistroInserido: TLogDownload;
  end;

implementation

{ TLogDownloadController }

function TLogDownloadController.Alterar(ALogDownload: TLogDownload): Boolean;
var
  lErro: string;
begin
  Result := FLogDownload.Alterar(ALogDownload, lErro);
  if not Result then
    raise Exception.Create(lErro);
end;

function TLogDownloadController.BuscarTodosOsRegistros: TDataset;
var
  lErro: string;
begin
  Result := FLogDownload.BuscarTodosOsRegistros(lErro);
  if not Assigned(Result) then
    raise Exception.Create(lErro);
end;

function TLogDownloadController.BuscarUltimoRegistroInserido: TLogDownload;
var
  lErro: string;
begin
  Result := FLogDownload.BuscarUltimoRegistroInserido(lErro);
  if not Assigned(Result) then
    raise Exception.Create(lErro);
end;

constructor TLogDownloadController.Create;
begin
  FLogDownload := TdmLogDownload.Create(nil);
end;

destructor TLogDownloadController.Destroy;
begin
  FreeAndNil(FLogDownload);
end;

function TLogDownloadController.Inserir(ALogDownload: TLogDownload): Boolean;
var
  lErro: string;
begin
  Result := FLogDownload.Inserir(ALogDownload, lErro);
  if not Result then
    raise Exception.Create(lErro);
end;

end.
