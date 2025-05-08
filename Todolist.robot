*** Settings ***
Library           SeleniumLibrary
Library           Collections

Test Setup        Open Todo List Page
Test Teardown     Close Browser

*** Variables ***
${URL}             https://abhigyank.github.io/To-Do-List/
${TASK}            Buy groceries

*** Test Cases ***
Verify Task Can Be Added
    Given I open the to-do list page
    When I add a new task    ${TASK}
    Then I should see task in the incomplete list    ${TASK}

Verify Task Can Be Marked As Completed
    Given I open the to-do list page
    When I add a new task    ${TASK}
    And I mark task as completed    ${TASK}
    Then I should see task in completed list    ${TASK}

Verify Task Can Be Deleted From Incomplete
    Given I open the to-do list page
    When I add a new task    ${TASK}
    And I delete the task from incomplete list
    Then I should not see task in the list    ${TASK}

Verify Completed Task Can Be Deleted
    Given I open the to-do list page
    When I add a new task    ${TASK}
    And I mark task as completed    ${TASK}
    And I delete the task from completed list
    Then I should not see task in the list    ${TASK}

*** Keywords ***
Open Todo List Page
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Page Contains Element    id=new-task

Add A New Task
    [Arguments]    ${task}
    Input Text    id=new-task    ${task}
    Click Element    xpath=//*[@class="material-icons"][normalize-space()='add']

Mark Task As Completed
    [Arguments]    ${task}
    Click Element    xpath=//*[@id="text-1"]  # basic logic assuming 1st task
    Sleep    1s  # allow DOM update

Delete The Task From Incomplete List
    Click Element    xpath=//*[@id="todo"]//*[@for="1"]/following-sibling::*[contains(@class,'delete')]

Delete The Task From Completed List
    Click Element    xpath=//div[@id="completed"]//button[contains(@class,'delete')]

I Should See Task In The Incomplete List
    [Arguments]    ${task}
    Element Should Contain    xpath=//ul[@id="incomplete-tasks"]    ${task}

I Should See Task In Completed List
    [Arguments]    ${task}
    Element Should Contain    xpath=//ul[@id="completed-tasks"]    ${task}

I Should Not See Task In The List
    [Arguments]    ${task}
    Page Should Not Contain    ${task}
