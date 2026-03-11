*** Settings ***
Resource    ../../Resources/A1_POC.robot
Resource    ../../Resources/Mobileum.robot
Variables    ../../APITests.py
Suite Setup    Create initial Gateway setup for A1-POC
Suite Teardown    Tear down initial Gateway Setup for A1-POC


*** Test Cases ***
Run ping Test for WBR A1-POC
    Run Ping WBR test and check status    ${A1-POC}