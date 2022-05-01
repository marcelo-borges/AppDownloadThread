unit uDmLogDownload;

interface

uses
  System.SysUtils, System.Classes, uDmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, uLogDownload;

type
  TdmLogDownload = class(TdmConexao)
  private
    { Private declarations }
  public
    { Public declarations }
    function Inserir(ALogDownload: TLogDownload; out sErro: string): Boolean;
    function Alterar(ALogDownload: TLogDownload; out sErro: string): Boolean;
    function BuscarTodosOsRegistros(out sErro: string): TDataset;
    function BuscarUltimoRegistroInserido(out sErro: string): TLogDownload;
  end;

var
  dmLogDownload: TdmLogDownload;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmLogDownload }

function TdmLogDownload.Alterar(ALogDownload: TLogDownload;
  out sErro: string): Boolean;
begin
  qryAuxiliar.Close;
  qryAuxiliar.Open;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Add('UPDATE LOGDOWNLOAD SET URL = :URL,');
  qryAuxiliar.SQL.Add(' DATAINICIO = :DATAINICIO,');
  qryAuxiliar.SQL.Add(' DATAFIM = :DATAFIM ');
  qryAuxiliar.SQL.Add('WHERE CODIGO = :CODIGO');
  qryAuxiliar.Params.ParamByName('URL').AsString := ALogDownload.Url;
  qryAuxiliar.Params.ParamByName('DATAINICIO').AsDateTime := ALogDownload.DataInicio;
  qryAuxiliar.Params.ParamByName('DATAFIM').AsDateTime := ALogDownload.DataFim;
  qryAuxiliar.Params.ParamByName('CODIGO').AsInteger := ALogDownload.Codigo;

  try
    qryAuxiliar.ExecSQL;
    Result := True;
  except on E: Exception do
    begin
      Result := False;
      sErro := 'Falha ao alterar: ' + E.Message;
    end;
  end;
end;

function TdmLogDownload.BuscarTodosOsRegistros(out sErro: string): TDataset;
begin
  Result := nil;

  qryAuxiliar.Close;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Add('SELECT * FROM LOGDOWNLOAD');

  try
    qryAuxiliar.Open;
      Result := qryAuxiliar;
  except on E: Exception do
    begin
      sErro := 'Falha ao buscar todos os registros: ' + E.Message;
    end;
  end;
end;

function TdmLogDownload.BuscarUltimoRegistroInserido(out sErro: string): TLogDownload;
begin
  Result := nil;
  qryAuxiliar.Close;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Add('SELECT MAX(CODIGO) CODIGO, URL, DATAINICIO, DATAFIM FROM LOGDOWNLOAD ');
  qryAuxiliar.SQL.Add('GROUP BY URL, DATAINICIO, DATAFIM');

  try
    qryAuxiliar.Open;
    Result := TLogDownload.Create;
    Result.Codigo := qryAuxiliar.FieldByName('CODIGO').AsInteger;
    Result.Url := qryAuxiliar.FieldByName('URL').AsString;
    Result.DataInicio := qryAuxiliar.FieldByName('DATAINICIO').AsDateTime;
    Result.DataFim := qryAuxiliar.FieldByName('DATAFIM').AsDateTime;
  except on E: Exception do
    begin
      sErro := 'Falha ao buscar último registro inserido: ' + E.Message;
    end;
  end;
end;

function TdmLogDownload.Inserir(ALogDownload: TLogDownload;
  out sErro: string): Boolean;
begin
  Result := True;
  qryAuxiliar.Close;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Add('SELECT * FROM LOGDOWNLOAD');
  qryAuxiliar.SQL.Add('WHERE 1 = 2');

  try
    qryAuxiliar.Open;
  except on E: Exception do
    begin
      Result := False;
      sErro := 'Falha ao alterar: ' + E.Message;
    end;
  end;

  qryAuxiliar.Append;
  qryAuxiliar.Fields.FieldByName('URL').AsString := ALogDownload.Url;
  qryAuxiliar.Fields.FieldByName('DATAINICIO').AsDateTime := ALogDownload.DataInicio;

  try
    qryAuxiliar.Post;
  except on E: Exception do
    begin
      Result := False;
      sErro := 'Falha ao inserir: ' + E.Message;
    end;
  end;
end;

end.
