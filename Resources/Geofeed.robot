*** Settings ***
Library    RequestsLibrary
Library    Zoomba.APILibrary
Library    OperatingSystem
Library    String
Library    ../Customlibs/ExtendedHTTPLibrary.py
Resource   ../Variables/globalvariables.robot
Library    JSONLibrary
Library    Collections


*** Variables ***



*** Keywords ***
Get Grofeed Data from specific URL
    set global variable    &{headers2}    Accept=${accept}
    ${response}=    call get request   ${headers2}    ${geofeed_url}   ${SIA_feed}
    log    ${response}
    ${response_akamai}=    call get request    ${headers2}    ${geofeed_url}   ${akamai_feed}
    log    ${response_akamai}
    ${sorted2}    get from dictionary    ${response}    text
    log    ${sorted2}
    ${sorted3}    get from dictionary    ${response_akamai}    text
    log    ${sorted3}
    ${sorted_good}    get lines matching regexp    ${sorted2}    ${geofeed_regex}    partial_match=True
    log    ${sorted_good}
    ${geofeed_SIA}    get regexp matches     ${sorted2}    ${geofeed_regex}
    log    ${geofeed_SIA}
    ${geofeed_akamai}    get regexp matches     ${sorted3}    ${geofeed_regex}
    log    ${geofeed_akamai}
    ${sorted_akamai}    get lines matching regexp    ${sorted3}    ${geofeed_regex}    partial_match=True
    log    ${sorted_akamai}
    list should contain sub list    ${geofeed_akamai}    ${geofeed_SIA}    msg= Geofeed data has mismatch   values=False
