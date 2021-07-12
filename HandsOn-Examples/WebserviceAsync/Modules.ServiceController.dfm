object ServiceController: TServiceController
  OldCreateOrder = False
  Height = 150
  Width = 334
  object Client: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://api.pexels.com/v1'
    Params = <>
    Left = 24
    Top = 24
  end
  object ReqCurated: TRESTRequest
    Client = Client
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'Authorization'
      end>
    Resource = 'curated'
    Response = RespCurated
    Left = 96
    Top = 24
  end
  object RespCurated: TRESTResponse
    Left = 168
    Top = 24
  end
  object ReqKeywords: TRESTRequest
    Client = Client
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'Authorization'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'query'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        Name = 'perPage'
        Options = [poAutoCreated]
        Value = '25'
      end>
    Resource = 'search?query={query}&per_page={perPage}'
    Response = RespKeywords
    Left = 96
    Top = 88
  end
  object RespKeywords: TRESTResponse
    ContentType = 'application/json'
    Left = 176
    Top = 88
  end
end
