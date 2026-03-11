*** Settings ***
Library    OperatingSystem




*** Variables ***
${global_roamer_url}    https://api.globalroamer.com/siteapi
${username}    akamai_us_api
${password_mobileum}    zF8%TgX4jxvx3klb
${certicate_dir}    Certificate
${available_tests}    /availabletests
${schedule}    /schedule/order
${kpi}    /testcasekpi
${pkcs_directory}    //var//lib/jenkins//workspace//DNS_Testing_Jenkins//Certificate//akamai_us_api.p12
${dest_path_logs_us}   //var//lib/jenkins//workspace//DNS_Testing_Jenkins/
${user_agent}    Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36
${host}    api.globalroamer.com
${enconding}    gzip, deflate, br
${keep-alive}    keep-alive
${mobileum_url}    https://api.globalroamer.com
${test_status_mobileum}    /teststatus
${done}    done
${local_ip}    LocalIpAddress
${passed_state}    PASS
${testcases_path}  /Customers/Akamai_US/akamai_us_api
${ATT Jasper}    ATT_Jasper
${DPDHL}    DPDHL
${Rogers}    Rogers
${ATT_AML}    ATT_AML
${Optus-Yesflex}    Optus yesflex
${Optus-Mbbflex}    Optus mbbflex
${Optus-M2Mflex}    Optus m2mflex
${T-Mobile}    T-Mobile
${Telstra}    Telstra
${O2_UK}    O2 UK
${BT_UK}    BT EE UK
${Liberty}    Liberty
${Transatel}    Transatel
${Telcel}    Telcel
${Verizon Super APN}   Verizon Super APN
${Vodafone_GDSP}   Vodafone GDSP
${Vodafone_UK}    Vodafone UK
${aborted}    aborted
${location}    LocationUpdate
${pdpcontext}    PDP_ContextActivation
${webbrowsing}    Web_Browsing_20
${timeout}    'timeout'
${resultfiles}    getresultfiles
${country_us}    United States
${country_apac}    Australia
${country_france}    France
${country_russia}    Mexico
${country_mex}    México
${country_ger}    Deutschland
${country_ger_loc}    Germany
${country_ca}    Canada
${SYD}    Australia-Sydney
${MEL}    Australia-Melbourne
${DFW}    USA-Dallas
${LAX}    USA-Los_Angeles
${SAN}    USA-San_Diego
${ATL}    USA-Atlanta
${SAF}    USA-San_Francisco
${IAD}    USA-Charlotte
${ORD}    USA-Chicago
${YMQ}    Canada-Toronto
${QRO}    Mexico-Cabo_San_Lucas
${PUR}    Puerto_Rico-San_Juan
${PHL}    USA-Philadelphia
${GRM}    Germany-Munich
${PAR}    France-Nice
${UK}    UK-London
${GER}    Austria-Vienna
${EWR}    USA-New_York
${ORD}    USA-Chicago
${Geolocation_US}    Geolocation_Snapshots_US
${Geolocation_UK}    Geolocation_Snapshots_UK
${Geolocation_APAC}    Geolocation_Snapshots_APAC
${Google}    Google
${Google_US}    Google_Snapshots_US
${Google_APAC}    Google_Snapshots_APAC
${Google_UK}    Google_Snapshots_UK
${A1-POC}    A1-POC
${Static_WBR_IP}       10.90.90.2