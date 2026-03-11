*** Settings ***
Library    RequestsLibrary
Library    Zoomba.APILibrary
Variables  ../APITests.py
Resource   ../Variables/globalvariables.robot
Resource   ../Resources/production.robot
Library    JSONLibrary
Library    Collections


*** Variables ***
${account_id}
${tenant_id}


*** Keywords ***
Create Account Post Request
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    Content-Type=${accept}
    IF    "${account_id}" == ""
          ${response}=    call post request    ${headers2}    ${base_url}   ${base_url_account}    ${account_data}
          log    ${response}
          Should Be True     ${response.status_code} == 201
          ${account_id}    get value from json     ${response.json()}    id
          log    ${account_id}
          Set Suite Variable    ${account_id}
    END
    [Return]    ${account_id}

Create Tenant Post Request
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    Content-Type=${accept}
    IF    "${tenant_id}" == ""
          ${response}=    call post request    ${headers2}    ${base_url}   /v2/management/tenants    ${tenant_data}
          log    ${response}
          Should Be True     ${response.status_code} == 201
          ${tenant_id}    get value from json     ${response.json()}    id
          log    ${tenant_id}
          Set Suite Variable    ${tenant_id}
    END
    [Return]    ${tenant_id}


Configure New Token
    ${auth}=   Evaluate   (${client_id}, ${client_secret},)
    Create Session   baseUri    ${base_url}    verify=True    auth=${auth}
    &{params}=  Create Dictionary    grant_type=${grant_type}
    &{headers}=  Create Dictionary   Accept= ${accept}, Content-Type= ${www-form}, Authorization= ${user} ${pass}
    ${resp}=  POST On Session    baseUri    ${token}    ${params}    ${headers}
    log   ${resp}
    ${type string}=    Evaluate     type($resp)
    Log To Console     ${type string}
    log   ${resp.json()['access_token']}
    ${accessToken}=    evaluate    $resp.json().get("access_token")
    log    ${accessToken}
    Status Should Be  200            ${resp}
    [Return]    ${accessToken}

