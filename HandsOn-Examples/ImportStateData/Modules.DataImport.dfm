object DataImport: TDataImport
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 285
  Width = 331
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 64
    Top = 24
  end
  object Connection: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'JournalMode=Off'
      'Synchronous=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 64
    Top = 112
  end
end
