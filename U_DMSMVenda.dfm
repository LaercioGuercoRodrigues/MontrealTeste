object DMSMVenda: TDMSMVenda
  Height = 438
  Width = 625
  PixelsPerInch = 96
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=DBMGTeste'
      'User_Name=sa'
      'Password=Laercio123'
      'Server=LAPTOP-FEJNEQ89\SQLEXPRESS'
      'DriverID=MSSQL')
    Connected = True
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
  object FDQConsVenda: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select Venda.*, '
      '       Cliente.nome as nomecliente,'
      
        '       (Select count(ItemVenda.id_venda) From ItemVenda Where It' +
        'emVenda.id_venda = Venda.id_venda) as QtdItemVenda, '
      
        '       (Select sum(ItemVenda.quantidade * ItemVenda.preco) From ' +
        'ItemVenda Where ItemVenda.id_venda = Venda.id_venda) as TotalVen' +
        'da'
      ''
      'From Venda '
      '     inner join Cliente'
      '     on Venda.id_cliente = Cliente.id_cliente'
      ''
      
        'Where (Venda.data between :dataini  and :datafin)  and  (Venda.s' +
        'tatus = :status)')
    Left = 64
    Top = 112
    ParamData = <
      item
        Name = 'DATAINI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATAFIN'
        DataType = ftDateTime
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
  object DSPConsVenda: TDataSetProvider
    DataSet = FDQConsVenda
    Left = 64
    Top = 184
  end
  object FDQCadVenda: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select Venda.*, '
      '       Cliente.nome as nomecliente'
      ''
      'From Venda '
      '     inner join Cliente'
      '     on Venda.id_cliente = Cliente.id_cliente'
      ''
      'Where Venda.id_venda = :id_venda')
    Left = 216
    Top = 112
    ParamData = <
      item
        Name = 'ID_VENDA'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
    object FDQCadVendaid_venda: TLargeintField
      FieldName = 'id_venda'
      Origin = 'id_venda'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQCadVendaid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
      Required = True
    end
    object FDQCadVendadata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object FDQCadVendastatus: TBooleanField
      FieldName = 'status'
      Origin = 'status'
      Required = True
    end
    object FDQCadVendanomecliente: TStringField
      FieldName = 'nomecliente'
      Origin = 'nomecliente'
      ProviderFlags = []
      Size = 100
    end
  end
  object DSCadVenda: TDataSource
    DataSet = FDQCadVenda
    Left = 324
    Top = 112
  end
  object FDQItemVenda: TFDQuery
    MasterSource = DSCadVenda
    MasterFields = 'id_venda'
    DetailFields = 'id_venda'
    Connection = FDConnection
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'Select ItemVenda.*,'
      '       Produto.descricao as descricaoproduto'
      '       '
      'From ItemVenda '
      '     inner join Produto'
      '     on ItemVenda.id_produto = Produto.id_produto'
      ''
      'Where ItemVenda.id_venda = :id_venda')
    Left = 432
    Top = 112
    ParamData = <
      item
        Name = 'ID_VENDA'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
    object FDQItemVendaid_itemvenda: TLargeintField
      FieldName = 'id_itemvenda'
      Origin = 'id_itemvenda'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQItemVendaid_venda: TLargeintField
      FieldName = 'id_venda'
      Origin = 'id_venda'
      Required = True
    end
    object FDQItemVendaid_produto: TLargeintField
      FieldName = 'id_produto'
      Origin = 'id_produto'
      Required = True
    end
    object FDQItemVendapreco: TCurrencyField
      FieldName = 'preco'
      Origin = 'preco'
      Required = True
    end
    object FDQItemVendaquantidade: TCurrencyField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
    end
    object FDQItemVendadescricaoproduto: TStringField
      FieldName = 'descricaoproduto'
      Origin = 'descricaoproduto'
      ProviderFlags = []
      Size = 100
    end
  end
  object DSPCadVenda: TDataSetProvider
    DataSet = FDQCadVenda
    ResolveToDataSet = True
    BeforeUpdateRecord = DSPCadVendaBeforeUpdateRecord
    Left = 216
    Top = 184
  end
  object FDQAtivarVenda: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Update Venda'
      '       Set Venda.Status = 1'
      'Where  Venda.id_venda = :id_venda')
    Left = 64
    Top = 272
    ParamData = <
      item
        Name = 'ID_VENDA'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSPAtivarVenda: TDataSetProvider
    DataSet = FDQAtivarVenda
    Left = 64
    Top = 344
  end
  object FDQVendasCliente: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select Venda.*, Cliente.Nome'
      ''
      'From Venda, Cliente'
      ''
      'Where'
      '    Venda.id_cliente = Cliente.id_cliente  AND '
      '    Venda.status = 1  AND'
      '    Venda.id_cliente = :id_cliente'
      ''
      'Order By Venda.Data')
    Left = 216
    Top = 272
    ParamData = <
      item
        Name = 'ID_CLIENTE'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSPVendasCliente: TDataSetProvider
    DataSet = FDQVendasCliente
    Left = 216
    Top = 344
  end
  object DSVendasCliente: TDataSource
    DataSet = FDQVendasCliente
    Left = 352
    Top = 272
  end
  object FDQVendaItemCliente: TFDQuery
    MasterSource = DSVendasCliente
    MasterFields = 'id_venda'
    DetailFields = 'id_venda'
    Connection = FDConnection
    SQL.Strings = (
      'Select ItemVenda.*, Produto.descricao'
      ''
      'From ItemVenda, Produto'
      ''
      'Where'
      '    ItemVenda.id_produto = Produto.id_produto'
      '    and ItemVenda.id_venda = :id_venda'
      '    ')
    Left = 488
    Top = 272
    ParamData = <
      item
        Name = 'ID_VENDA'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
end
