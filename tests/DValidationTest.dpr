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
  DValidation.ConstraintValidators.ConstraintValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.ConstraintValidator.pas',
  DValidation.Exceptions in '..\source\DValidation.Exceptions.pas',
  DValidation.ConstraintValidators.NotBlankValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.NotBlankValidator.pas',
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
  DValidation.ConstraintValidators.NotNullValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.NotNullValidator.pas',
  DValidation.ConstraintValidators.AssertTrueValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.AssertTrueValidator.pas',
  DValidation.Constraints.NotNull in '..\source\constraints\DValidation.Constraints.NotNull.pas',
  DValidation.ConstraintValidators.EmailValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.EmailValidator.pas',
  DValidation.ConstraintValidators.PatternValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.PatternValidator.pas',
  DValidation.Constraints.Size in '..\source\constraints\DValidation.Constraints.Size.pas',
  DValidation.ConstraintValidators.SizeValidatorForString in '..\source\constraintvalidators\DValidation.ConstraintValidators.SizeValidatorForString.pas',
  DValidation.ConstraintValidators.AssertFalseValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.AssertFalseValidator.pas',
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
  DValidation.ConstraintValidators.MaxValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.MaxValidator.pas',
  DValidation.Validators.MaxValidatorTest in 'Validators\DValidation.Validators.MaxValidatorTest.pas',
  DValidation.ConstraintValidators.DecimalMaxValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.DecimalMaxValidator.pas',
  DValidation.ConstraintValidators.MinValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.MinValidator.pas',
  DValidation.ConstraintValidators.DecimalMinValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.DecimalMinValidator.pas',
  DValidation.Validators.MinValidatorTest in 'Validators\DValidation.Validators.MinValidatorTest.pas',
  DValidation.Validators.DecimalMaxValidatorTest in 'Validators\DValidation.Validators.DecimalMaxValidatorTest.pas',
  DValidation.ConstraintValidators.NegativeOrZeroValidatorForOrdinal in '..\source\constraintvalidators\DValidation.ConstraintValidators.NegativeOrZeroValidatorForOrdinal.pas',
  DValidation.ConstraintValidators.PositiveOrZeroValidatorForOrdinal in '..\source\constraintvalidators\DValidation.ConstraintValidators.PositiveOrZeroValidatorForOrdinal.pas',
  DValidation.Validators.NotEmptyValidatorTest in 'Validators\DValidation.Validators.NotEmptyValidatorTest.pas',
  DValidation.ConstraintValidators.NotEmptyValidatorForString in '..\source\constraintvalidators\DValidation.ConstraintValidators.NotEmptyValidatorForString.pas',
  DValidation.Constraints.Validators in '..\source\constraints\DValidation.Constraints.Validators.pas',
  DValidation.ConstraintValidators.NotEmptyValidatorForCollection in '..\source\constraintvalidators\DValidation.ConstraintValidators.NotEmptyValidatorForCollection.pas',
  DValidation.ConstraintValidators.NotEmptyValidatorForArray in '..\source\constraintvalidators\DValidation.ConstraintValidators.NotEmptyValidatorForArray.pas',
  DValidation.ConstraintValidators.SizeValidatorForArray in '..\source\constraintvalidators\DValidation.ConstraintValidators.SizeValidatorForArray.pas',
  DValidation.ConstraintValidators.SizeValidatorForCollection in '..\source\constraintvalidators\DValidation.ConstraintValidators.SizeValidatorForCollection.pas',
  DValidation.ConstraintValidators.AbstractSizeValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.AbstractSizeValidator.pas',
  DValidation.ConstraintValidators.ConstraintValidatorUtils in '..\source\constraintvalidators\DValidation.ConstraintValidators.ConstraintValidatorUtils.pas',
  DValidation.ConstraintValidators.NegativeOrZeroValidatorForDecimal in '..\source\constraintvalidators\DValidation.ConstraintValidators.NegativeOrZeroValidatorForDecimal.pas',
  DValidation.ConstraintValidators.NegativeValidatorForDecimal in '..\source\constraintvalidators\DValidation.ConstraintValidators.NegativeValidatorForDecimal.pas',
  DValidation.ConstraintValidators.PositiveOrZeroValidatorForDecimal in '..\source\constraintvalidators\DValidation.ConstraintValidators.PositiveOrZeroValidatorForDecimal.pas',
  DValidation.ConstraintValidators.PositiveValidatorForDecimal in '..\source\constraintvalidators\DValidation.ConstraintValidators.PositiveValidatorForDecimal.pas',
  DValidation.ConstraintValidators.NegativeValidatorForOrdinal in '..\source\constraintvalidators\DValidation.ConstraintValidators.NegativeValidatorForOrdinal.pas',
  DValidation.ConstraintValidators.PositiveValidatorForOrdinal in '..\source\constraintvalidators\DValidation.ConstraintValidators.PositiveValidatorForOrdinal.pas',
  DValidation.ConstraintValidators.PastValidatorForDate in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.PastValidatorForDate.pas',
  DValidation.Validators.PastValidatorTest in 'Validators\DValidation.Validators.PastValidatorTest.pas',
  DValidation.ConstraintValidators.PastValidatorForDateTime in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.PastValidatorForDateTime.pas',
  DValidation.ConstraintValidators.PastValidatorForTime in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.PastValidatorForTime.pas',
  DValidation.ConstraintValidators.FutureValidatorForDate in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.FutureValidatorForDate.pas',
  DValidation.ConstraintValidators.FutureValidatorForDateTime in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.FutureValidatorForDateTime.pas',
  DValidation.ConstraintValidators.FutureValidatorForTime in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.FutureValidatorForTime.pas',
  DValidation.ConstraintValidators.FutureOrPresentValidatorForDate in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.FutureOrPresentValidatorForDate.pas',
  DValidation.ConstraintValidators.FutureOrPresentValidatorForDateTime in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.FutureOrPresentValidatorForDateTime.pas',
  DValidation.ConstraintValidators.FutureOrPresentValidatorForTime in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.FutureOrPresentValidatorForTime.pas',
  DValidation.ConstraintValidators.PastOrPresentValidatorForDate in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.PastOrPresentValidatorForDate.pas',
  DValidation.ConstraintValidators.PastOrPresentValidatorForDateTime in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.PastOrPresentValidatorForDateTime.pas',
  DValidation.ConstraintValidators.PastOrPresentValidatorForTime in '..\source\constraintvalidators\time\DValidation.ConstraintValidators.PastOrPresentValidatorForTime.pas',
  DValidation.ConstraintValidators.EANValidator in '..\source\constraintvalidators\DValidation.ConstraintValidators.EANValidator.pas',
  DValidation.Validators.EANValidatorTest in 'Validators\DValidation.Validators.EANValidatorTest.pas',
  DValidation.ConstraintValidators.RangeValidatorForDecimal in '..\source\constraintvalidators\DValidation.ConstraintValidators.RangeValidatorForDecimal.pas',
  DValidation.ConstraintValidators.RangeValidatorForOrdinal in '..\source\constraintvalidators\DValidation.ConstraintValidators.RangeValidatorForOrdinal.pas';

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
