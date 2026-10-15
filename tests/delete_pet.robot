*** Settings ***
Resource    ../resources/api_keywords.robot

*** Test Cases ***
Delete Pet
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

    ${delete_response}=    DELETE On Session
    ...    petstore
    ...    /pet/${PET_ID}

    Status Should Be    200    ${delete_response}

    ${get_response}=    GET On Session
    ...    petstore
    ...    /pet/${PET_ID}
    ...    expected_status=404

    Status Should Be    404    ${get_response}