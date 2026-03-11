*** Settings ***
Library    OperatingSystem




*** Variables ***
${global_roamer_url}    https://api.globalroamer.com/siteapi
${pkcs_directory}    //dns_api_automation//Certificate//DNS_Testing_Jenkins//Certificate//akamai_us_api.p12
${username}    akamai_us_api
${password_mobileum}    zF8%TgX4jxvx3klb
${certicate_dir}    Certificate
${available_tests}    /availabletests
${schedule}    /schedule/order
${user_agent}    Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36
${host}    api.globalroamer.com
${enconding}    gzip, deflate, br
${keep-alive}    keep-alive
${mobileum_url}    https://api.globalroamer.com
${test_status_mobileum}    /teststatus
${dest_path_logs_us}    //dns_api_automation/
${done}    done
${kpi}    /testcasekpi
${aborted}    aborted
${local_ip}    LocalIpAddress
${passed_state}    PASS
${testcases_path}  /Customers/Akamai_US/akamai_us_api
${resultfiles}    getresultfiles
${ATT Jasper}    ATT_Jasper
${ATT_AML}    ATT_AML
${Liberty}    Liberty
${Optus-Mbbflex}    Optus mbbflex
${Optus-Yesflex}    Optus yesflex
${Optus-M2Mflex}    Optus m2mflex
${Verizon Super APN}   Verizon Super APN
${Rogers}    Rogers
${Telcel}    Telcel
${T-Mobile}    T-Mobile
${A1-POC}    A1-POC
${location}    LocationUpdate
${pdpcontext}    PDP_ContextActivation
${webbrowsing}    Web_Browsing_20
${timeout}    'timeout'
${Static_WBR_IP}       10.90.90.2
${LAX}    USA-Los_Angeles
${ATL}    USA-Atlanta
${DFW}    USA-Dallas
${IAD}    USA-Philadelphia
${SYD}    Australia-Sydney
${MEL}    Australia-Melbourne
${ORD}    USA-Chicago
${PHL}    USA-Philadelphia
${EWR}    USA-New_York
${YMQ}    Canada-Toronto
${QRO}    Puerto_Rico-San_Juan
${Google_US}    Google_Snapshots_US
${Geolocation_US}    Geolocation_Snapshots_US
${country_us}    United States
${country_ca}    Canada
${country_russia}    Mexico
${country_mex}    México
