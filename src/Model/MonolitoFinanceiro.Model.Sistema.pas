unit MonolitoFinanceiro.Model.Sistema;

interface

uses
  System.SysUtils, System.Classes, Vcl.forms;

type
  TdmSistema = class(TDataModule)
  private
    { Private declarations }
    const ARQUIVOCONFIG = 'MonolitoFinaceiro.cfg';
    function GetConfig(Secao, Parametro, valorPadrao : string) : string;
    procedure SetCofing(Secao, Parametro, Valor : string);
  public
    { Public declarations }
    function DataUltimoAcesso : string; overload;
    procedure DataUltimoAcesso(aValue : TDateTime); overload;
    function UsuarioUltimoAcesso : string; overload;
    procedure UsuarioUltimoAcesso(aValue : string); overload;
  end;

var
  dmSistema: TdmSistema;

implementation

uses
  System.IniFiles;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TdmSistema.DataUltimoAcesso: string;
begin
  Result := GetConfig('ACESSO', 'Data', '');
end;

procedure TdmSistema.DataUltimoAcesso(aValue: TDateTime);
begin
  SetCofing('ACESSO', 'Data', DateTimeToStr(aValue));
end;

function TdmSistema.GetConfig(Secao, Parametro, valorPadrao: string): string;
var
  LAquivoConfig : TIniFIle;
begin
    LAquivoConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + ARQUIVOCONFIG);
    try
      Result := LAquivoConfig.ReadString(Secao, Parametro, ValorPadrao);
    finally
      LAquivoConfig.Free;
    end;
end;

procedure TdmSistema.SetCofing(Secao, Parametro, Valor: string);
var
  LAquivoConfig : TIniFIle;
begin
    LAquivoConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + ARQUIVOCONFIG);
    try
      LAquivoConfig.WriteString(Secao, Parametro, Valor);
    finally
      LAquivoConfig.Free;
    end;
end;

function TdmSistema.UsuarioUltimoAcesso: string;
begin
  Result := GetConfig('ACESSO', 'Usuario', '');
end;

procedure TdmSistema.UsuarioUltimoAcesso(aValue: string);
begin
  SetCofing('ACESSO', 'Usuario', aValue);
end;

end.
