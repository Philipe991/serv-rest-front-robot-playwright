*** Settings ***
Resource    ../resources/resources.robot

*** Test Cases ***
Login com sucesso Serv Rest Front
    Abrir navegador
    Ir para o site Serv Rest Front
    Preencher os dados do novo usuário e cadastrar
    Conferir usuário cadastrado com sucesso