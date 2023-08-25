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

Criar usuário via API
    ${EMAIL}    FakerLibrary.Email
    Set Suite Variable    ${EMAIL}

    ${resposta}    Http    https://serverest.dev/usuarios    
    ...    method=POST
    ...    body={"nome": "Fulano da Silva", "email": "${EMAIL}", "password": "teste", "administrador": "true"}

    Should Be Equal As Integers    ${resposta["status"]}    201

Logar com o usuário cdadastrado via API
    ${resposta}    Http    https://serverest.dev/login    
    ...    method=POST
    ...    body={"email": "${EMAIL}", "password": "teste"}
    
    Should Be Equal As Integers    ${resposta["status"]}    200

    LocalStorage Set Item    serverest/userNome    Philipe Melo
    LocalStorage Set Item    serverest/userEmail    ${EMAIL}
    LocalStorage Set Item    serverest/userToken    ${resposta["body"]["authorization"]}

    Go To    https://front.serverest.dev/admin/home
    Take Screenshot

Acessar a lista de usuários
    Click    //a[contains(.,'Listar Usuários')]