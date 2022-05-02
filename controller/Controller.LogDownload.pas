unit Controller.LogDownload;

interface

uses Model.DmLogDownload, System.SysUtils, Data.DB;

type
  TLogDownloadController = class
    private
      FLogDownload: TdmLogDownload;
    public
      constructor Create;
      function Inserir(AUrl: string; ADataInicio: TDateTime): Integer;
      procedure Alterar(ACodigo: Integer; ADataFim: TDateTime);
      function BuscarTodosOsRegistros: TDataset;
  end;

implementation

{ TLogDownloadController }

procedure TLogDownloadController.Alterar(ACodigo: Integer; ADataFim: TDateTime);
begin
  FLogDownload.Alterar(ACodigo, ADataFim);
end;

function TLogDownloadController.BuscarTodosOsRegistros: TDataset;

begin
  Result := FLogDownload.BuscarTodosOsRegistros;
end;

constructor TLogDownloadController.Create;
begin
  FLogDownload := TdmLogDownload.Create(nil);
end;

function TLogDownloadController.Inserir(AUrl: string; ADataInicio: TDateTime): Integer;
begin
  Result := FLogDownload.Inserir(AUrl, ADataInicio);
end;

end.
