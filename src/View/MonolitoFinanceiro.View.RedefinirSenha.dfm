object frmRedefinirSenha: TfrmRedefinirSenha
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Redefinir Senha'
  ClientHeight = 298
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 21
  object pnlBase: TPanel
    Left = 0
    Top = 0
    Width = 395
    Height = 298
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 209
    ExplicitWidth = 408
    ExplicitHeight = 337
    object lblNovaSenha: TLabel
      Left = 60
      Top = 153
      Width = 150
      Height = 21
      Caption = 'Confirme a sua senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblSenha: TLabel
      Left = 60
      Top = 76
      Width = 43
      Height = 21
      Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 395
      Height = 73
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 10
      TabOrder = 1
      object lblUsuario: TLabel
        Left = 0
        Top = 10
        Width = 395
        Height = 29
        Align = alTop
        Alignment = taCenter
        Caption = 'Usu'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -24
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 14
        ExplicitWidth = 425
      end
      object Label1: TLabel
        Left = 0
        Top = 39
        Width = 395
        Height = 19
        Align = alTop
        Alignment = taCenter
        Caption = 'Informe a sua nova senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 43
        ExplicitWidth = 425
      end
    end
    object pnlBaixo: TPanel
      Left = 0
      Top = 257
      Width = 395
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 296
      ExplicitWidth = 408
    end
    object edtSenha: TEdit
      Left = 60
      Top = 103
      Width = 269
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 0
    end
    object edtConfirmarSenha: TEdit
      Left = 60
      Top = 180
      Width = 269
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
    end
    object pnlBotoes: TPanel
      Left = 60
      Top = 241
      Width = 269
      Height = 34
      BevelOuter = bvNone
      TabOrder = 4
      object btnConfirmar: TButton
        Left = 176
        Top = 0
        Width = 93
        Height = 34
        Align = alRight
        Caption = 'Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
        ExplicitLeft = 175
        ExplicitTop = 1
        ExplicitHeight = 54
      end
      object btnCancelar: TButton
        Left = 0
        Top = 0
        Width = 93
        Height = 34
        Align = alLeft
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = btnCancelarClick
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitHeight = 54
      end
    end
  end
end
