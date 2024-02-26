unit MonolitoFinanceiro.View.CaixaSaldo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Vcl.WinXPanels, Vcl.ComCtrls;

type
  TfrmCaixaSaldo = class(TForm)
    pnlPrincipal: TPanel;
    pnlPesquisar: TPanel;
    pnlContent: TPanel;
    btnPesquisar: TButton;
    listImaPnl: TImageList;
    dateInicial: TDateTimePicker;
    dateFinal: TDateTimePicker;
    lblDataInicio: TLabel;
    lblDataFinal: TLabel;
    StackPanel1: TStackPanel;
    pnlFinal: TPanel;
    lblSaldoFinal: TLabel;
    lblSaldoF: TLabel;
    pnlParcial: TPanel;
    lblSaldoParcial: TLabel;
    lblSaldoP: TLabel;
    pnlSaida: TPanel;
    lblTotalSaidas: TLabel;
    lblSaldoS: TLabel;
    pnlEntrada: TPanel;
    lblTotalEntradas: TLabel;
    lblSaldoE: TLabel;
    pnlIncialC: TPanel;
    lblSaldoInicial: TLabel;
    lblSaldoIC: TLabel;
    pnlLine: TPanel;
    pnlLine2: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
  public
    { Public declarations }
  end;

var
  frmCaixaSaldo: TfrmCaixaSaldo;

implementation

uses
  MonolitoFinanceiro.Model.Entidades.Caixa.Resumo,
  MonolitoFinanceiro.Model.Caixa, System.SysUtils,
  System.DateUtils, MonolitoFinanceiro.Util.Utilitarios;

{$R *.dfm}

{ TfrmCaixaSaldo }

procedure TfrmCaixaSaldo.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCaixaSaldo.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCaixaSaldo.Pesquisar;
var
  ResumoCaixa : TModelResumoCaixa;
begin
  lblSaldoInicial.Caption := '';
  lblTotalEntradas.Caption := '';
  lblTotalSaidas.Caption := '';
  lblSaldoParcial.Caption := '';
  lblSaldoFinal.Caption := '';

  ResumoCaixa := dmCaixa.ResumoCaixa(dateInicial.Date, dateFinal.Date);
  try
    lblSaldoInicial.Caption := FormatCurr('0.00', ResumoCaixa.SaldoInicial);
    lblTotalEntradas.Caption := FormatCurr('0.00', ResumoCaixa.TotalEntradas);
    lblTotalSaidas.Caption := FormatCurr('0.00', ResumoCaixa.TotalSaidas);
    lblSaldoParcial.Caption := FormatCurr('0.00', ResumoCaixa.SaldoParcial);
    lblSaldoFinal.Caption := FormatCurr('0.00', ResumoCaixa.SaldoFinal);
  finally
    ResumoCaixa.Free;
  end;
end;

end.
