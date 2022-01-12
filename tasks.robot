*** Settings ***
Documentation     Template robot main suite.
Library           RPA.Browser.Selenium
Library           RPA.Excel.Files
Library           RPA.HTTP

*** Keywords ***
Open the RPA challenge website
    Open Available Browser    http://rpachallenge.com/
    Download    http://rpachallenge.com/assets/downloadFiles/challenge.xlsx    overwrite=True
    Click Button    Start

*** Keywords ***
Get The List Of People From The Excel File
    Open Workbook    challenge.xlsx
    ${table}=    Read Worksheet As Table    header=True
    Close Workbook
    [Return]    ${table}

*** Keywords ***
Fill And Submit The Form
    [Arguments]    ${person}
    Input Text    //input[@ng-reflect-name="labelFirstName"]    ${person}[First Name]
    Input Text    //input[@ng-reflect-name="labelLastName"]    ${person}[Last Name]
    Input Text    //input[@ng-reflect-name="labelCompanyName"]    ${person}[Company Name]
    Input Text    //input[@ng-reflect-name="labelRole"]    ${person}[Role in Company]
    Input Text    //input[@ng-reflect-name="labelAddress"]    ${person}[Address]
    Input Text    //input[@ng-reflect-name="labelEmail"]    ${person}[Email]
    Input Text    //input[@ng-reflect-name="labelPhone"]    ${person}[Phone Number]
    Click Button    Submit

*** Keywords ***
Fill The Forms
    ${people}=    Get The List Of People From The Excel File
    FOR    ${person}    IN    @{people}
        Fill And Submit The Form    ${person}
    END

*** Keywords ***
Collect The Results
    Capture Element Screenshot    css:div.congratulations
    Close All Browsers

*** Tasks ***
Minimal task
    Open the RPA challenge website
    Fill The Forms
    Collect The Results
    Log    Done.
