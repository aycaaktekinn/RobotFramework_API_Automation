*** Settings ***
Resource    ../resources/api_keywords.robot

*** Test Cases ***
Update Pet
    Create Petstore Session
    ${PET_ID}=    Generate Pet Id

    ${initial_body}=    Create Pet Body
    ...    ${PET_ID}
    ...    ${PET_NAME}
    ...    available

    POST On Session
    ...    petstore
    ...    /pet
    ...    json=${initial_body}

    ${updated_body}=    Create Pet Body
    ...    ${PET_ID}
    ...    ${PET_NAME}
    ...    sold

    ${response}=    PUT On Session
    ...    petstore
    ...    /pet
    ...    json=${updated_body}

    Status Should Be    200    ${response}

    ${response_body}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${response_body}[id]    ${PET_ID}
    Should Be Equal    ${response_body}[status]    sold