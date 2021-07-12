object ServerContainer: TServerContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 194
  Width = 351
  object DispatcherConfig: TSparkleHttpSysDispatcher
    Left = 72
    Top = 16
  end
  object ServerConfig: TXDataServer
    BaseUrl = 'http://+:8080/'
    Dispatcher = DispatcherConfig
    ModelName = 'modConfig'
    EntitySetPermissions = <>
    Left = 160
    Top = 16
    object ServerConfigCORS: TSparkleCorsMiddleware
      Origin = '*'
    end
  end
  object WebServer: TSparkleStaticServer
    BaseUrl = 'http://+:80/'
    Dispatcher = DispatcherWeb
    Left = 168
    Top = 120
  end
  object DispatcherWeb: TSparkleHttpSysDispatcher
    Left = 64
    Top = 120
  end
end
