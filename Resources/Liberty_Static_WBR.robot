*** Settings ***
#Library    RequestsLibrary
Library    Zoomba.APILibrary
Variables  ../APITests.py
Resource   ../Variables/globalvariables.robot
Resource   ../Variables/production_variables.robot
Resource   ../Resources/production.robot
Library    JSONLibrary
Library    Collections

*** Variables ***
${account_id}
${tenant_id}
${owner_tenant_id}
${gateway_id}

*** Keywords ***

Static WBR Setup on Account and Creation of Gateway Liberty
    Suppress Insecure Request Warnings
    Create Static Enviroment for account Liberty
    Create IPSec Static gateway with 1 Port and 1 Link Linode Liberty
    Get All IPSEC gateways and fetch newly created Static GatewayID Liberty
    Check Disable status for Static Gateway Liberty
    Patch Ipsec Gateways for Static Linode Setup Liberty
    Attach Static gateway to Default Network Liberty
    Check Enable Status after enabling the Static Gateway Liberty

Tear down Static WBR Environment and Deletion of Gateway Liberty
    Delete Static Gateway Attachment Liberty
    Disable Static Ipsec Gateway Liberty
    Check disabled Status after disabling the Static Gateway Liberty
    Delete Static Ipsec Gateway Liberty
    Tear down Static Environment from account Liberty

Get Static Tenant ID for Production Environment
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
           ${var}=    set variable if    '${acc_name_str}' == '${Liberty_Account_Tenant}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Liberty_Account_Tenant}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}


Get Account ID for Static Setup
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Tenant-Id}=    Get Static Tenant ID for Production Environment
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
           ${var}=    set variable if    '${acc_name_str}' == '${Liberty_Account_Tenant}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Liberty_Account_Tenant}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Create Static Enviroment for account Liberty
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Tenant-Id}=    Get Static Tenant ID for Production Environment
    log    ${X-Asavie-Tenant-Id}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    ${static_path}=    Set Variable     ${Static_account_patch}/${X-Asavie-Account-Id}/${Static_Patch}
    set global variable       &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Tenant-Id=${X-Asavie-Tenant-Id}
    IF    "${gateway_id}" == ""
           ${response}=    call patch request   ${headers2}    ${base_url}    ${static_path}    ${static_patch_body}
           log    ${response}
           Should Be True     ${response.status_code} == 200
           ${gateway_id}    get value from json     ${response.json()}    id
           log    ${gateway_id}
           Set Suite Variable    ${gateway_id}
    END
    [Return]    ${gateway_id}


Create IPSec Static gateway with 1 Port and 1 Link Linode Liberty
    ExtendedHTTPLibrary.create session    static    ${base_url}    verify=True
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call post request    ${headers2}    ${base_url}   ${ipsec_gateways}    ${IPsec_Static_gateway_1port_1link_Liberty}
    log    ${response}
    Should Be True     ${response.status_code} == 201
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}
    Set Suite Variable    ${gateway_id}
    [Return]    ${gateway_id}

Get All IPSEC gateways and fetch newly created Static GatewayID Liberty
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${base_url}   ${ipsec_gateways}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    set suite variable    ${success_num}    ${0}
    sleep    30s
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${Liberty_Static_Automation}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Liberty_Static_Automation}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Check Disable status for Static Gateway Liberty
   ${status_gateway}=    Get Link Status of gateway for Static Gateway
   should be equal    ${status_gateway}    ${disable}    msg=Status of Ipsec coming wrong.Possibility of bug.

Patch Ipsec Gateways for Static Linode Setup Liberty
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created Static GatewayID Liberty
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

Attach Static gateway to Default Network Liberty
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-owner-Id}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created Static GatewayID Liberty
    log    ${new_gateway_id}
    ${gateway_attach_network}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments
    log    ${gateway_attach_network}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept_format}   Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}    X-Asavie-Owner-Id=${X-Asavie-owner-Id}
    ${response}=    call post request    ${headers2}    ${base_url}    ${gateway_attach_network}    ${attach_production_network_Liberty}
    log    ${response}
    Should Be True     ${response.status_code} == 201
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}

Check Enable Status after enabling the Static Gateway Liberty
   ${status_gateway}=    Get Link Status of gateway for Static Gateway
   log    ${status_gateway}
   wait until keyword succeeds    5min    30s    Check Enable status of Static Gateway

Check Enable status of Static Gateway
   ${status_gateway}=    Get Link Status of gateway for Static Gateway
   log    ${status_gateway}
   should be equal    ${status_gateway}    ${enable}    msg=Status of Ipsec coming wrong.Possibility of bug.

Get Link Status of gateway for Static Gateway
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created Static GatewayID Liberty
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

Delete Static Gateway Attachment Liberty
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created Static GatewayID Liberty
    log    ${new_gateway_id}
    ${attachment_id}=    Get Attachment ID for newly created Static Gateway
    log    ${attachment_id}
    ${delete_attach}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments/${attachment_id}
    log    ${delete_attach}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${base_url}   ${delete_attach}
    log    ${response}
    Should Be True     ${response.status_code} == 202

Disable Static Ipsec Gateway Liberty
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created Static GatewayID Liberty
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

Check disabled Status after disabling the Static Gateway Liberty
   ${status_gateway}=    Get Link Status of gateway for Static Gateway
   log    ${status_gateway}
   wait until keyword succeeds    5min    30s    Check disabled status of Static Gateway

Check disabled status of Static Gateway
   ${status_gateway}=    Get Link Status of gateway for Static Gateway
   log    ${status_gateway}
   should be equal    ${status_gateway}    ${disable}    msg=Status of Ipsec coming wrong.Possibility of bug.

Delete Static Ipsec Gateway Liberty
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created Static GatewayID Liberty
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${base_url}   ${gateway_patch}
    log    ${response}
    Should Be True     ${response.status_code} == 200

Get Attachment ID for newly created Static Gateway
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
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
           ${var}=    set variable if    '${acc_name_str}' == '${Liberty_Static_Automation}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Liberty_Static_Automation}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Tear down Static Environment from account Liberty
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Tenant-Id}=    Get Static Tenant ID for Production Environment
    log    ${X-Asavie-Tenant-Id}
    ${X-Asavie-Account-Id}=    Get Account ID for Static Setup
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    ${static_path}=    Set Variable     ${Static_account_patch}/${X-Asavie-Account-Id}/${Static_Patch}
    set global variable       &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Tenant-Id=${X-Asavie-Tenant-Id}
    ${response}=    call patch request   ${headers2}    ${base_url}    ${static_path}    ${static_teardown_patch_body}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}
    Set Suite Variable    ${gateway_id}
    [Return]    ${gateway_id}