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
  Unit1 in 'Unit1.pas',
  DValidation.Constraints.Constraint in '..\source\constraints\DValidation.Constraints.Constraint.pas',
  DValidation.Constraints.Email in '..\source\constraints\DValidation.Constraints.Email.pas',
  DValidation.ContraintValidators.ConstraintValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.ConstraintValidator.pas',
  DValidation.Exceptions in '..\source\DValidation.Exceptions.pas',
  DValidation.ContraintValidators.NotBlankValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.NotBlankValidator.pas',
  DValidation in '..\source\DValidation.pas',
  DValidation.Engine.Impl.Validator in '..\source\engine\Impl\DValidation.Engine.Impl.Validator.pas',
  DValidation.Engine.ValidationContext in '..\source\engine\DValidation.Engine.ValidationContext.pas',
  DValidation.Constraints.Currency in '..\source\constraints\DValidation.Constraints.Currency.pas',
  DValidation.Constraints.NotBlank in '..\source\constraints\DValidation.Constraints.NotBlank.pas',
  DValidation.Constraints.CreditCardNumber in '..\source\constraints\DValidation.Constraints.CreditCardNumber.pas',
  DValidation.Constraints.EAN in '..\source\constraints\DValidation.Constraints.EAN.pas',
  DValidation.Constraints.NotEmpty in '..\source\constraints\DValidation.Constraints.NotEmpty.pas',
  DValidation.Constraints.Range in '..\source\constraints\DValidation.Constraints.Range.pas',
  DValidation.Constraints.Min in '..\source\constraints\DValidation.Constraints.Min.pas',
  DValidation.Constraints.Max in '..\source\constraints\DValidation.Constraints.Max.pas',
  DValidation.Constraints.AssertTrue in '..\source\constraints\DValidation.Constraints.AssertTrue.pas',
  DValidation.Constraints.AssertFalse in '..\source\constraints\DValidation.Constraints.AssertFalse.pas',
  DValidation.Constraints.DecimalMin in '..\source\constraints\DValidation.Constraints.DecimalMin.pas',
  DValidation.Constraints.DecimalMax in '..\source\constraints\DValidation.Constraints.DecimalMax.pas',
  DValidation.Constraints.Negative in '..\source\constraints\DValidation.Constraints.Negative.pas',
  DValidation.Constraints.NegativeOrZero in '..\source\constraints\DValidation.Constraints.NegativeOrZero.pas',
  DValidation.Constraints.Positive in '..\source\constraints\DValidation.Constraints.Positive.pas',
  DValidation.Constraints.PositiveOrZero in '..\source\constraints\DValidation.Constraints.PositiveOrZero.pas',
  DValidation.Constraints.Digits in '..\source\constraints\DValidation.Constraints.Digits.pas',
  DValidation.Constraints.Past in '..\source\constraints\DValidation.Constraints.Past.pas',
  DValidation.Constraints.PastOrPresent in '..\source\constraints\DValidation.Constraints.PastOrPresent.pas',
  DValidation.Constraints.Future in '..\source\constraints\DValidation.Constraints.Future.pas',
  DValidation.Constraints.FutureOrPresent in '..\source\constraints\DValidation.Constraints.FutureOrPresent.pas',
  DValidation.Constraints.Pattern in '..\source\constraints\DValidation.Constraints.Pattern.pas',
  DValidation.Constraints.Br.CNPJ in '..\source\constraints\br\DValidation.Constraints.Br.CNPJ.pas',
  DValidation.Constraints.Br.CPF in '..\source\constraints\br\DValidation.Constraints.Br.CPF.pas',
  DValidation.Constraints.Br.TituloEleitor in '..\source\constraints\br\DValidation.Constraints.Br.TituloEleitor.pas',
  DValidation.ContraintValidators.NotNullValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.NotNullValidator.pas',
  DValidation.ContraintValidators.AssertTrueValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.AssertTrueValidator.pas',
  DValidation.Constraints.NotNull in '..\source\constraints\DValidation.Constraints.NotNull.pas',
  DValidation.ContraintValidators.EmailValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.EmailValidator.pas',
  DValidation.ContraintValidators.PatternValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.PatternValidator.pas',
  DValidation.Constraints.Size in '..\source\constraints\DValidation.Constraints.Size.pas',
  DValidation.ContraintValidators.SizeValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.SizeValidator.pas',
  DValidation.ContraintValidators.AssertFalseValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.AssertFalseValidator.pas',
  DValidation.Validators.AssertFalseValidatorTest in 'Validators\DValidation.Validators.AssertFalseValidatorTest.pas',
  DValidation.Validators.AssertTrueValidatorTest in 'Validators\DValidation.Validators.AssertTrueValidatorTest.pas',
  DValidation.Constraints.Valid in '..\source\constraints\DValidation.Constraints.Valid.pas',
  DValidation.Constraints.GroupSequence in '..\source\constraints\DValidation.Constraints.GroupSequence.pas',
  DValidation.Engine.ValidatorFactory in '..\source\engine\DValidation.Engine.ValidatorFactory.pas',
  DValidation.Engine.ConstraintValidatorFactory in '..\source\engine\DValidation.Engine.ConstraintValidatorFactory.pas',
  DValidation.Engine.Validator in '..\source\engine\DValidation.Engine.Validator.pas',
  DValidation.Engine.MetaData.ObjectMetaDataManager in '..\source\engine\MetaData\DValidation.Engine.MetaData.ObjectMetaDataManager.pas',
  DValidation.Engine.MetaData.ObjectMetaData in '..\source\engine\MetaData\DValidation.Engine.MetaData.ObjectMetaData.pas',
  DValidation.Engine.MetaData.MetaConstraint in '..\source\engine\MetaData\DValidation.Engine.MetaData.MetaConstraint.pas',
  DValidation.Engine.ValueContext in '..\source\engine\DValidation.Engine.ValueContext.pas',
  DValidation.Engine.Impl.ValueContext in '..\source\engine\Impl\DValidation.Engine.Impl.ValueContext.pas',
  ValidationTest in 'ValidationTest.pas',
  Customer in 'Customer.pas',
  DValidation.Engine.Impl.ValidationContext in '..\source\engine\Impl\DValidation.Engine.Impl.ValidationContext.pas',
  DValidation.Engine.MetaData.Impl.ObjectMetaDataManager in '..\source\engine\MetaData\impl\DValidation.Engine.MetaData.Impl.ObjectMetaDataManager.pas',
  DValidation.Engine.MetaData.Impl.ObjectMetaData in '..\source\engine\MetaData\impl\DValidation.Engine.MetaData.Impl.ObjectMetaData.pas',
  DValidation.Engine.MetaData.Impl.MetaConstraint in '..\source\engine\MetaData\impl\DValidation.Engine.MetaData.Impl.MetaConstraint.pas',
  DValidation.Engine.ConstraintValidatorManager in '..\source\engine\DValidation.Engine.ConstraintValidatorManager.pas',
  DValidation.Engine.Impl.ConstraintValidatorManager in '..\source\engine\Impl\DValidation.Engine.Impl.ConstraintValidatorManager.pas',
  DValidation.Validators.EmailValidatorTest in 'Validators\DValidation.Validators.EmailValidatorTest.pas',
  DValidation.Engine.ConstraintViolation in '..\source\engine\DValidation.Engine.ConstraintViolation.pas',
  DValidation.Engine.Impl.ConstraintViolation in '..\source\engine\Impl\DValidation.Engine.Impl.ConstraintViolation.pas',
  DValidation.Engine.MessageInterpolator in '..\source\engine\DValidation.Engine.MessageInterpolator.pas',
  DValidation.Engine.Impl.MessageInterpolator in '..\source\engine\Impl\DValidation.Engine.Impl.MessageInterpolator.pas',
  DValidation.Engine.MessageInterpolatorTest in 'engine\DValidation.Engine.MessageInterpolatorTest.pas',
  DValidation.I18n.Locale in '..\source\I18n\DValidation.I18n.Locale.pas',
  DValidation.I18n.Impl.Locale in '..\source\I18n\impl\DValidation.I18n.Impl.Locale.pas',
  DValidation.ContraintValidators.MaxValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.MaxValidator.pas',
  DValidation.Validators.MaxValidatorTest in 'Validators\DValidation.Validators.MaxValidatorTest.pas',
  DValidation.ContraintValidators.DecimalMaxValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.DecimalMaxValidator.pas',
  DValidation.ContraintValidators.MinValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.MinValidator.pas',
  DValidation.ContraintValidators.DecimalMinValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.DecimalMinValidator.pas',
  DValidation.Validators.MinValidatorTest in 'Validators\DValidation.Validators.MinValidatorTest.pas',
  DValidation.Validators.DecimalMaxValidatorTest in 'Validators\DValidation.Validators.DecimalMaxValidatorTest.pas',
  DValidation.ContraintValidators.NegativeValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.NegativeValidator.pas',
  DValidation.ContraintValidators.PositiveValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.PositiveValidator.pas',
  DValidation.ContraintValidators.NegativeOrZeroValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.NegativeOrZeroValidator.pas',
  DValidation.ContraintValidators.PositiveOrZeroValidator in '..\source\constraintvalidators\DValidation.ContraintValidators.PositiveOrZeroValidator.pas',
  DValidation.Validators.NotEmptyValidatorTest in 'Validators\DValidation.Validators.NotEmptyValidatorTest.pas',
  DValidation.ContraintValidators.NotEmptyValidatorForString in '..\source\constraintvalidators\DValidation.ContraintValidators.NotEmptyValidatorForString.pas',
  DValidation.Constraints.Validators in '..\source\constraints\DValidation.Constraints.Validators.pas',
  DValidation.ContraintValidators.NotEmptyValidatorForCollection in '..\source\constraintvalidators\DValidation.ContraintValidators.NotEmptyValidatorForCollection.pas',
  DValidation.ContraintValidators.NotEmptyValidatorForArray in '..\source\constraintvalidators\DValidation.ContraintValidators.NotEmptyValidatorForArray.pas';

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
