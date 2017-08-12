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
    [TestCase('Case 1','email@domain.com, true')]
    [TestCase('Case 2','firstname.lastname@domain.com, true')]
    [TestCase('Case 3','email@subdomain.domain.com, true')]
    [TestCase('Case 4','firstname+lastname@domain.com, true')]
    [TestCase('Case 5','email@123.123.123.123, true')]
    [TestCase('Case 6','email@[123.123.123.123], true')]
    [TestCase('Case 7','"email"@domain.com, true')]
    [TestCase('Case 8','1234567890@domain.com, true')]
    [TestCase('Case 9','email@domain-one.com, true')]
    [TestCase('Case 10','_______@domain.com, true')]
    [TestCase('Case 11','email@domain.name, true')]
    [TestCase('Case 12','email@domain.co.jp, true')]
    [TestCase('Case 13','firstname-lastname@domain.com, true')]
    [TestCase('Case 14','plainaddress, false', 'Missing @ sign and domain')]
    [TestCase('Case 15','#@%^%#$@#$@#.com, false', 'Garbage')]
    [TestCase('Case 16','@domain.com, false', 'Missing username')]
    [TestCase('Case 17','Joe Smith <email@domain.com>, false', 'Encoded html within email is invalid')]
    [TestCase('Case 18','email.domain.com, false', 'Missing @')]
    [TestCase('Case 19','email@domain@domain.com, false', 'Two @ sign')]
    [TestCase('Case 20','.email@domain.com, false', 'Leading dot in address is not allowed')]
    [TestCase('Case 21','email.@domain.com, false', 'Trailing dot in address is not allowed')]
    [TestCase('Case 22','email..email@domain.com, false', 'Multiple dots')]
    [TestCase('Case 23','あいうえお@domain.com, false', 'Unicode char as address')]
    [TestCase('Case 24','email@domain.com (Joe Smith), false', 'Text followed email is not allowed')]
    [TestCase('Case 25','email@domain, false', 'Missing top level domain (.com/.net/.org/etc)')]
    [TestCase('Case 26','email@-domain.com, false', 'Leading dash in front of domain is invalid')]
    [TestCase('Case 27','email@domain.web, false', '.web is not a valid top level domain')]
    [TestCase('Case 28','email@111.222.333.44444, false', 'Invalid IP format')]
    [TestCase('Case 29','email@domain..com, false', 'Multiple dot in the domain portion is invalid')]
    procedure TestEmailConstraintValidator(const Email : string; const IsValid : Boolean);

    [Test]
    [TestCase('Case 1','email@domain.com, true')]
    procedure TestEmailValidator(const Email : string; const IsValid : Boolean);
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


procedure TEmailValidatorTest.TestEmailConstraintValidator(const Email : string; const IsValid : Boolean);
begin

   Assert.AreNotEqual(IsValid, FConstraintValidator.IsValid(Email));

end;

procedure TEmailValidatorTest.TestEmailValidator(const Email : string; const IsValid : Boolean);
begin

  Assert.AreNotEqual(IsValid, FValidator.Validate<TEmailValidatorTest>(Self).Count = 0);

end;

initialization
  TDUnitX.RegisterTestFixture(TEmailValidatorTest);
end.
