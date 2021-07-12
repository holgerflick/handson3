object ServiceController: TServiceController
  OldCreateOrder = False
  OnCreate = WebDataModuleCreate
  OnDestroy = WebDataModuleDestroy
  Height = 386
  Width = 361
  object Client: TXDataWebClient
    Connection = Connection
    Left = 23
    Top = 94
  end
  object Connection: TXDataWebConnection
    URL = 'http://localhost:8080'
    OnConnect = ConnectionConnect
    OnError = ConnectionError
    Left = 23
    Top = 22
  end
end
