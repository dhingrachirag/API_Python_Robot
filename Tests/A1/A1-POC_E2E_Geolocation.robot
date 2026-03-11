*** Settings ***
Resource    ../../Resources/Mobileum.robot
Variables    ../../APITests.py

*** Test Cases ***
Run Geolocation test for A1-POC
    Run Geolocation test and check status    ${A1-POC}
