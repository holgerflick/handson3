object ImageCache: TImageCache
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object Scripts: TFDScript
    SQLScripts = <
      item
        Name = 'createTables'
        SQL.Strings = (
          'CREATE TABLE IF NOT EXISTS images ('
          '    id   INTEGER       PRIMARY KEY AUTOINCREMENT,'
          '    created DATETIME,'
          '    url  VARCHAR (255) NOT NULL,'
          '    data BLOB'
          ');'
          ''
          ''
          '-- Index: KEY_URL'
          'CREATE UNIQUE INDEX IF NOT EXISTS KEY_URL ON images ('
          '    url'
          ');'
          '')
      end>
    Params = <>
    Macros = <>
    Left = 32
    Top = 88
  end
  object SQLiteLink: TFDPhysSQLiteDriverLink
    Left = 128
    Top = 88
  end
  object Manager: TFDManager
    ConnectionDefFileAutoLoad = False
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    UpdateOptions.AssignedValues = [uvLockWait]
    UpdateOptions.LockWait = True
    ActiveStoredUsage = []
    Left = 128
    Top = 32
  end
end
