unit U_DMSMCadastro;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Datasnap.DBClient, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FireDAC.Phys.ODBCBase;

type
  TDMSMCadastro = class(TDSServerModule)
    FDConnection: TFDConnection;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQGerarPK: TFDQuery;
    DSPGerarPK: TDataSetProvider;
    CDSGerarPK: TClientDataSet;
    CDSGerarPKid_gerarpk: TLargeintField;
    CDSGerarPKnomecampo: TStringField;
    CDSGerarPKultimovalor: TLargeintField;
    FDQConsCliente: TFDQuery;
    DSPConsCliente: TDataSetProvider;
    FDQCadCliente: TFDQuery;
    DSPCadCliente: TDataSetProvider;
    FDQConsFornecedor: TFDQuery;
    DSPConsFornecedor: TDataSetProvider;
    FDQCadFornecedor: TFDQuery;
    DSPCadFornecedor: TDataSetProvider;
    FDQConsProduto: TFDQuery;
    DSPConsProduto: TDataSetProvider;
    FDQCadProduto: TFDQuery;
    DSPCadProduto: TDataSetProvider;
    FDQCadProdutoid_produto: TLargeintField;
    FDQCadProdutodescricao: TStringField;
    FDQCadProdutoprecounitario: TCurrencyField;
    FDQCadProdutoid_fornecedor: TLargeintField;
    FDQCadProdutostatus: TBooleanField;
    FDQCadProdutorazaosocialfornecedor: TStringField;
    FDQObterCamposUNIQUEKey: TFDQuery;
    FDQObterCamposUNIQUEKeyCOLUMN_NAME: TWideStringField;
    FDQListaClientesAtivos: TFDQuery;
    DSPListaClientesAtivos: TDataSetProvider;
    procedure DSPCadProdutoBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    function ObterValoPK(nomecampo : string) : int64;
    function ObterCamposUniqueKey(MsgErro : string) : TStringList;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tfdco }

procedure TDMSMCadastro.DSPCadProdutoBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
begin
   if (UpdateKind = ukInsert) or (UpdateKind = ukModify) then
      if DeltaDS.FieldByName('precounitario').Value = 0 then
         begin
            raise Exception.Create('INI O valo para Preço Unitário deve ser maior que Zero.  FIM');
         end;
end;

function TDMSMCadastro.ObterCamposUniqueKey(MsgErro : string): TStringList;
var
  TABLE_SCHEMA, CONSTRAINT_NAME, TABLE_NAME : string;
  Pos1, Pos2 : integer;
  ListaCampo : TStringList;
begin
   Pos1:=Pos(UpperCase('UNIQUE KEY'), UpperCase(MsgErro));
   Pos2:=Pos(UpperCase('Não é possível inserir'), UpperCase(MsgErro));
   CONSTRAINT_NAME:=Copy(MsgErro, Pos1 + 12, Pos2 - Pos1 - 15);
   Pos1:=Pos(UpperCase('duplicada no objeto '), UpperCase(MsgErro));
   Pos2:=Pos(UpperCase('.'), UpperCase(MsgErro), Pos1);
   TABLE_SCHEMA:=Copy(MsgErro, Pos1 + 21, Pos2 - Pos1 - 21);
   Pos1:=Pos(UpperCase(TABLE_SCHEMA), UpperCase(MsgErro));
   Pos2:=Pos(UpperCase('O valor de '), UpperCase(MsgErro), Pos1);
   TABLE_NAME:=Copy(MsgErro, Pos1 + 4, Pos2 - Pos1 - 7);

   FDQObterCamposUNIQUEKey.Close;
   FDQObterCamposUNIQUEKey.ParamByName('CONSTRAINT_NAME').AsString:=CONSTRAINT_NAME;
   FDQObterCamposUNIQUEKey.ParamByName('TABLE_SCHEMA').AsString:=TABLE_SCHEMA;
   FDQObterCamposUNIQUEKey.ParamByName('TABLE_NAME').AsString:=TABLE_NAME;
   FDQObterCamposUNIQUEKey.Open;
   ListaCampo := TStringList.Create;
   while not FDQObterCamposUNIQUEKey.Eof do
         begin
            ListaCampo.Add(FDQObterCamposUNIQUEKeyCOLUMN_NAME.AsString);
            FDQObterCamposUNIQUEKey.Next;
         end;
   Result:=ListaCampo;

{'[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]
    Violação da restrição UNIQUE KEY ''IdX_Fornecedor_Cnpj''.
  Não é possível inserir a chave duplicada no objeto ''dbo.Fornecedor''.
       O valor de chave duplicada é (909090).'}

{'[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]
Não é possível inserir uma linha de chave duplicada no objeto ''dbo.ItemVenda'' com índice exclusivo ''IX_ItemVenda''.
O valor de chave duplicada é (64, 51).'}
end;

function TDMSMCadastro.ObterValoPK(nomecampo: string): int64;
begin
   CDSGerarPK.Close;
   CDSGerarPK.Params[0].AsString:=nomecampo;
   CDSGerarPK.Open;
   CDSGerarPK.Edit;
   CDSGerarPKultimovalor.AsLargeInt:=CDSGerarPKultimovalor.AsLargeInt + 1;
   CDSGerarPK.Post;
   if CDSGerarPK.ApplyUpdates(0) > 0 then
      begin
         ObterValoPK(nomecampo);
      end
   else
      begin
         Result:=CDSGerarPKultimovalor.AsLargeInt;
      end;
end;

end.

