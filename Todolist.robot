*** Settings ***
# Run script robot Todaolist.robot
Library           SeleniumLibrary
Library           Collections

Test Setup        Set up 
Test Teardown     Close Browser

*** Variables ***
${URL}             https://abhigyank.github.io/To-Do-List/
${InputTask}       Buy groceries
${AddItemButton}   //*[@class="material-icons"][normalize-space()='add']
${TodoTask}        //*[@href="#todo"]  
${Completed}       //*[@href="#completed"] 
${DeleteTaskButton}      //*[@id="todo"]//*[@for="1"]/following-sibling::*[contains(@class,'delete')][text()='Delete']
${Task}            //*[@id="text-1"]
${DeleteCompleteTaskButton}        //button[contains(@class, 'mdl-button') and contains(@class, 'delete') and contains(text(), 'Delete')]

*** Test Cases ***
Test Adding New Tasks
    [Tags]    @AddingTasks
    [Setup]   Open Todo List Page
    Add Task  ${InputTask}

Test Marking Tasks as Completed
    [Tags]    @CompletingTasks
    [Setup]   Open Todo List Page
    Add Task  ${InputTask}
    Mark Task as Completed  

Test Deleting Tasks
    [Tags]    @DeletingTasks
    [Setup]   Open Todo List Page
    Add Task  ${InputTask}
    Delete Task  

Test Deleting completed task
    [Tags]     @DeletingCompleated 
    [Setup]    Open Todo List Page
    Add Task    ${InputTask}
    Mark Task as Completed     
    Delete Completed Task      ${InputTask}

*** Keywords ***
Set up 
    Open Browser    ${URL}    chrome
    Set Selenium Speed     2S

Open Todo List Page
    Open Browser    ${URL}    Chrome 
    Wait Until Page Contains Element    id=new-task

Add Task
    [Arguments]    ${task}
    Input Text    id=new-task    ${task}
    Wait Until Element Is Visible    ${AddItemButton}     
    Click Element    ${AddItemButton} 

Mark Task as Completed
    Wait Until Element Is Visible    ${TodoTask}      
    Click Element    ${TodoTask}  
    Wait Until Element Is Visible    ${Task}     
    Click Element    ${Task}   
    Wait Until Element Is Visible    ${Completed}    
    Click Element    ${Completed}  

Delete Task
    Wait Until Element Is Visible    ${TodoTask}   
    Click Element    ${TodoTask}
    Wait Until Element Is Visible    ${DeleteTaskButton}     
    Click Button    ${DeleteTaskButton} 
    Wait Until Element Is Visible     ${Completed}      
    Click Element    ${Completed}  


Delete Completed Task      
    [Arguments]    ${task}
    Wait Until Element Is Visible    ${Completed}      
    Click Element    ${Completed}  
    Wait Until Element Is Visible     ${DeleteCompleteTaskButton}    timeout=10s
    Click Element    ${DeleteCompleteTaskButton} 
    # //*[@id="completed"]//*[@id="completed-tasks"]//*[text()='${task}']/following-sibling::*[contains(@class,'delete')]