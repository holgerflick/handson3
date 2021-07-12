object DataServerContainer: TDataServerContainer
  OldCreateOrder = False
  Height = 150
  Width = 257
  object DispatcherData: TSparkleHttpSysDispatcher
    Left = 48
    Top = 16
  end
  object ServerData: TXDataServer
    BaseUrl = 'http://+:2001/tms/xdata'
    Dispatcher = DispatcherData
    ModelName = 'modData'
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerUIOptions.Enabled = True
    Left = 152
    Top = 16
    object ServerDataCORS: TSparkleCorsMiddleware
      Origin = '*'
    end
  end
end
