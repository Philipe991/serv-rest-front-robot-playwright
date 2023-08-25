*** Settings ***
Resource    ../resources/resources.robot
Suite Setup    Cadastrar usuário e logar
Suite Teardown    Close Browser    ALL

*** Test Cases ***
Login com sucesso Serv Rest Front
    Abrir navegador
    Ir para o site Serv Rest Front
    Preencher os dados do novo usuário e cadastrar
    Conferir usuário cadastrado com sucesso

Exemplo utilizando requisições http
    Abrir navegador
    Ir para o site Serv Rest Front
    Criar usuário via API
    Logar com o usuário cdadastrado via API

Exemplo utilizando o storage por contexto
    Abrir o site ServeRest Front logado
    Acessar a lista de usuários