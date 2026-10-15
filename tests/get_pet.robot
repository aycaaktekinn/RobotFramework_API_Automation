*** Settings ***
Resource    ../resources/api_keywords.robot

*** Test Cases ***
Get Pet By Id
    Create Petstore Session
    ${PET_ID}=    Generate Pet Id

    ${body}=    Create Pet Body
    ...    ${PET_ID}
    ...    ${PET_NAME}
    ...    available

    POST On Session
    ...    petstore
    ...    /pet
    ...    json=${body}

    ${response}=    GET On Session
    ...    petstore
    ...    /pet/${PET_ID}

    Status Should Be    200    ${response}

    ${response_body}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${response_body}[id]    ${PET_ID}
    Should Be Equal    ${response_body}[name]    ${PET_NAME}
    Should Be Equal    ${response_body}[status]    available