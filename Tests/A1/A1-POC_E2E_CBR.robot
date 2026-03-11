*** Settings ***
Resource    ../../Resources/Mobileum.robot
Variables    ../../APITests.py



*** Test Cases ***
Run CBR Test for A1-POC
    Run CBR Test and check status    ${A1-POC}    ${GER}

