object DBController: TDBController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 160
  Width = 244
  object Connection: TFDConnection
    LoginPrompt = False
    Left = 40
    Top = 48
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 144
    Top = 48
  end
end
