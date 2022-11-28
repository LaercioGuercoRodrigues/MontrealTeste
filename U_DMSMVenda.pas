unit U_DMSMVenda;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Phys.ODBCBase, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Datasnap.Provider, Datasnap.DBClient;

type
  TDMSMVenda = class(TDSServerModule)
    FDConnection: TFDConnection;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQConsVenda: TFDQuery;
    DSPConsVenda: TDataSetProvider;
    FDQCadVenda: TFDQuery;
    DSCadVenda: TDataSource;
    FDQItemVenda: TFDQuery;
    DSPCadVenda: TDataSetProvider;
    FDQCadVendaid_venda: TLargeintField;
    FDQCadVendaid_cliente: TLargeintField;
    FDQCadVendadata: TSQLTimeStampField;
    FDQCadVendastatus: TBooleanField;
    FDQCadVendanomecliente: TStringField;
    FDQItemVendaid_itemvenda: TLargeintField;
    FDQItemVendaid_venda: TLargeintField;
    FDQItemVendaid_produto: TLargeintField;
    FDQItemVendapreco: TCurrencyField;
    FDQItemVendaquantidade: TCurrencyField;
    FDQItemVendadescricaoproduto: TStringField;
    FDQAtivarVenda: TFDQuery;
    DSPAtivarVenda: TDataSetProvider;
    FDQVendasCliente: TFDQuery;
    DSPVendasCliente: TDataSetProvider;
    DSVendasCliente: TDataSource;
    FDQVendaItemCliente: TFDQuery;
    procedure DSPCadVendaBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation



{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMSMVenda.DSPCadVendaBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
begin
   if (UpdateKind = ukInsert) or (UpdateKind = ukModify) then
      if SourceDS.Name = 'FDQItemVenda' then
         begin
            if DeltaDS.FieldByName('quantidade').Value < 1 then
               begin
                  raise Exception.Create('INI O valor do campo "Quantidade "deve ser maior que Zero.  FIM');
               end;
            if DeltaDS.FieldByName('preco').Value < 1 then
               begin
                  raise Exception.Create('INI O valor do campo "Preço" deve ser maior que Zero.  FIM');
               end;
         end;
end;

end.

