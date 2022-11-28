object DMSMCadastro: TDMSMCadastro
  Height = 581
  Width = 779
  PixelsPerInch = 96
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=DBMGTeste'
      'User_Name=sa'
      'Password=Laercio123'
      'Server=LAPTOP-FEJNEQ89\SQLEXPRESS'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 64
    Top = 16
  end
  object FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 252
    Top = 16
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 440
    Top = 16
  end
  object FDQGerarPK: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select * From GerarPK Where nomecampo = :nomecampo')
    Left = 112
    Top = 96
    ParamData = <
      item
        Name = 'NOMECAMPO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSPGerarPK: TDataSetProvider
    DataSet = FDQGerarPK
    ResolveToDataSet = True
    Left = 224
    Top = 96
  end
  object CDSGerarPK: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'NOMECAMPO'
        ParamType = ptInput
      end>
    ProviderName = 'DSPGerarPK'
    Left = 328
    Top = 96
    object CDSGerarPKid_gerarpk: TLargeintField
      FieldName = 'id_gerarpk'
      Required = True
    end
    object CDSGerarPKnomecampo: TStringField
      FieldName = 'nomecampo'
      Required = True
      Size = 50
    end
    object CDSGerarPKultimovalor: TLargeintField
      FieldName = 'ultimovalor'
      Required = True
    end
  end
  object FDQConsCliente: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select * From Cliente Where nome Like :nome')
    Left = 112
    Top = 256
    ParamData = <
      item
        Name = 'NOME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSPConsCliente: TDataSetProvider
    DataSet = FDQConsCliente
    Left = 290
    Top = 256
  end
  object FDQCadCliente: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select * From Cliente Where id_cliente = :id_cliente')
    Left = 468
    Top = 256
    ParamData = <
      item
        Name = 'ID_CLIENTE'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSPCadCliente: TDataSetProvider
    DataSet = FDQCadCliente
    ResolveToDataSet = True
    Left = 646
    Top = 256
  end
  object FDQConsFornecedor: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select * '
      ''
      'From Fornecedor '
      ''
      'Where '
      
        '     (nomefantasia like :nomefantasia  or razaosocial Like :raza' +
        'osocial) '
      '      AND  status = :status'
      ''
      'order by razaosocial')
    Left = 112
    Top = 320
    ParamData = <
      item
        Name = 'NOMEFANTASIA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'RAZAOSOCIAL'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'STATUS'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSPConsFornecedor: TDataSetProvider
    DataSet = FDQConsFornecedor
    Left = 290
    Top = 320
  end
  object FDQCadFornecedor: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select * From Fornecedor Where id_fornecedor = :id_fornecedor ')
    Left = 468
    Top = 320
    ParamData = <
      item
        Name = 'ID_FORNECEDOR'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSPCadFornecedor: TDataSetProvider
    DataSet = FDQCadFornecedor
    ResolveToDataSet = True
    Left = 646
    Top = 320
  end
  object FDQConsProduto: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'Select Produto.*, Fornecedor.razaosocial as razaosocialfornecedo' +
        'r '
      ''
      'From Produto, Fornecedor '
      ''
      'Where '
      '     Produto.id_fornecedor = Fornecedor.id_fornecedor'
      '     AND Produto.descricao Like :descricao'
      ''
      'Order By Produto.descricao')
    Left = 112
    Top = 384
    ParamData = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSPConsProduto: TDataSetProvider
    DataSet = FDQConsProduto
    Left = 290
    Top = 384
  end
  object FDQCadProduto: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'Select Produto.*, Fornecedor.razaosocial as razaosocialfornecedo' +
        'r '
      ''
      'From Produto, Fornecedor '
      ''
      'Where '
      '     Produto.id_fornecedor = Fornecedor.id_fornecedor'
      '     AND Produto.id_produto = :id_produto')
    Left = 468
    Top = 384
    ParamData = <
      item
        Name = 'ID_PRODUTO'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
    object FDQCadProdutoid_produto: TLargeintField
      FieldName = 'id_produto'
      Origin = 'id_produto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQCadProdutodescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 100
    end
    object FDQCadProdutoprecounitario: TCurrencyField
      FieldName = 'precounitario'
      Origin = 'precounitario'
      Required = True
    end
    object FDQCadProdutoid_fornecedor: TLargeintField
      FieldName = 'id_fornecedor'
      Origin = 'id_fornecedor'
      Required = True
    end
    object FDQCadProdutostatus: TBooleanField
      FieldName = 'status'
      Origin = 'status'
      Required = True
    end
    object FDQCadProdutorazaosocialfornecedor: TStringField
      FieldName = 'razaosocialfornecedor'
      Origin = 'razaosocialfornecedor'
      ProviderFlags = []
      Size = 100
    end
  end
  object DSPCadProduto: TDataSetProvider
    DataSet = FDQCadProduto
    ResolveToDataSet = True
    BeforeUpdateRecord = DSPCadProdutoBeforeUpdateRecord
    Left = 646
    Top = 384
  end
  object FDQObterCamposUNIQUEKey: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT COLUMN_NAME '
      ''
      'FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE'
      ''
      'Where '
      '      Upper(CONSTRAINT_NAME) =  Upper(:CONSTRAINT_NAME)  AND'
      '      Upper(TABLE_SCHEMA)    =  Upper(:TABLE_SCHEMA)  AND'
      '      Upper(TABLE_NAME)      =  Upper(:TABLE_NAME)')
    Left = 112
    Top = 168
    ParamData = <
      item
        Name = 'CONSTRAINT_NAME'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TABLE_SCHEMA'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TABLE_NAME'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    object FDQObterCamposUNIQUEKeyCOLUMN_NAME: TWideStringField
      FieldName = 'COLUMN_NAME'
      Origin = 'COLUMN_NAME'
      Size = 128
    end
  end
  object FDQListaClientesAtivos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select Cliente.id_cliente, Cliente.nome, Cliente.status'
      ''
      'From Cliente'
      ''
      'Where Cliente.Status = 1'
      ''
      'Order By Cliente.nome')
    Left = 104
    Top = 480
  end
  object DSPListaClientesAtivos: TDataSetProvider
    DataSet = FDQListaClientesAtivos
    Left = 288
    Top = 480
  end
end