Create Device POST Request
    Create Session   base    ${base_url}    verify=True
    ${token}=    Configure New Token
    log    ${token}
    ${X-asavie_ID}=    Get Account ID
    log    ${X-asavie_ID}
    ${policy_group_id}    Get Policy Group ID
    log    ${policy_group_id}
    ${Network_id}    Get Network ID
    log    ${Network_id}
    ${tag_1}  Create Dictionary  interface_type=apn    bearer=cellular    sim_number=${number}    sim_number_type=msisdn    apn_id=${apn_id}   network_id=${Network_id}    iccid=
    ${token1}=       Set Variable    Bearer ${token}
    @{ScoreList}=    Create List
    @{interfaces}=    Create List    ${tag_1}
    &{body}  Create Dictionary
    ...    name=${Device_name}
    ...    imeis=@{ScoreList}
    ...    policy_group_id=${policy_group_id}
    ...    email=
    ...    phone_number=${number}
    ...    interfaces=@{interfaces}
    ${body}  Evaluate    json.dumps(&{body})    json
    log    ${body}
    ${demo_body}=    convert string to json    ${body}
    log    ${demo_body}
    ${headers2}  Create Dictionary  Authorization=${token1}    Accept=${accept}, text/plain, */*    Content-Type=${accept}    X-Asavie-Account-Id=${X-asavie_ID}
    ${response}=    POST On Session     base    ${base_url_device}    headers=${headers2}    json=${demo_body}
    log    ${response}
    Should Be True     ${response.status_code} == 201


Get Account ID
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}
    ${response}=    call get request    ${headers2}    ${base_url}   ${base_url_account}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${account_id}    get value from json     ${response.json()}    $.items[2].id
    log    ${account_id}
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
           ${var}=    set variable if    '${acc_name_str}' == '${account_name}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${account_name}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Get Policy Group ID
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    ${X-asavie_ID}=    Get Account ID
    log    ${X-asavie_ID}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-asavie_ID}
    ${response}=    call get request    ${headers2}    ${base_url}   ${policy_group_path}
    log    ${response}
    log    ${response.json()}
    Should Be True     ${response.status_code} == 200
    ${policy_group}    get value from json     ${response.json()}    $.items[0].id
    log    ${policy_group}
    ${policy_group_id}=   Evaluate             "".join(${policy_group})
    log    ${policy_group_id}
    [Return]    ${policy_group_id}


Get Network ID
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    ${X-asavie_ID}=    Get Account ID
    log    ${X-asavie_ID}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    X-Asavie-Account-Id=${X-asavie_ID}
    ${response}=    call get request    ${headers2}    ${base_url}   ${policy_group_path}
    log    ${response}
    log    ${response.json()}
    Should Be True     ${response.status_code} == 200
    ${network}    get value from json     ${response.json()}    $.items[0].network.id
    log    ${network}
    ${network_id}=   Evaluate             "".join(${network})
    log    ${network_id}
    [Return]    ${network_id}


Post Device
    Create Session   base    ${base_url}    verify=True
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    ${X-asavie_ID}=    Get Account ID
    log    ${X-asavie_ID}
    ${policy_group_id}    Get Policy Group ID
    log    ${policy_group_id}
    ${Network_id}    Get Network ID
    log    ${Network_id}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}    Content-Type=${accept}    X-Asavie-Account-Id=${X-asavie_ID}
    ${response}=    call post request    ${headers2}    ${base_url}   ${base_url_device}    ${device_data}
    log    ${response}

Get Tenant Configuration
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    ${X-Asavie-Tenant}=    GET All Tenants
    log    ${X-Asavie-Tenant}
    ${tenant_configuration}=    set variable    /v2/management/tenants/${X-Asavie-Tenant}/configuration
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}
    ${response}=    call get request    ${headers2}    ${base_url}   ${tenant_configuration}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${tenant_body}   set variable    ${response.json()}
    log    ${tenant_body}
    [Return]    ${tenant_body}


GET All Tenants
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept}
    ${response}=    call get request    ${headers2}    ${base_url}   ${tenant}
    log    ${response}
    ${length}=    get length    ${response.json()["items"]}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${X_tenant_id}    get value from json     ${response.json()}    $.items[${success_num}].id
           log    ${X_tenant_id}
           ${ten_name}    get value from json     ${response.json()}    $.items[${success_num}].name
           log    ${ten_name}
           ${tenant_name_str}=   Evaluate             "".join(${ten_name})
           log    ${tenant_name_str}
           ${ten}=    set variable if    '${tenant_name_str}' == '${tenant_name}'    ${X_tenant_id}
           exit for loop if    '${tenant_name_str}' == '${tenant_name}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${tenan_ID}=   Evaluate             "".join(${ten})
    log    ${tenan_ID}
    [Return]    ${tenan_ID}


PUT Create Tenant with Custom Configuration
    Create Session   tenant    ${base_url}    verify=True
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    ${X-Asavie-Tenant}=    GET All Tenants
    log    ${X-Asavie-Tenant}
    ${tenant_body}=    Get Tenant Configuration
    log    ${tenant_body}
    ${tenant_config}=    set variable    /v2/management/tenants/${X-Asavie-Tenant}/configuration
    ${headers2}  Create Dictionary  Authorization=${token1}    Accept=${accept}    Content-Type=${accept}
    ${response}=    PUT On Session     tenant    ${tenant_config}   headers=${headers2}    json=${tenant_body}
    log    ${response}
    Should Be True     ${response.status_code} == 200

Update Default DNS Server
    Create Session   tenant2    ${base_url}    verify=True
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    ${X-Asavie-Tenant}=    GET All Tenants
    log    ${X-Asavie-Tenant}
    ${tenant_body}=    Get Tenant Configuration
    log    ${tenant_body}
    ${apn_dns_server_id}=    update value to json    ${tenant_body}    $.apn_configs[4].default_dns_server    ${ip_update}
    log    ${apn_dns_server_id}
    ${network1}    get value from json     ${apn_dns_server_id}    $.apn_configs[4].default_dns_server
    log    ${network1}
    ${network}    get value from json     ${tenant_body}    $.apn_configs[4].apn_id
    log    ${network}
    ${length}=    get length    ${tenant_body["apn_configs"]}
    log    ${length}
    Set Test Variable    ${success_num}    ${0}
    FOR    ${item}    IN RANGE    ${success_num}    ${length}
           ${apn_id}    get value from json     ${tenant_body}   $.apn_configs[${success_num}].apn_id
           log    ${apn_id}
           ${DNS_Server}    get value from json     ${tenant_body}    $.apn_configs[${success_num}].default_dns_server
           log    ${DNS_Server}
           ${apn_name}=   Evaluate             "".join(${apn_id})
           log    ${apn_name}
           ${apn_dns_server_id}=    update value to json    ${tenant_body}    $.apn_configs[${success_num}].default_dns_server    ${ip_update}
           log    ${apn_dns_server_id}
           ${DNS_Server1}    get value from json     ${apn_dns_server_id}    $.apn_configs[${success_num}].default_dns_server
           log    ${DNS_Server1}
           exit for loop if    '${apn_name}' == '${apn}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${apn_default_id}=   Evaluate             "".join(${DNS_Server1})
    log    ${apn_default_id}
    [Return]    ${apn_dns_server_id}

PUT Create Tenant with Updated Configuration
    Create Session   tenant2    ${base_url}    verify=True
    ${token}=    Configure New Token
    log    ${token}
    ${token1}=       Set Variable    Bearer ${token}
    ${X-Asavie-Tenant}=    GET All Tenants
    log    ${X-Asavie-Tenant}
    ${tenant_body}=    Update Default DNS Server
    log    ${tenant_body}
    ${tenant_config}=    set variable    /v2/management/tenants/${X-Asavie-Tenant}/configuration
    ${headers2}  Create Dictionary  Authorization=${token1}    Accept=${accept}    Content-Type=${accept}
    ${response}=    PUT On Session     tenant2    ${tenant_config}   headers=${headers2}    json=${tenant_body}
    log    ${response}
    Should Be True     ${response.status_code} == 200

Add Access Policy of Requested Client
    [Arguments]    ${client}
    Suppress Insecure Request Warnings
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Requested Client    ${client}
    log    ${X-Asavie-Account-Id}
    ${Access-Policy-Id}=    Get Access Policy of Requested Client    ${client}
    log    ${Access-Policy-Id}
    ${access_patch}=    set variable    ${access_policy}/${Access-Policy-Id}
    log    ${access_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept_format}   Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}    X-Asavie-Owner-Id=${X-Asavie-owner-Id}
    ${response}=    call patch request    ${headers2}    ${base_url}   ${access_patch}   ${add_access_policy}
    log    ${response}
    Should Be True     ${response.status_code} == 200

Get Access Policy of Requested Client
    [Arguments]    ${client}
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Requested Client    ${client}
    log    ${X-Asavie-Account-Id}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${aster}    Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}
    ${response}=    call get request    ${headers2}    ${base_url}   ${access_policy}
    log    ${response}
    Should Be True     ${response.status_code} == 200
    ${access_policy_id}    get value from json     ${response.json()}     $.items[0].id
    log    ${access_policy_id}
    ${status_access}=   Evaluate              "".join(${access_policy_id})
    log    ${status_access}
    [Return]    ${status_access}

Get Account ID Inside Requested Client
    [Arguments]    ${client}
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Tenant-Id}=    Get Requested Client Tenant ID for Production Environment    ${client}
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
           ${var}=    set variable if    '${acc_name_str}' == '${client}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${client}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Get Requested Client Tenant ID for Production Environment
    [Arguments]    ${client}
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
           ${var}=    set variable if    '${acc_name_str}' == '${client}'    ${acc_id}
           exit for loop if    '${acc_name_str}' == '${client}'
           ${success_num}=    Evaluate    ${success_num} + 1
           log    ${success_num}
    END
    ${convertListToString}=   Evaluate             "".join(${var})
    log    ${convertListToString}
    [Return]    ${convertListToString}

Delete Access Policy of Requested Client
    [Arguments]    ${client}
    Suppress Insecure Request Warnings
    ${token}=    Configure New Token for Production environment
    log    ${token}
    ${X-Asavie-Owner-Id}=    GET Owner Tenant ID for Production Environment
    log    ${X-Asavie-Owner-Id}
    ${X-Asavie-Account-Id}=    Get Account ID Inside Requested Client    ${client}
    log    ${X-Asavie-Account-Id}
    ${Access-Policy-Id}=    Get Access Policy of Requested Client    ${client}
    log    ${Access-Policy-Id}
    ${access_patch}=    set variable    ${access_policy}/${Access-Policy-Id}
    log    ${access_patch}
    ${token1}=       Set Variable    Bearer ${token}
    set global variable    &{headers2}     Authorization=${token1}    Accept=${accept_format}   Content-Type=${accept}    X-Asavie-Account-Id=${X-Asavie-Account-Id}    X-Asavie-Owner-Id=${X-Asavie-owner-Id}
    ${response}=    call patch request    ${headers2}    ${base_url}   ${access_patch}    ${delete_access_policy}
    log    ${response}
    Should Be True     ${response.status_code} == 200