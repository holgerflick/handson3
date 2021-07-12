object ServiceController: TServiceController
  OldCreateOrder = False
  OnCreate = WebDataModuleCreate
  OnDestroy = WebDataModuleDestroy
  Height = 166
  Width = 124
  object Client: TXDataWebClient
    Connection = Connection
    Left = 23
    Top = 94
  end
  object Connection: TXDataWebConnection
    URL = 'http://192.168.0.2:8080'
    OnConnect = ConnectionConnect
    OnError = ConnectionError
    Left = 23
    Top = 22
  end
end
