object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 138
  Width = 343
  object Conexao: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projetos\DELPHI\SoftPlan\App\Win32\Debug\Dados\Dados' +
        '.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 120
    Top = 40
  end
  object qryAuxiliar: TFDQuery
    Connection = Conexao
    Left = 208
    Top = 40
  end
end
