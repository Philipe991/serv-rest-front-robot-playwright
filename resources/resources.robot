*** Settings ***
Documentation       Aqui consta todos os recursos do projeto.
Library    Browser    
...        timeout=20s
# ...        enable_presenter_mode=${True}
Library    FakerLibrary    locale=pt_BR
Library    String
Library    DateTime
# Library    ../custom_librarys/remover_acentos_cedilha.py

#CUSTOM_LIBRARIES
Library     ../custom_librarys/criar_prefixo_email.py
Library     ../custom_librarys/criar_cpf_valido.py

# SUPPORT
Resource    ../data/criar_pessoa.robot
Resource    ../data/criar_cpf_valido.robot

# PAGES_OBJECTS
Resource    ../page_objects/serv_rest_front_page.robot

#STEPS_DEFINITIONS
Resource    ../step_definitions/serv_rest_front_steps.robot

*** Variables ***
# Diferente do Selenium, o Playwright não usa o webdriver do Crhome, por isso foi declarado "chromium"
${BROWSER}            chromium
${HEADLESS}           false
${URL_XP}             https://xp-wl.fiibo.digital
${URL_WL}             https://wl.fiibo.digital
${SITE_SERVE_REST}    https://front.serverest.dev
&{USUARIO_ADMIN}              username=adminph@fiibo.com.br           password=Fiibo@123

*** Keywords ***
Abrir navegador
    New Browser    browser=${BROWSER}    
    ...            headless=${HEADLESS}
    
    ${NOW}           Get Current Date    result_format=%d-%m-%Y_%H%M%S 

    New Context    viewport={'width': 1800, 'height':900}    
    # ...            tracing=${OUTPUT_DIR}/results/traces/${NOW}/${TEST_NAME}.zip
    # ...            recordVideo={'dir':'${OUTPUT_DIR}/results/videos/${TEST_NAME}'}

Fechar navegador
    Take Screenshot

Criar prefixo de email
    [Arguments]    ${NOME_PESSOA}
    ${PREFIXO_EMAIL}    Criar Prefixo Email    ${NOME_PESSOA}
    Log    ${PREFIXO_EMAIL}
    [Return]    ${PREFIXO_EMAIL}

Então o sistema deve exibir a mensagem    
...    [Arguments]    ${MENSAGEM_ESPERADA}
    Wait For Elements State    id=chakra-toast-manager-top-right    stable
    Get Text    id=chakra-toast-manager-top-right >> id=toast-1-description    ==    ${MENSAGEM_ESPERADA}
    # Wait For Elements State    id=chakra-toast-manager-top-right    hidden

Aguardar o loader
    Wait For Elements State   xpath = //div[contains(@class,'loadingLoader')]    visible
    Wait For Elements State   xpath = //div[contains(@class,'loadingLoader')]    hidden