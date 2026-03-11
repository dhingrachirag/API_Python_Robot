*** Settings ***
Library    OperatingSystem




*** Variables ***
${base_url}    https://api.securemobi.net
${Headers}    Content-Type=application/x-www-form-urlencoded
${client_id}   "78a755c9-59d2-11ed-a971-692cecbede48"
${client_secret}    "eNPMqGacVTqY2EWU/TRJzDfGefDY55jFNB4kddI+QAE="
${grant_type}    client_credentials
${user}    Basic
${pass}    NzhhNzU1YzktNTlkMi0xMWVkLWE5NzEtNjkyY2VjYmVkZTQ4OmVOUE1xR2FjVlRxWTJFV1UvVFJKekRmR2VmRFk1NWpGTkI0a2RkSStRQUU9
${bearer}    Bearer
${token}    /v2/oauth2/token
${base_url_tenant}    https://api.securemobi.net/management/tenants
${base_url_account}    /v2/management/accounts
${base_url_account_id}    /v2/management/accounts/:id
${base_url_device}    /v2/account/devices
${dff_dir}    AccountID
${Health_check}    Accountid.json
${account_json_path}    /Users/cdhingra/PycharmProjects/DNS_Testing/AccountID/Accountid.json
${Mobile_Network_path}    /v2/account/mobile-networks
${policy_group_path}      /v2/account/policy-groups
${X-Asavie-Tenant-Id}    a529ca70-1685-45bd-83a8-f61815d86130
${account_name}    Akamai
${Acc_not_found}    Account name not found
${number}    +353900000
${Device_name}    AKMAI_Ireland
${apn_id}    vodafone-vdc_ie
${accept}    application/json
${tenant}    /v2/management/tenants
${tenant_name}    Automation_User
${apn}    vodafone-vdc_ie
${ip_update}    185.123.168.41
${www-form}    application/x-www-form-urlencoded
${staging_url}    https://api.stg.securemobi.net
${staging_client_ID}    "eadf8fd5-ac59-11ed-a5bb-6b606345bca6"
${staging_client_Secret}    "UIL7r3Cg9yWZDOeEkIurIEp1lta5cLAzY6EDtk00Epw="
${pass_staging}    ZWFkZjhmZDUtYWM1OS0xMWVkLWE1YmItNmI2MDYzNDViY2E2OlVJTDdyM0NnOXlXWkRPZUVrSXVySUVwMWx0YTVjTEF6WTZFRHRrMDBFcHc9
${stage_url_account}    /account
${stage_url_accounts}    /v2/management/accounts?limit=10
${stage_url_owner_tenant}    /v2/management
${stage_summary}    /v2/management/tenants/summary
${Akamai_Test}    Akamai TEST
${Asavie_Telecom}    Asavie Telecom
${DT_APN}    DT APN
${SREQA}    SRE QA
${ipsec_gateways}    /v2/account/ipsec-gateways
${aster}    */*
${gateway_name}    Test gateway with 1 port and link
${Akamai_ID}    31b56fa7-2bf3-4af1-af19-812411f16028
${accept_format}    application/json, text/plain, */*
${new_gateway_name}    Test_ipsec_gateway_1port_2links
${1_port_link}    Test gateway with 1 port and link
${geofeed_url}    https://ipgeo.akamai.com/
${SIA_feed}    as200005-geofeed.csv
${akamai_feed}    akamai-geofeed.csv
${geofeed_regex}    ([0-9]+(?:\\.[0-9]+){3}.[0-9]+.[A-Z]+.[A-Z-]+.[A-Za-z]+.)+
${access_policy}    /v2/account/access-policies
