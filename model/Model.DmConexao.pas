unit Model.DmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, Vcl.Forms, Vcl.Dialogs, System.StrUtils;

type
  TdmConexao = class(TDataModule)
    Conexao: TFDConnection;
    qryAuxiliar: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConexao.DataModuleCreate(Sender: TObject);
var
  lCaminhoDados: string;
begin
  lCaminhoDados := ExtractFilePath(Application.ExeName) + '\Dados\Dados.db';

  if not FileExists(lCaminhoDados) then
  begin
    ShowMessage('Não foi possível conectar ao banco de dados.' +
      'A pasta do Banco de dados não está na mesma pasta da aplicação.' + sLineBreak +
      'A aplicação será fechada.');
    Application.Terminate;
  end;

  try
    with Conexao do
    begin
      Connected := False;
      Params.Database := lCaminhoDados;
      Params.DriverID := 'SQLite';
      LoginPrompt := False;
      Connected := True;
    end;
  except on E: Exception do
    begin
      ShowMessage('Não foi possível conectar ao banco de dados.' + sLineBreak +
        'A aplicação será fechada.' + sLineBreak +
        'Erro: ' + E.Message);
      Application.Terminate;
    end;
  end;
end;

end.
