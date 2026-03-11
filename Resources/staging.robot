*** Settings ***
Library    RequestsLibrary
Library    Zoomba.APILibrary
Variables  ../APITests.py
Resource   ../Variables/globalvariables.robot
Library    JSONLibrary
Library    Collections


*** Variables ***
${account_id}
${tenant_id}
${owner_tenant_id}
${gateway_id}

*** Keywords ***

Configure New Token for Staging Environment
    ${auth}=   Evaluate   (${staging_client_ID}, ${staging_client_Secret},)
    Create Session   stageUri    ${staging_url}    verify=True    auth=${auth}
    &{params}=  Create Dictionary    grant_type=${grant_type}
    &{headers}=  Create Dictionary   Accept= ${accept}, Content-Type= ${www-form}, Authorization= ${user} ${pass_staging}
    ${resp}=  POST On Session    stageUri    ${token}    ${params}    ${headers}
    log   ${resp}
    ${type string}=    Evaluate     type($resp)
    Log To Console     ${type string}
    log   ${resp.json()['access_token']}
    ${accessToken}=    evaluate    $resp.json().get("access_token")
    log    ${accessToken}
    Status Should Be  200            ${resp}
    [Return]    ${accessToken}

Get AKAMAI TEST Account ID for Staging Environment
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Staging Environment
    log    ${X-Asavie-Owner-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Owner-Id=${X-Asavie-Owner-Id}   X-Asavie-Tenant-Id=${X-Asavie-Owner-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${stage_summary}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${account_id}    get value from json     ${response.json()}    $.items[0].id
    log    ${account_id}
    ${length}=    get length    ${response.json()}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${Akamai_Test}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Akamai_Test}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

GET Owner Tenant ID for Staging Environment
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}
    IF    "${owner_tenant_id}" == ""
           ${response}=    call get request    ${headers2}    ${staging_url}   ${stage_url_owner_tenant}
           log    ${response}
           Should Be True     ${response.status_code} == 200
           ${tenant_id}    get value from json     ${response.json()}    id
           log    ${tenant_id}
           Set Suite Variable    ${tenant_id}
    END
    ${convertListToString}=   Evaluate             "".join(${tenant_id})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Get Asavie Telecom Account ID for Staging Environment
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Staging Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Tenant-Id}=    Get AKAMAI TEST Account ID for Staging Environment
    log    ${X-Asavie-Tenant-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Owner-Id=${X-Asavie-Owner-Id}   X-Asavie-Tenant-Id=${X-Asavie-Tenant-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${stage_summary}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${account_id}    get value from json     ${response.json()}    $.items[0].id
    log    ${account_id}
    ${length}=    get length    ${response.json()}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${Asavie_Telecom}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${Asavie_Telecom}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Get DT Telecom ID for Staging Environment
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Staging Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Tenant-Id}=    Get Asavie Telecom Account ID for Staging Environment
    log    ${X-Asavie-Tenant-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Owner-Id=${X-Asavie-Owner-Id}   X-Asavie-Tenant-Id=${X-Asavie-Tenant-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${stage_summary}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${account_id}    get value from json     ${response.json()}    $.items[0].id
    log    ${account_id}
    ${length}=    get length    ${response.json()}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${DT_APN}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${DT_APN}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Get Account ID Inside DT APN
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Staging Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Tenant-Id}=    Get DT Telecom ID for Staging Environment
    log    ${X-Asavie-Tenant-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Owner-Id=${X-Asavie-Owner-Id}   X-Asavie-Tenant-Id=${X-Asavie-Tenant-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${stage_url_accounts}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${SREQA}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${SREQA}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Get All IPSEC gateways for respective Account and Fetch Gateway ID
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${ipsec_gateways}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${gateway_name}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${gateway_name}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Create IPSec gateway with 1 Port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    IF    "${gateway_id}" == ""
           ${response}=    call post request    ${headers2}    ${staging_url}   ${ipsec_gateways}    ${IPsec_gateway_1port_data}
           log    ${response}
           Should Be True     ${response.status_code} == 201
           ${gateway_id}    get value from json     ${response.json()}    id
           log    ${gateway_id}
           Set Suite Variable    ${gateway_id}
    END
    [Return]    ${gateway_id}

Create new port within existing Gateway
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${ipsec_gateway-Id}=    Get All IPSEC gateways for respective Account and Fetch Gateway ID
    log    ${ipsec_gateway-Id}
    ${existing_gateway_configuration}=    set variable    ${ipsec_gateways}/${ipsec_gateway-Id}/ports
    log    ${existing_gateway_configuration}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call post request    ${headers2}    ${staging_url}   ${existing_gateway_configuration}    ${new_gateway_port}
    log    ${response}
    Should Be True     ${response.status_code} == 201


Create Ipsec gateway with 2 port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    IF    "${gateway_id}" == ""
           ${response}=    call post request    ${headers2}    ${staging_url}   ${ipsec_gateways}    ${IPsec_gateway_2port_data}
           log    ${response}
           Should Be True     ${response.status_code} == 201
           ${gateway_id}    get value from json     ${response.json()}    id
           log    ${gateway_id}
           Set Suite Variable    ${gateway_id}
    END
    [Return]    ${gateway_id}

Create Ipsec Gateway 1 port with 2 Links
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept_format}   Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}    X-Asavie-Owner-Id=${Akamai_ID}
    ${response}=    call post request    ${headers2}    ${staging_url}   ${ipsec_gateways}    ${IPsec_gateway_1port_2links_data}
    log    ${response}
    Should Be True     ${response.status_code} == 201
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}
    [Return]    ${gateway_id}

Get All IPSEC gateways and fetch newly created GatewayID
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${ipsec_gateways}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${new_gateway_name}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${new_gateway_name}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Get All IPSEC gateways and fetch newly created GatewayID for 1 Port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${ipsec_gateways}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${1_port_link}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${1_port_link}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Attach to Default Network for 1 port 2links
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID
    log    ${new_gateway_id}
    ${gateway_attach_network}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments
    log    ${gateway_attach_network}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept_format}   Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}    X-Asavie-Owner-Id=${Akamai_ID}
    ${response}=    call post request    ${headers2}    ${staging_url}   ${gateway_attach_network}    ${attach_network}
    log    ${response}
    Should Be True     ${response.status_code} == 201
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}

