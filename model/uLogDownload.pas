unit uLogDownload;

interface

uses System.SysUtils;

type
  TLogDownload = class
    private
      FCodigo: Integer;
      FUrl: string;
      FDataInicio: TDateTime;
      FDataFim: TDateTime;
      procedure SetCodigo(const Value: Integer);
      procedure SetUrl(const Value: string);
      procedure SetDataInicio(const Value: TDateTime);
      procedure SetDataFim(const Value: TDateTime);
    public
      property Codigo: Integer read FCodigo write SetCodigo;
      property Url: string read FUrl write SetUrl;
      property DataInicio: TDateTime read FDataInicio write SetDataInicio;
      property DataFim: TDateTime read FDataFim write SetDataFim;
  end;
implementation

{ TLogDownload }

procedure TLogDownload.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TLogDownload.SetDataFim(const Value: TDateTime);
begin
  FDataFim := Value;
end;

procedure TLogDownload.SetDataInicio(const Value: TDateTime);
begin
  if Value = 0 then
    raise Exception.Create('Data início precisa ser preenchida.');
  FDataInicio := Value;
end;

procedure TLogDownload.SetUrl(const Value: string);
begin
  if Value = EmptyStr then
    raise Exception.Create('Url precisa ser preenchida.');
  FUrl := Value;
end;

end.
