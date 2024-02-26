inherited frmUsuarios: TfrmUsuarios
  Caption = 'Cadastro Usu'#225'rios'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 21
  inherited PnlPrincipal: TCardPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited CardPesquisa: TCard
      StyleElements = [seFont, seClient, seBorder]
      inherited PnlPesquisa: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited lblPesquisar: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited edtPesquisar: TEdit
          StyleElements = [seFont, seClient, seBorder]
        end
      end
      inherited PnlPesquisaBotoes: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited PnlGrid: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited DBGrid1: TDBGrid
          DataSource = DataSource1
          PopupMenu = PopupMenu1
          Columns = <
            item
              Expanded = False
              FieldName = 'nome'
              Title.Caption = 'Nome'
              Width = 245
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'login'
              Title.Caption = 'Login'
              Width = 200
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'status'
              Title.Caption = 'Status'
              Width = 118
              Visible = True
            end>
        end
      end
    end
    inherited CardCadastro: TCard
      StyleElements = [seFont, seClient, seBorder]
      object lblLogin: TLabel [0]
        Left = 40
        Top = 107
        Width = 39
        Height = 21
        Caption = 'Login'
      end
      object lblNome: TLabel [1]
        Left = 40
        Top = 37
        Width = 43
        Height = 21
        Caption = 'Nome'
      end
      object lblStatus: TLabel [2]
        Left = 41
        Top = 181
        Width = 42
        Height = 21
        Caption = 'Status'
      end
      inherited Panel1: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited btnSalvar: TButton
          Caption = 'Salvar'
        end
      end
      object edtNome: TEdit
        Left = 40
        Top = 64
        Width = 225
        Height = 29
        TabOrder = 1
      end
      object edtLogin: TEdit
        Left = 40
        Top = 134
        Width = 225
        Height = 29
        TabOrder = 2
      end
      object ToggleStatus: TToggleSwitch
        Left = 40
        Top = 208
        Width = 130
        Height = 23
        StateCaptions.CaptionOn = 'Ativo'
        StateCaptions.CaptionOff = 'Bloqueado'
        TabOrder = 3
      end
    end
  end
  object DataSource1: TDataSource [2]
    AutoEdit = False
    DataSet = dmUsuarios.cdsUsuarios
    Left = 641
    Top = 314
  end
  object PopupMenu1: TPopupMenu [3]
    Left = 609
    Top = 234
    object mnuLimparSenha: TMenuItem
      Caption = 'Limpar Senha'
      OnClick = frmCadastromnuLimparSenhaClick
    end
  end
  inherited DataSource2: TDataSource
    DataSet = dmUsuarios.cdsUsuarios
    Left = 529
    Top = 290
  end
end
