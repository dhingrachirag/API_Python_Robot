*** Settings ***
Library    OperatingSystem




*** Variables ***
${AT&T_Jasper}    AT&T Jasper
${AT&T}    AT&T
${Jasper_automation}    Test_automation_Jasper
${Vodafone_automation}    Test_automation_Vodafone_GDSP
${Vodafone_UK_automation}    Test_automation_Vodafone_UK
${O2_UK_automation}    Test_automation_O2_UK
${Telstra_automation}    Test_automation_Telstra
${BT_UK_automation}    Test_automation_BT_UK
${TMobile_automation}    Test_automation_TMobile
${Liberty_automation}    Test_automation_Liberty
${AML_automation}    Test_automation_AML
${Optus-Yesflex_automation}    Test_automation_Optus_Yesflex
${Optus-M2Mflex_automation}    Test_automation_Optus_M2Mflex
${Optus-Mbbflex_automation}    Test_automation_Optus_Mbbflex
${rogers_automation}    Test_automation_Rogers
${disable}    disabled
${enable}    enabled
${offline}    offline
${online}    online
${Rogers_Account_Tenant}    ROGERS-Automation
${TMobile_Account_Tenant}    T-Mobile-Automation
${Liberty_Account_Tenant}    Liberty-Automation
${ATT_AML_Account_Tenant}    ATT-AML-Automation
${ATT_Jasper_Account_Tenant}    ATT-Jasper-Automation
${Optus-Yesflex_Account_Tenant}    Optus-Yesflex-Automation
${Optus-M2Mflex_Account_Tenant}    Optus-M2Mflex-Automation
${Optus-Mbbflex_Account_Tenant}    Optus-Mbbflex-Automation
${Verizon_Super_APN_Account_Tenant}    Verizon-Super-APN-Automation
${Verizon_automation}    Test_automation_Verizon
${Vodafone GDSP_Account_Tenant}    Vodafone_GDSP_Automation
${Vodafone_UK_Account_Tenant}    Vodafone-UK-Production-Automation
${O2_UK_Account_Tenant}    O2UK_Automation
${Telstra_Account_Tenant}    Telstra-Automation
${BT_UK_Account_Tenant}    BT-Automation
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