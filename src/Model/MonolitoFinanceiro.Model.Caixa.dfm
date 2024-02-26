object dmCaixa: TdmCaixa
  Height = 237
  Width = 409
  object sqlCaixa: TFDQuery
    Connection = dmConexao.SQLConexao
    Left = 80
    Top = 48
  end
  object cdsCaixa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCaixa'
    Left = 264
    Top = 48
    object cdsCaixaID: TStringField
      FieldName = 'ID'
      Size = 36
    end
    object cdsCaixaNUMERO_DOC: TStringField
      FieldName = 'NUMERO_DOC'
    end
    object cdsCaixaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object cdsCaixaVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Size = 18
    end
    object cdsCaixaTIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object cdsCaixaDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
    end
  end
  object dspCaixa: TDataSetProvider
    DataSet = sqlCaixa
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 168
    Top = 48
  end
end
