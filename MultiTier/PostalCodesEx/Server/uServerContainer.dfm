object ServerContainer: TServerContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 100
  Width = 391
  object SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher
    Active = True
    Left = 64
    Top = 16
  end
  object XDataServer: TXDataServer
    BaseUrl = 'http://+:80'
    Dispatcher = SparkleHttpSysDispatcher
    DefaultEntitySetPermissions = [List]
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerUIOptions.Enabled = True
    Left = 168
    Top = 16
    object XDataServerCORS: TSparkleCorsMiddleware
      Origin = '*'
    end
  end
end
