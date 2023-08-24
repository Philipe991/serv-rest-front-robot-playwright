*** Settings ***
Resource    ../resources/resources.robot

*** Keywords ***
Ir para o site Serv Rest Front
    New Page       ${SITE_SERVE_REST}
    ${title}       Get Title    ==    Front - ServeRest
    Log    ${title}

Preencher os dados do novo usuário e cadastrar
    Click    ${SERV_REST_LOGIN_BTN_CADASTRESE}
    ${EMAIL}    FakerLibrary.Email
    Fill Text    ${SERV_REST_CADASTRESE_FIELD_NOME}     Phill
    Fill Text    ${SERV_REST_CADASTRESE_FIELD_EMAIL}    ${EMAIL}
    Fill Text    ${SERV_REST_CADASTRESE_FIELD_SENHA}    123456
    Check Checkbox    ${SERV_REST_CADASTRESE_CHECK_ADMIN}
    Click    ${SERV_REST_CADASTRESE_BTN_CADASTRAR}
    # Exemplo de seleção em cascata
    # Click    xpath=//*[@id="root"]//button >> text="Cadastrar"
    Sleep    5s

Conferir usuário cadastrado com sucesso
    # O playwright já possui esperas automáticas, não é necessário declarar wait como no Selenium, mas para exemplo:
    Wait For Elements State    h1    visible
    Get Text    h1    ==    Bem Vindo Phill
    # Verificar se o botão Logout possui valor e está visível
    Get Element States    //button[contains(.,'Logout')]    validate    value & visible