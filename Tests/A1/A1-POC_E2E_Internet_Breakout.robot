*** Settings ***
Resource    ../../Resources/Mobileum.robot
Variables    ../../APITests.py

*** Test Cases ***
Run internet Breakout for A1-POC
    Run Internet Breakout Test and check status    ${A1-POC}

