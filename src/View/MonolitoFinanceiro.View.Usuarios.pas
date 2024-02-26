unit MonolitoFinanceiro.View.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MonolitoFinanceiro.View.Cadastro,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.WinXCtrls, Vcl.Menus;

type
  TfrmUsuarios = class(TfrmCadastro)
    DataSource1: TDataSource;
    edtNome: TEdit;
    edtLogin: TEdit;
    lblLogin: TLabel;
    lblNome: TLabel;
    ToggleStatus: TToggleSwitch;
    lblStatus: TLabel;
    PopupMenu1: TPopupMenu;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure frmCadastromnuLimparSenhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    protected
      procedure Pesquisar; override;
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

uses
  MonolitoFinanceiro.Model.Usuarios,
  MonolitoFinanceiro.Util.Utilitarios,
  BCrypt,
  System.SysUtils;

{$R *.dfm}


procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  edtNome.Text := dmUsuarios.cdsUsuariosnome.AsString;
  edtLogin.Text := dmUsuarios.cdsUsuarioslogin.AsString;

  ToggleStatus.State := tssOn;
  if dmUsuarios.cdsUsuariosstatus.AsString = 'B' then
  ToggleStatus.State := tssOff;
end;

procedure TfrmUsuarios.btnSalvarClick(Sender: TObject);
var
  LStatus: string;
begin
  if Trim(edtNome.Text) = '' then
  begin
    edtNome.SetFocus;
    Application.MessageBox('O campo nome n�o pode ser vazio.', 'Aten��o', MB_OK + MB_ICONWARNING);
    abort;
  end;
   if Trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('O campo login n�o pode ser vazio.', 'Aten��o', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if dmUsuarios.TemLoginCadastrado(Trim(edtLogin.Text), dmUsuarios.cdsUsuarios.FieldByName('ID').AsString)	 then
  begin
    edtLogin.SetFocus;
    Application.MessageBox(PWideChar(Format('O login %s j� se encontra cadastrado.', [edtLogin.Text])),'Aten��o', MB_OK + MB_ICONWARNING);
    abort;
  end;

  LStatus := 'A';

  if ToggleStatus.State = tssOff then
    LStatus := 'B';

    if dmUsuarios.cdsUsuarios.State in [dsInsert] then
    begin
      dmUsuarios.cdsUsuariosid.AsString :=  TUtilitarios.GetID;
      dmUsuarios.cdsUsuariosdata_cadastro.AsDateTime := now;
      dmUsuarios.cdsUsuariossenha.AsString := TBCrypt.GenerateHash(dmUsuarios.TEMP_PASSWORD);
      dmUsuarios.cdsUsuariossenha_temporaria.AsString := 'S';
    end;

  dmUsuarios.cdsUsuariosnome.AsString := Trim(edtNome.Text);
  dmUsuarios.cdsUsuarioslogin.AsString := Trim(edtLogin.Text);
  dmUsuarios.cdsUsuariosstatus.AsString := LStatus;
  inherited;
end;

procedure TfrmUsuarios.frmCadastromnuLimparSenhaClick(Sender: TObject);
begin
  inherited;
  if not DataSource1.DataSet.IsEmpty then
  begin
    dmUsuarios.LimparSenha(DataSource1.DataSet.FieldByName('ID').AsString);
    Application.MessageBox(PWideChar(format('Foi definida a senha padr�o para o usu�rio "%s"', [DataSource1.DataSet.FieldByName('NOME').AsString])), 'Aten��o', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TfrmUsuarios.Pesquisar;
var
  FiltroPesquisa : string;
begin
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisar.Text, DBGrid1);

  dmUsuarios.cdsUsuarios.Close;
  dmUsuarios.cdsUsuarios.CommandText := 'Select * from Usuarios where 1 = 1' + FiltroPesquisa;
  dmUsuarios.cdsUsuarios.Open;
  inherited;
end;

end.
