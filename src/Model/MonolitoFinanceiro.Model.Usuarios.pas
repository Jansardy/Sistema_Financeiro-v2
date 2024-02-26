unit MonolitoFinanceiro.Model.Usuarios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider,
  Datasnap.DBClient,
  MonolitoFinanceiro.Model.Conexao,
  MonolitoFinanceiro.Model.Entidades.Usuarios;

type
  TdmUsuarios = class(TDataModule)
    sqlUSuarios: TFDQuery;
    cdsUsuarios: TClientDataSet;
    dspUsuarios: TDataSetProvider;
    cdsUsuariosid: TStringField;
    cdsUsuariosnome: TStringField;
    cdsUsuarioslogin: TStringField;
    cdsUsuariossenha: TStringField;
    cdsUsuariosstatus: TStringField;
    cdsUsuariosdata_cadastro: TDateField;
    cdsUsuariossenha_temporaria: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FEntidadeUsuario : TModelEntidadeUsuario;
    { Private declarations }
  public
    { Public declarations }
    const TEMP_PASSWORD = '123456';
    function TemLoginCadastrado(Login : string; ID : string) : Boolean;
    procedure EfetuarLogin(Login : string; Senha : string);
    function GetUsuarioLogado : TModelEntidadeUsuario;
    procedure LimparSenha(IDUsuario : string);
    procedure RedefinirSenha(Usuario : TModelEntidadeUsuario);
  end;

var
  dmUsuarios: TdmUsuarios;

implementation
 uses
  BCrypt;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmUsuarios }

procedure TdmUsuarios.DataModuleCreate(Sender: TObject);
begin
  FEntidadeUsuario := TModelEntidadeUsuario.Create;
end;

procedure TdmUsuarios.DataModuleDestroy(Sender: TObject);
begin
  FEntidadeUsuario.Free;
end;

procedure TdmUsuarios.EfetuarLogin(Login, Senha: string);
var
  SQLConsulta : TFDQuery;
begin
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.SQLConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT * FROM USUARIOS WHERE LOGIN = :LOGIN');
    SQLConsulta.ParamByName('LOGIN').AsString := Login;
    SQLConsulta.Open;

    if SQLConsulta.IsEmpty then
      raise Exception.Create('Usu�rio E/ou senha inv�lidos');

    if not TBCrypt.CompareHash(Senha, SQLConsulta.FieldByName('SENHA').AsString) then
      raise Exception.Create('Usu�rio E/ou senha inv�lidos');

    if SQLConsulta.FieldByName('STATUS').AsString <> 'A'  then
      raise Exception.Create('Usu�rio bloqueado, favor entrar em contato com o suporte');


    FEntidadeUsuario.ID :=  SQLConsulta.FieldByName('ID').AsString;
    FEntidadeUsuario.Nome := SQLConsulta.FieldByName('NOME').AsString;
    FEntidadeUsuario.Login := SQLConsulta.FieldByName('LOGIN').AsString;
    FEntidadeUsuario.Senha := SQLConsulta.FieldByName('SENHA').AsString;
    FEntidadeUsuario.SenhaTemporaria := SQLConsulta.FieldByName('SENHA_TEMPORARIA').AsString = 'S';
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;
end;

function TdmUsuarios.GetUsuarioLogado: TModelEntidadeUsuario;
begin
  Result := FEntidadeUsuario;
end;

procedure TdmUsuarios.LimparSenha(IDUsuario: string);
var
  SQLQuery : TFDQuery;
begin
  SQLQuery := TFDQuery.Create(nil);
  try
    SQLQuery.Connection := dmConexao.SQLConexao;
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add('UPDATE USUARIOS SET SENHA_TEMPORARIA = :SENHA_TEMPORARIA, SENHA = :SENHA WHERE ID = :ID');
    SQLQuery.ParamByName('SENHA_TEMPORARIA').AsString := 'S';
    SQLQuery.ParamByName('SENHA').AsString := TBCrypt.GenerateHash(TEMP_PASSWORD);
    SQLQuery.ParamByName('ID').AsString := IDUsuario;
    SQLQuery.ExecSQL;
  finally
    SQLQuery.Close;
    SQLQuery.Free;
  end;
end;

procedure TdmUsuarios.RedefinirSenha(Usuario: TModelEntidadeUsuario);
var
  SQLQuery : TFDQuery;
begin
  SQLQuery := TFDQuery.Create(nil);
  try
    SQLQuery.Connection := dmConexao.SQLConexao;
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add('UPDATE USUARIOS SET SENHA_TEMPORARIA = :SENHA_TEMPORARIA, SENHA = :SENHA WHERE ID = :ID');
    SQLQuery.ParamByName('SENHA_TEMPORARIA').AsString := 'N';
    SQLQuery.ParamByName('SENHA').AsString := TBCrypt.GenerateHash(Usuario.Senha);
    SQLQuery.ParamByName('ID').AsString := Usuario.ID;
    SQLQuery.ExecSQL;
  finally
    SQLQuery.Close;
    SQLQuery.Free;
  end;
end;

function TdmUsuarios.TemLoginCadastrado(Login, ID: string): Boolean;
var
   SQLConsulta : TFDQuery;
begin
  Result := false;
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.SQLConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT ID FROM USUARIOS WHERE LOGIN = :LOGIN');
    SQLConsulta.ParamByName('LOGIN').AsString := Login;
    SQLConsulta.Open;
    if not SQLConsulta.IsEmpty then
      Result := SQLConsulta.FieldByName('ID').AsString <> ID;
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;
end;

end.
