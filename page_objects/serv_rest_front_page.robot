*** Settings ***
Resource    ../resources/resources.robot

*** Variables ***
${SERV_REST_LOGIN_BTN_CADASTRESE}          //a[@data-testid='cadastrar'][contains(.,'Cadastre-se')]
${SERV_REST_CADASTRESE_FIELD_NOME}         id=nome
${SERV_REST_CADASTRESE_FIELD_EMAIL}        id=email
${SERV_REST_CADASTRESE_FIELD_SENHA}        id=password
${SERV_REST_CADASTRESE_CHECK_ADMIN}        id=administrador
${SERV_REST_CADASTRESE_BTN_CADASTRAR}      //button[@data-testid='cadastrar'][contains(.,'Cadastrar')]