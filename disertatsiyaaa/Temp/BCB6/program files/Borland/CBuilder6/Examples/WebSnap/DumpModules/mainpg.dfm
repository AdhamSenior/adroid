object MainPage: TMainPage
  OldCreateOrder = False
  PageProducer = PageProducer
  AppServices = WebAppComponents
  Left = 509
  Top = 120
  Height = 302
  Width = 315
  object PageProducer: TPageProducer
    ScriptEngine = 'JScript'
    Left = 48
    Top = 8
  end
  object WebAppComponents: TWebAppComponents
    LocateFileService = LocateFileService1
    PageDispatcher = PageDispatcher
    AdapterDispatcher = AdapterDispatcher
    ApplicationAdapter = ApplicationAdapter
    Left = 48
    Top = 56
  end
  object ApplicationAdapter: TApplicationAdapter
    Left = 48
    Top = 104
    object TAdapterDefaultActions
    end
    object TAdapterDefaultFields
    end
  end
  object PageDispatcher: TPageDispatcher
    Left = 48
    Top = 152
  end
  object AdapterDispatcher: TAdapterDispatcher
    Left = 48
    Top = 200
  end
  object LocateFileService1: TLocateFileService
    OnFindStream = LocateFileService1FindStream
    Left = 152
    Top = 88
  end
end
