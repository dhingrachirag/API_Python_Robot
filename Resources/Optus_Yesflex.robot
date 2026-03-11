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
Create initial Gateway setup for Optus-Yesflex
    Suppress Insecure Request Warnings
    Create IPSec gateway with 1 Port and 1 Link Linode Optus-Yesflex
    Get All IPSEC gateways and fetch newly created GatewayID Optus-Yesflex
    Check Disable status of Gateway Optus-Yesflex
    Patch Ipsec Gateways for Optus-Yesflex Japser Linode
    Check online Status after enabling the Gateway Optus-Yesflex
    Attach to Default Network Optus-Yesflex

Tear down initial Gateway Setup for Optus-Yesflex
    Delete Gateway attachment Optus-Yesflex
    Disable Ipsec Gateway Optus-Yesflex
    Check disabled Status after disabling the Gateway Optus-Yesflex
    Delete Ipsec Gateway Optus-Yesflex

Create IPSec gateway with 1 Port and 1 Link Linode Optus-Yesflex
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    IF    "${gateway_id}" == ""
           ${response}=    call post request    ${headers2}    ${base_url}   ${ipsec_gateways}    ${IPsec_gateway_1port_1link_Optus_Yesflex}
           log    ${response}
           Should Be True     ${response.status_code} == 201
           ${gateway_id}    get value from json     ${response.json()}    id
           log    ${gateway_id}
           Set Suite Variable    ${gateway_id}
    END
    [Return]    ${gateway_id}

Get All IPSEC gateways and fetch newly created GatewayID Optus-Yesflex
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
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
           ${var}=    set variable if    '${acc_name_str}' == '${Optus-Yesflex_automation}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Optus-Yesflex_automation}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Check Disable status of Gateway Optus-Yesflex
   ${status_gateway}=    Get Link Status of gateway for Optus-Yesflex Gateway
   should be equal    ${status_gateway}    ${disable}    msg=Status of Ipsec coming wrong.Possibility of bug.

Patch Ipsec Gateways for Optus-Yesflex Japser Linode
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID Optus-Yesflex
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

Check Online Status after enabling the Gateway Optus-Yesflex
   ${status_gateway}=    Get Link Status of gateway for Optus-Yesflex Gateway
   log    ${status_gateway}
   wait until keyword succeeds    5min    30s    Check online status Optus-Yesflex

Check online status Optus-Yesflex
   ${status_gateway}=    Get Link Status of gateway for Optus-Yesflex Gateway
   log    ${status_gateway}
   should be equal    ${status_gateway}    ${online}    msg=Status of Ipsec coming wrong.Possibility of bug.

Attach to Default Network Optus-Yesflex
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-owner-Id}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID Optus-Yesflex
    log    ${new_gateway_id}
    ${gateway_Optus-Yesflex_network}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments
    log    ${gateway_Optus-Yesflex_network}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept_format}   Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}    X-Asavie-Owner-Id=${X-Asavie-owner-Id}
    ${response}=    call post request    ${headers2}    ${base_url}    ${gateway_Optus-Yesflex_network}    ${attach_production_network_Optus_Yesflex}
    log    ${response}
    Should Be True     ${response.status_code} == 201
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}
    sleep    20s

Get Link Status of gateway for Optus-Yesflex Gateway
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID Optus-Yesflex
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

Get Account ID Inside Optus-Yesflex
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Tenant-Id}=    Get Optus-Yesflex Tenant ID for Production Environment
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
           ${var}=    set variable if    '${acc_name_str}' == '${Optus-Yesflex_Account_Tenant}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Optus-Yesflex_Account_Tenant}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}


Get Optus-Yesflex Tenant ID for Production Environment
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
           ${var}=    set variable if    '${acc_name_str}' == '${Optus-Yesflex_Account_Tenant}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Optus-Yesflex_Account_Tenant}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Delete Gateway attachment Optus-Yesflex
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID Optus-Yesflex
    log    ${new_gateway_id}
    ${attachment_id}=    Get Attachment ID for newly created Gateway Optus-Yesflex
    log    ${attachment_id}
    ${delete_Optus-Yesflexattach}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments/${attachment_id}
    log    ${delete_Optus-Yesflexattach}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${base_url}   ${delete_Optus-Yesflexattach}
    log    ${response}
    Should Be True     ${response.status_code} == 202

Disable Ipsec Gateway Optus-Yesflex
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID Optus-Yesflex
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

Check disabled Status after disabling the Gateway Optus-Yesflex
   ${status_gateway}=    Get Link Status of gateway for Optus-Yesflex Gateway
   log    ${status_gateway}
   wait until keyword succeeds    5min    30s    Check disabled status Optus-Yesflex

Check disabled status Optus-Yesflex
   ${status_gateway}=    Get Link Status of gateway for Optus-Yesflex Gateway
   log    ${status_gateway}
   should be equal    ${status_gateway}    ${disable}    msg=Status of Ipsec coming wrong.Possibility of bug.

Delete Ipsec Gateway Optus-Yesflex
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID Optus-Yesflex
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${base_url}   ${gateway_patch}
    log    ${response}
    Should Be True     ${response.status_code} == 200

Get Attachment ID for newly created Gateway Optus-Yesflex
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Optus-Yesflex
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
           ${var}=    set variable if    '${acc_name_str}' == '${Optus-Yesflex_automation}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Optus-Yesflex_automation}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}