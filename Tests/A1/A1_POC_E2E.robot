*** Settings ***
Resource    ../../Resources/Mobileum.robot
Variables    ../../APITests.py


*** Test Cases ***
Run internet Breakout for A1-POC
    Run Internet Breakout Test And Verify Exact Location for Specific APN    ${A1-POC}    ${country_ger}    ${Google_UK}    ${GER}

Run Geolocation test for A1-POC and Verify exact location
    Run Geolocation Test And Verify Exact Location for Specific APN    ${A1-POC}    ${country_ger_loc}    ${Geolocation_UK}    ${GER}
