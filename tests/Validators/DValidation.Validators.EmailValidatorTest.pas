{ ******************************************************************************
  Copyright 2017 Marcos Santos

  Contact: marcos.santos@outlook.com

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  *****************************************************************************}

unit DValidation.Validators.EmailValidatorTest;

interface
uses
  DUnitX.TestFramework,
  DValidation,
  DValidation.ContraintValidators.EmailValidator,
  DValidation.Engine.Impl.Validator,
  DValidation.Constraints.Email;

type

  [TestFixture]
  TEmailValidatorTest = class(TObject)
  private
    FConstraintValidator : TEmailValidator;

    FValidator : TValidator;

    [Email('')]
    FEmail : string;
  public
    [SetupFixture]
    procedure SetupFixture;

    [TearDownFixture]
    procedure TearDownFixture;

    [Test]
    [TestCase('Case 1','email@domain.com, 1')]
    [TestCase('Case 2','firstname.lastname@domain.com, 1')]
    [TestCase('Case 3','email@subdomain.domain.com, 1')]
    [TestCase('Case 4','firstname+lastname@domain.com, 1')]
    [TestCase('Case 5','email@123.123.123.123, 1')]
    [TestCase('Case 6','email@[123.123.123.123], 1')]
    [TestCase('Case 7','"email"@domain.com, 1')]
    [TestCase('Case 8','1234567890@domain.com, 1')]
    [TestCase('Case 9','email@domain-one.com, 1')]
    [TestCase('Case 10','_______@domain.com, 1')]
    [TestCase('Case 11','email@domain.name, 1')]
    [TestCase('Case 12','email@domain.co.jp, 1')]
    [TestCase('Case 13','firstname-lastname@domain.com, 1')]
    [TestCase('Case 14','plainaddress, 0')]
    [TestCase('Case 15','#@%^%#$@#$@#.com, 0')]
    [TestCase('Case 16','@domain.com, 0')]
    [TestCase('Case 17','Joe Smith <email@domain.com>, 0')]
    [TestCase('Case 18','email.domain.com, false')]
    [TestCase('Case 19','email@domain@domain.com, 0')]
    [TestCase('Case 20','.email@domain.com, 0')]
    [TestCase('Case 21','email.@domain.com, 0')]
    [TestCase('Case 22','email..email@domain.com, 0')]
    [TestCase('Case 23','あいうえお@domain.com, 0')]
    [TestCase('Case 24','email@domain.com (Joe Smith), 0')]
    [TestCase('Case 25','email@domain, 0')]
    [TestCase('Case 26','email@-domain.com, 0')]
    //[TestCase('Case 27','email@domain.web, 0')]
    //[TestCase('Case 28','email@111.222.333.44444, 0')]
    [TestCase('Case 29','email@domain..com, 0')]
    procedure TestEmailConstraintValidator(const Email : string; const IsValid : Integer);

    [Test]
    [TestCase('Case 1','email@domain.com, 1')]
    procedure TestEmailValidator(const Email : string; const IsValid : Integer);
  end;

implementation

procedure TEmailValidatorTest.SetupFixture;
begin
  FConstraintValidator := TEmailValidator.Create;
  FValidator := TDValidation.GetInstance.BuildValidator;
end;

procedure TEmailValidatorTest.TearDownFixture;
begin
  FConstraintValidator.Free;

  if Assigned(FValidator) then
    FValidator.Free;
end;


procedure TEmailValidatorTest.TestEmailConstraintValidator(const Email : string; const IsValid : Integer);
begin

   Assert.AreEqual(IsValid <> 0, FConstraintValidator.IsValid(Email));

end;

procedure TEmailValidatorTest.TestEmailValidator(const Email : string; const IsValid : Integer);
var
  Actual : Boolean;
begin

  Actual := FValidator.Validate<TEmailValidatorTest>(Self).Count = 0;

  Assert.AreEqual(IsValid <> 0, Actual);

end;

initialization
  TDUnitX.RegisterTestFixture(TEmailValidatorTest);
end.
