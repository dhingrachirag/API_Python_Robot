*** Settings ***
Library    OperatingSystem




*** Variables ***
${AT&T_Jasper}    AT&T Jasper
${AT&T}    AT&T
${automation_name}    AT&T_Automation
${disable}    disabled
${enable}    enabled
${offline}    offline
${online}    online
${phase1}    Phase 1 not completed.
${phase2}    Phase 2 not completed.
${BGP}    BGP phase not completed.
${production_network_ID}    a313f35a-eae1-445d-a850-b7e50e7f811a
${ATT_Jasper_Account_Tenant}    ATT-Jasper-Automation
${Jasper_automation}    Test_automation_Jasper
${AML_automation}    Test_automation_AML
${ATT_AML_Account_Tenant}    ATT-AML-Automation
${Liberty_automation}    Test_automation_Liberty
${Liberty_Account_Tenant}    Liberty-Automation
${Verizon_Super_APN_Account_Tenant}    Verizon-Super-APN-Automation
${Verizon_automation}    Test_automation_Verizon
${Optus-Mbbflex_automation}    Test_automation_Optus_Mbbflex
${Optus-Mbbflex_Account_Tenant}    Optus-Mbbflex-Automation
${Optus-Yesflex_automation}    Test_automation_Optus_Yesflex
${Optus-Yesflex_Account_Tenant}    Optus-Yesflex-Automation
${Optus-M2Mflex_automation}    Test_automation_Optus_M2Mflex
${Optus-M2Mflex_Account_Tenant}    Optus-M2Mflex-Automation
${TMobile_automation}    Test_automation_TMobile
${TMobile_Account_Tenant}    T-Mobile-Automation
${Rogers_automation}    Test_automation_Rogers
${Rogers_Account_Tenant}    ROGERS-Automation
${A1-POC_automation}    Test_automation_A1_POC
${A1-POC_Account_Tenant}    A1-POC-Automation

#Static variable
${Optus-Mbbflex_Static_Automation}    Test_automation_Static_Optus_Mbbflex
${ATT-AML_Static_Automation}    Test_automation_Static_ATT_AML
${ATT_Jasper_Static_Automation}    Test_automation_Static_ATT_Jasper
${Optus-M2Mflex_Static_Automation}    Test_automation_Static_Optus_M2Mflex
${Verizon_Super_APN_Static_Automation}    Test_automation_Static_Verizon_Super_APN
${Rogers_Static_Automation}    Test_automation_Static_Rogers
${Liberty_Static_Automation}    Test_automation_Static_Liberty
${TMobile_Static_Automation}    Test_automation_Static_TMobile
${Static_Patch}     subscription/service-limits/ipsec_gateway_routing_static.feature
${Static_account_patch}     /v2/management/accounts