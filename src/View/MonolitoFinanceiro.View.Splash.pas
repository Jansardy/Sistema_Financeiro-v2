unit MonolitoFinanceiro.View.Splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmSplash = class(TForm)
    pnlPrincipal: TPanel;
    imgLogo: TImage;
    lblNameLogo: TLabel;
    PbarSplash: TProgressBar;
    lblStatus: TLabel;
    Timer1: TTimer;
    Panel1: TPanel;
    imgDll: TImage;
    imgBancoDados: TImage;
    imgConfig: TImage;
    imgIni: TImage;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure AtulizarStatus(Mensagem : String; Imagem : TImage);
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}


procedure TfrmSplash.AtulizarStatus(Mensagem: String; Imagem : TImage);
begin
  lblStatus.Caption := Mensagem;
  Imagem.Visible := True;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  if PbarSplash.Position <= 100	then
  begin
    PbarSplash.StepIt;
    case PbarSplash.Position of
      10 : AtulizarStatus('Carregando Dependências...', imgDll);
      25 : AtulizarStatus('Conectando ao banco de dados...', imgBancoDados);
      45 : AtulizarStatus('Carregando as configurações...', imgConfig);
      75 : AtulizarStatus('Iniciando o Sistema...', imgIni);
    end;
  end;
  if PbarSplash.Position = 100	then
    Close;
end;

end.
