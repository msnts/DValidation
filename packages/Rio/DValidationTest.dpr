program DValidationTest;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}


uses
  SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  Customer in '..\..\tests\Customer.pas',
  DValidation.Model.ObjectGraph in '..\..\tests\DValidation.Model.ObjectGraph.pas',
  DValidation.ObjectGraphTest in '..\..\tests\DValidation.ObjectGraphTest.pas',
  Unit1 in '..\..\tests\Unit1.pas',
  ValidationTest in '..\..\tests\ValidationTest.pas',
  DValidation.Constraints.AssertFalseTest in '..\..\tests\constraints\DValidation.Constraints.AssertFalseTest.pas',
  DValidation.Constraints.AssertTrueTest in '..\..\tests\constraints\DValidation.Constraints.AssertTrueTest.pas',
  DValidation.Constraints.DecimalMaxTest in '..\..\tests\constraints\DValidation.Constraints.DecimalMaxTest.pas',
  DValidation.Constraints.DecimalMinTest in '..\..\tests\constraints\DValidation.Constraints.DecimalMinTest.pas',
  DValidation.Constraints.MaxTest in '..\..\tests\constraints\DValidation.Constraints.MaxTest.pas',
  DValidation.Constraints.MinTest in '..\..\tests\constraints\DValidation.Constraints.MinTest.pas',
  DValidation.Constraints.NegativeOrZeroTest in '..\..\tests\constraints\DValidation.Constraints.NegativeOrZeroTest.pas',
  DValidation.Constraints.NegativeTest in '..\..\tests\constraints\DValidation.Constraints.NegativeTest.pas',
  DValidation.Constraints.NotBlankTest in '..\..\tests\constraints\DValidation.Constraints.NotBlankTest.pas',
  DValidation.Constraints.NotEmptyTest in '..\..\tests\constraints\DValidation.Constraints.NotEmptyTest.pas',
  DValidation.Constraints.NotNullTest in '..\..\tests\constraints\DValidation.Constraints.NotNullTest.pas',
  DValidation.Constraints.PositiveOrZeroTest in '..\..\tests\constraints\DValidation.Constraints.PositiveOrZeroTest.pas',
  DValidation.Constraints.PositiveTest in '..\..\tests\constraints\DValidation.Constraints.PositiveTest.pas',
  DValidation.Engine.MessageInterpolatorTest in '..\..\tests\engine\DValidation.Engine.MessageInterpolatorTest.pas',
  DValidation.Validators.AssertFalseValidatorTest in '..\..\tests\validators\DValidation.Validators.AssertFalseValidatorTest.pas',
  DValidation.Validators.AssertTrueValidatorTest in '..\..\tests\validators\DValidation.Validators.AssertTrueValidatorTest.pas',
  DValidation.Validators.DecimalMaxValidatorTest in '..\..\tests\validators\DValidation.Validators.DecimalMaxValidatorTest.pas',
  DValidation.Validators.EANValidatorTest in '..\..\tests\validators\DValidation.Validators.EANValidatorTest.pas',
  DValidation.Validators.EmailValidatorTest in '..\..\tests\validators\DValidation.Validators.EmailValidatorTest.pas',
  DValidation.Validators.MaxValidatorTest in '..\..\tests\validators\DValidation.Validators.MaxValidatorTest.pas',
  DValidation.Validators.MinValidatorTest in '..\..\tests\validators\DValidation.Validators.MinValidatorTest.pas',
  DValidation.Validators.NotEmptyValidatorTest in '..\..\tests\validators\DValidation.Validators.NotEmptyValidatorTest.pas',
  DValidation.Validators.PastValidatorTest in '..\..\tests\validators\DValidation.Validators.PastValidatorTest.pas',
  DValidation.Constraints.Time.FutureOrPresentTest in '..\..\tests\constraints\time\DValidation.Constraints.Time.FutureOrPresentTest.pas',
  DValidation.Constraints.Time.FutureTest in '..\..\tests\constraints\time\DValidation.Constraints.Time.FutureTest.pas',
  DValidation.Constraints.Time.PastOrPresentTest in '..\..\tests\constraints\time\DValidation.Constraints.Time.PastOrPresentTest.pas',
  DValidation.Constraints.Time.PastTest in '..\..\tests\constraints\time\DValidation.Constraints.Time.PastTest.pas',
  DValidation.Constraints.CreditCardNumberTest in '..\..\tests\constraints\DValidation.Constraints.CreditCardNumberTest.pas',
  DValidation.Constraints.DigitsTest in '..\..\tests\constraints\DValidation.Constraints.DigitsTest.pas',
  DValidation.Constraints.Br.CNPJTest in '..\..\tests\constraints\br\DValidation.Constraints.Br.CNPJTest.pas',
  DValidation.Constraints.Br.CPFTest in '..\..\tests\constraints\br\DValidation.Constraints.Br.CPFTest.pas',
  DValidation.Constraints.Br.TituloEleitorTest in '..\..\tests\constraints\br\DValidation.Constraints.Br.TituloEleitorTest.pas',
  DValidation.Validators.Br.CNPJValidatorTest in '..\..\tests\validators\br\DValidation.Validators.Br.CNPJValidatorTest.pas',
  DValidation.Validators.Br.CPFValidatorTest in '..\..\tests\validators\br\DValidation.Validators.Br.CPFValidatorTest.pas';

{$R ..\resources\locale.res}

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin

  ReportMemoryLeaksOnShutdown := True;

{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
