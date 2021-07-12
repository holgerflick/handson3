  {$IFDEF DEBUG}
  Application.StandAlone := True;
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSampleModule, SampleModule);
  Application.CreateForm(TAuthModule, AuthModule);
  Application.CreateForm(TApiModule, ApiModule);
  Application.CreateForm(TServerMainForm, ServerMainForm);
  Application.CreateForm(TServerWinService, ServerWinService);
  Application.Run;
