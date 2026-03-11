*** Settings ***
Library    RequestsLibrary
Library    Zoomba.APILibrary
Variables  ../APITests.py
Resource   ../Variables/globalvariables.robot
Resource   ../Variables/production_variables.robot
Resource    ../Resources/production.robot
Library    JSONLibrary
Library    Collections


*** Variables ***



*** Keywords ***
Create initial Gateway setup for T-Mobile
    Suppress Insecure Request Warnings
    Create IPSec gateway with 1 Port and 1 Link Linode T-Mobile
    Get All IPSEC gateways and fetch newly created GatewayID T-Mobile
    Check Disable status of Gateway TMobile
    Patch Ipsec Gateways for T-Mobile Linode
    Check online Status after enabling the Gateway TMobile
    Attach to Default Network T-Mobile

Tear down initial Gateway Setup for T-Mobile
    Delete Gateway attachment T-Mobile
    Disable Ipsec Gateway T-Mobile
    Check disabled Status after disabling the Gateway TMobile
    Delete Ipsec Gateway T-Mobile

Create IPSec gateway with 1 Port and 1 Link Linode T-Mobile
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    IF    "${gateway_id}" == ""
           ${response}=    call post request    ${headers2}    ${base_url}   ${ipsec_gateways}    ${IPsec_gateway_1port_1link_TMobile}
           log    ${response}
           Should Be True     ${response.status_code} == 201
           ${gateway_id}    get value from json     ${response.json()}    id
           log    ${gateway_id}
           Set Suite Variable    ${gateway_id}
    END
    [Return]    ${gateway_id}

Get All IPSEC gateways and fetch newly created GatewayID T-Mobile
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${base_url}   ${ipsec_gateways}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    set suite variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${TMobile_automation}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${TMobile_automation}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Check Disable status of Gateway TMobile
   ${status_gateway}=    Get Link Status of gateway for T-Mobile Gateway
   should be equal    ${status_gateway}    ${disable}    msg=Status of Ipsec coming wrong.Possibility of bug.

Patch Ipsec Gateways for T-Mobile Linode
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID T-Mobile
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call patch request    ${headers2}    ${base_url}   ${gateway_patch}   ${update_ipsec_gateway}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}

Check Online Status after enabling the Gateway TMobile
   ${status_gateway}=    Get Link Status of gateway for T-Mobile Gateway
   log    ${status_gateway}
   wait until keyword succeeds    5min    30s    Check online status T-Mobile

Check online status T-Mobile
   ${status_gateway}=    Get Link Status of gateway for T-Mobile Gateway
   log    ${status_gateway}
   should be equal    ${status_gateway}    ${online}    msg=Status of Ipsec coming wrong.Possibility of bug.

Attach to Default Network T-Mobile
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-owner-Id}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID T-Mobile
    log    ${new_gateway_id}
    ${gateway_T-Mobile_network}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments
    log    ${gateway_T-Mobile_network}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept_format}   Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}    X-Asavie-Owner-Id=${X-Asavie-owner-Id}
    ${response}=    call post request    ${headers2}    ${base_url}    ${gateway_T-Mobile_network}    ${attach_production_network_TMobile}
    log    ${response}
    Should Be True     ${response.status_code} == 201
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}
    sleep    20s

Get Link Status of gateway for T-Mobile Gateway
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID T-Mobile
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${base_url}   ${gateway_patch}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${gateway_status}    get value from json     ${response.json()}    $.status
    log    ${gateway_status}
    ${gateway_message}    get value from json     ${response.json()}    $.status_description.message
    log    ${gateway_message}
    ${gateway_status_description}=    Evaluate             "".join(${gateway_message})
    log    ${gateway_status_description}
    ${status_gateway}=   Evaluate              "".join(${gateway_status})
    log    ${status_gateway}
    [Return]    ${status_gateway}

Get Account ID Inside T-Mobile
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Tenant-Id}=    Get T-Mobile Tenant ID for Production Environment
    log    ${X-Asavie-Tenant-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Owner-Id=${X-Asavie-Owner-Id}   X-Asavie-Tenant-Id=${X-Asavie-Tenant-Id}
    ${response}=    call get request    ${headers2}    ${base_url}   ${stage_url_accounts}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Suite Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${TMobile_Account_Tenant}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${TMobile_Account_Tenant}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}


Get T-Mobile Tenant ID for Production Environment
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Tenant-Id}=    Get SREQA Tenant ID for Production Environment
    log    ${X-Asavie-Tenant-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Owner-Id=${X-Asavie-Owner-Id}   X-Asavie-Tenant-Id=${X-Asavie-Tenant-Id}
    ${response}=    call get request    ${headers2}    ${base_url}   ${stage_summary}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${account_id}    get value from json     ${response.json()}    $.items[0].id
    log    ${account_id}
    ${length}=    get length    ${response.json()}
    log    ${length}
    Set Suite Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${TMobile_Account_Tenant}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${TMobile_Account_Tenant}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Delete Gateway attachment T-Mobile
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID T-Mobile
    log    ${new_gateway_id}
    ${attachment_id}=    Get Attachment ID for newly created Gateway T-Mobile
    log    ${attachment_id}
    ${delete_T-Mobileattach}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments/${attachment_id}
    log    ${delete_T-Mobileattach}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${base_url}   ${delete_T-Mobileattach}
    log    ${response}
    Should Be True     ${response.status_code} == 202

Disable Ipsec Gateway T-Mobile
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID T-Mobile
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call patch request    ${headers2}    ${base_url}   ${gateway_patch}   ${disable_ipsec_gateway}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}

Check disabled Status after disabling the Gateway TMobile
   ${status_gateway}=    Get Link Status of gateway for T-Mobile Gateway
   log    ${status_gateway}
   wait until keyword succeeds    5min    30s    Check disabled status T-Mobile

Check disabled status T-Mobile
   ${status_gateway}=    Get Link Status of gateway for T-Mobile Gateway
   log    ${status_gateway}
   should be equal    ${status_gateway}    ${disable}    msg=Status of Ipsec coming wrong.Possibility of bug.

Delete Ipsec Gateway T-Mobile
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID T-Mobile
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${base_url}   ${gateway_patch}
    log    ${response}
    Should Be True     ${response.status_code} == 200

Get Attachment ID for newly created Gateway T-Mobile
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside T-Mobile
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${base_url}   ${ipsec_gateways}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Suite Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].attachments[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${TMobile_automation}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${TMobile_automation}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}