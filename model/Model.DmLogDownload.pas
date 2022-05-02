unit Model.DmLogDownload;

interface

uses
  System.SysUtils, System.Classes, Model.DmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmLogDownload = class(TdmConexao)
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function BuscarUltimoCodigoInserid: Integer;
  public
    { Public declarations }
    function Inserir(AUrl: string; ADataInicio: TDateTime): Integer;
    procedure Alterar(ACodigo: Integer; ADataFim: TDateTime);
    function BuscarTodosOsRegistros: TDataset;
  end;

var
  dmLogDownload: TdmLogDownload;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmLogDownload }

procedure TdmLogDownload.Alterar(ACodigo: Integer; ADataFim: TDateTime);
begin
  qryAuxiliar.Close;
  qryAuxiliar.Open;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Add('UPDATE LOGDOWNLOAD SET ');
  qryAuxiliar.SQL.Add(' DATAFIM = :DATAFIM ');
  qryAuxiliar.SQL.Add('WHERE CODIGO = :CODIGO');
  qryAuxiliar.Params.ParamByName('DATAFIM').AsDateTime := ADataFim;
  qryAuxiliar.Params.ParamByName('CODIGO').AsInteger := ACodigo;

  try
    qryAuxiliar.ExecSQL;
  except on E: Exception do
    raise Exception.Create('Falha ao alterar: ' + sLineBreak + E.Message);
  end;
end;

function TdmLogDownload.BuscarTodosOsRegistros: TDataset;
begin
  qryAuxiliar.Close;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Add('SELECT * FROM LOGDOWNLOAD');

  try
    qryAuxiliar.Open;
      Result := qryAuxiliar;
  except on E: Exception do
    raise Exception.Create('Falha ao buscar todos os registros: ' + sLineBreak + E.Message);
  end;
end;

function TdmLogDownload.BuscarUltimoCodigoInserid: Integer;
begin
  qryAuxiliar.Close;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Add('SELECT MAX(CODIGO) CODIGO FROM LOGDOWNLOAD ');

  try
    qryAuxiliar.Open;
    Result := qryAuxiliar.FieldByName('CODIGO').AsInteger;
  except on E: Exception do
    raise Exception.Create('Falha ao buscar último registro inserido: ' + sLineBreak + E.Message);
  end;
end;

procedure TdmLogDownload.DataModuleDestroy(Sender: TObject);
begin
  qryAuxiliar.Close;
  Conexao.Connected := False;
  inherited;
end;

function TdmLogDownload.Inserir(AUrl: string; ADataInicio: TDateTime): Integer;
begin
  qryAuxiliar.Close;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Add('INSERT INTO LOGDOWNLOAD(URL, DATAINICIO)');
  qryAuxiliar.SQL.Add(' VALUES(:URL, :DATAINICIO) ');
  qryAuxiliar.Params.ParamByName('URL').AsString := AUrl;
  qryAuxiliar.Params.ParamByName('DATAINICIO').AsDateTime := ADataInicio;

  try
    qryAuxiliar.ExecSQL;
    Result := BuscarUltimoCodigoInserid;
  except on E: Exception do
    raise Exception.Create('Falha ao inserir: ' + sLineBreak + E.Message);
  end;
end;

end.