Attach to Default Network for 1 port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID for 1 Port
    log    ${new_gateway_id}
    ${gateway_attach_network}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments
    log    ${gateway_attach_network}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept_format}   Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}    X-Asavie-Owner-Id=${Akamai_ID}
    ${response}=    call post request    ${headers2}    ${staging_url}   ${gateway_attach_network}    ${attach_network}
    log    ${response}
    Should Be True     ${response.status_code} == 201
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}

Patch Ipsec Gateways
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call patch request    ${headers2}    ${staging_url}   ${gateway_patch}   ${update_ipsec_gateway}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}


Patch Ipsec Gateways for 1 port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID for 1 Port
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call patch request    ${headers2}    ${staging_url}   ${gateway_patch}   ${update_ipsec_gateway}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${gateway_id}    get value from json     ${response.json()}    id
    log    ${gateway_id}

Get Link Status of gateway for 1 port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID for 1 Port
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${gateway_patch}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${gateway_status}    get value from json     ${response.json()}    $.status
    log    ${gateway_status}
    ${gateway_message}    get value from json     ${response.json()}    $.status_description.message
    log    ${gateway_message}
    ${gateway_status_description}=    Evaluate             "".join(${gateway_message})
    log    ${gateway_status_description}
    ${status_gateway}=   Evaluate             "".join(${gateway_status})
    log    ${status_gateway}

Get Link Status of gateway
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${gateway_patch}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${gateway_status}    get value from json     ${response.json()}    $.status
    log    ${gateway_status}
    ${gateway_message}    get value from json     ${response.json()}    $.status_description.message
    log    ${gateway_message}
    ${gateway_status_description}=    Evaluate             "".join(${gateway_message})
    log    ${gateway_status_description}
    ${status_gateway}=   Evaluate             "".join(${gateway_status})
    log    ${status_gateway}


Get Attachment ID for newly created Gateway
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${ipsec_gateways}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].attachments[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${new_gateway_name}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${new_gateway_name}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Get Attachment ID for newly created Gateway for 1 port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${staging_url}   ${ipsec_gateways}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${acc_id}    get value from json     ${response.json()}    $.items[${success_num}].attachments[${success_num}].id
           log    ${acc_id}
           ${acc_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${acc_name}
           ${acc_name_str}=   Evaluate             "".join(${acc_name})
           log    ${acc_name_str}
           ${var}=    set variable if    '${acc_name_str}' == '${1_port_link}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${1_port_link}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}


Delete Gateway Attachment
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID
    log    ${new_gateway_id}
    ${attachment_id}=    Get Attachment ID for newly created Gateway
    log    ${attachment_id}
    ${delete_attach}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments/${attachment_id}
    log    ${delete_attach}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${staging_url}   ${delete_attach}
    log    ${response}
    Should Be True     ${response.status_code} == 202

Delete Gateway Attachment for 1 port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID for 1 Port
    log    ${new_gateway_id}
    ${attachment_id}=    Get Attachment ID for newly created Gateway for 1 port
    log    ${attachment_id}
    ${delete_attach}=    set variable    ${ipsec_gateways}/${new_gateway_id}/attachments/${attachment_id}
    log    ${delete_attach}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${staging_url}   ${delete_attach}
    log    ${response}
    Should Be True     ${response.status_code} == 202

Delete Ipsec Gateway
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${staging_url}   ${gateway_patch}
    log    ${response}
    Should Be True     ${response.status_code} == 200

Delete Ipsec Gateway for 1 port
    ${token}=    Configure New Token for Staging Environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside DT APN
    log    ${X-Asavie-Account-Id}
    ${new_gateway_id}=    Get All IPSEC gateways and fetch newly created GatewayID for 1 Port
    log    ${new_gateway_id}
    ${gateway_patch}=    set variable    ${ipsec_gateways}/${new_gateway_id}
    log    ${gateway_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=   call delete request    ${headers2}    ${staging_url}   ${gateway_patch}
    log    ${response}
    Should Be True     ${response.status_code} == 200