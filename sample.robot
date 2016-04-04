*** Settings ***
Library  Selenium2Library
Test Setup  open browser  http://www.wellsfargo.com  chrome
Test Teardown  close browser




*** Test Cases ***
Test Case 0
    [Tags]  Smoke
    Given I open Auto Finance Page

Test Case 1
  [Tags]  Smoke
  Given I open Auto Finance Page
  When I enter loan details as  10019  Used Auto Loan  20000  60
  Then I should see monthly payment as  $374.59

Test Case 2
  [Tags]  Smoke
  Given I open Auto Finance Page
  When I enter loan details as  10019  Used Auto Loan  15000  60
  Then I should see monthly payment as  $281.42

Test Case 3
  [Tags]  Negative
  Given I open Auto Finance Page
  When I enter loan details as  10019  Used Auto Loan  15000  48
  Then I should see monthly payment as  $344.29



*** Keywords ***
I open Auto Finance Page
    mouse down on link  Loans and Credit
    wait until element is visible  //*[@id="loans"]/div[1]/div[2]/ul/li[2]/a
    click link  Auto Loans
    set browser implicit wait  10
    title should be  Auto Loan & Car Loan Financing for your Vehicle - Wells Fargo
    click link  Use our auto financing payment calculator
    title should be  Auto Loan Calculator - Determine Car Loan Rates & Payments - Wells Fargo

I enter loan details as
    [Arguments]  ${Zip}  ${LoanType}  ${LoanAmount}  ${Term}
    input text  zipCode  ${Zip}
    select from list by label  selProdType  ${LoanType}
    input text  amount  ${LoanAmount}
    select from list by label  selTerm  ${Term}
    click element  Calculate

I should see monthly payment as
    [Arguments]  ${MonthlyPayment}
    element text should be  //*[@id='contentBody']/table/tbody/tr[2]/td[4]/strong  ${MonthlyPayment}
    capture page screenshot