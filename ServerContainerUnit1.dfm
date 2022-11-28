object ServerContainer1: TServerContainer1
  Height = 271
  Width = 415
  PixelsPerInch = 96
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 200
    Top = 11
  end
  object DSServerClassCadastro: TDSServerClass
    OnGetClass = DSServerClassCadastroGetClass
    Server = DSServer1
    Left = 200
    Top = 104
  end
  object DSServerClassVenda: TDSServerClass
    OnGetClass = DSServerClassVendaGetClass
    Server = DSServer1
    Left = 200
    Top = 176
  end
end
