*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://petstore.swagger.io/v2
${PET_NAME}    Pamuk

*** Keywords ***
Create Petstore Session
    Create Session    petstore    ${BASE_URL}

Generate Pet Id
    ${pet_id}=    Evaluate    int(__import__('time').time() * 1000)
    Log To Console    Generated Pet ID: ${pet_id}
    RETURN    ${pet_id}

Create Pet Body
    [Arguments]    ${id}    ${name}    ${status}
    ${body}=    Create Dictionary
    ...    id=${id}
    ...    name=${name}
    ...    status=${status}
    RETURN    ${body}