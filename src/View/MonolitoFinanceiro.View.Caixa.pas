unit MonolitoFinanceiro.View.Caixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MonolitoFinanceiro.View.Cadastro,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TfrmCaixa = class(TfrmCadastro)
    lblNDoc: TLabel;
    edtNDoc: TEdit;
    edtDescricao: TEdit;
    edtValor: TEdit;
    lblDescricao: TLabel;
    lblValor: TLabel;
    RgTipo: TRadioGroup;
    cbTipo: TComboBox;
    lblTipo: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure Pesquisar; override;
  end;

var
  frmCaixa: TfrmCaixa;

implementation

uses
  MonolitoFinanceiro.Model.Caixa, MonolitoFinanceiro.Util.Utilitarios;

{$R *.dfm}

{ TfrmCadastro1 }

procedure TfrmCaixa.btnAlterarClick(Sender: TObject);
begin
  inherited;
  edtNDoc.Text := dmCaixa.cdsCaixaNUMERO_DOC.AsString;
  edtDescricao.Text := dmCaixa.cdsCaixaDESCRICAO.AsString;
  edtValor.Text := dmCaixa.cdsCaixaVALOR.AsString;
  if dmCaixa.cdsCaixaTIPO.AsString = 'R' then
    RgTipo.ItemIndex := 0
  else
    RgTipo.ItemIndex := 1;
end;

procedure TfrmCaixa.btnSalvarClick(Sender: TObject);
var
  LTipo : string;
begin
  if Trim(edtNDoc.Text) = '' then
  begin
    edtNDoc.SetFocus;
    Application.MessageBox('O campo n�mero do documento n�o pode ser vazio.', 'Aten��o', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if Trim(edtValor.Text) = '' then
  begin
    edtValor.SetFocus;
    Application.MessageBox('O campo valor n�o pode ser vazio.', 'Aten��o', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if RgTipo.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione o tipo do lan�amento.', 'Aten��o', MB_OK + MB_ICONWARNING);
    abort;
  end;

  LTipo := 'R';
  if RgTipo.ItemIndex = 1 then
   LTipo := 'D';

  if DataSource2.State in [dsInsert] then
  begin
    dmCaixa.cdsCaixaID.AsString := TUtilitarios.GetID;
    dmCaixa.cdsCaixaDATA_CADASTRO.AsDateTime := Now;
  end;

  dmCaixa.cdsCaixaNUMERO_DOC.AsString := Trim(edtNDoc.Text);
  dmCaixa.cdsCaixaDESCRICAO.AsString := Trim(edtDescricao.Text);
  dmCaixa.cdsCaixaValor.AsCurrency := StrToFloat(edtValor.Text);
  dmCaixa.cdsCaixaTIPO.AsString := LTipo;

  inherited;
end;

procedure TfrmCaixa.Pesquisar;
var
  FiltroPesquisa : string;
  FiltroTipo : string;
begin
  case cbTipo.ItemIndex of
    1 : FiltroTipo := ' AND TIPO = ''R''';
    2 : FiltroTipo := ' AND TIPO = ''D''';
  end;
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisar.Text, DBGrid1);
  dmCaixa.cdsCaixa.Close;
  dmCaixa.cdsCaixa.CommandText := 'Select * from Caixa where 1 = 1' + FiltroPesquisa + FiltroTipo;
  dmCaixa.cdsCaixa.Open;
  inherited;
end;

end.
