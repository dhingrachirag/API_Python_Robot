import json

# Allows us to simply copy and paste expected results without having to change these to their python equivalents
false = False
true = True
null = None

tenant_data = \
    {
        "name": "Automation_User",
        "locale": "",
        "email": "dl-SRE-QA@akamai.com",
        "timezone": {
            "iana_id": "Europe/London"
        }
    }

account_data = \
    {
        "name": "Akamai",
        "email": "dl-SRE-QA@akamai.com",
        "region": "eu-1",
        "integrations": [

        ],
        "sku": "SDMOB001"
    }

device_data = \
    {
      "name": "Test_IRL_Device",
      "imeis": [

      ],
      "policy_group_id": "6a9b329c-3e5b-49cd-b684-eb00562835c7",
      "email": "",
      "phone_number": "+353873817869",
      "interfaces": [
        {
          "interface_type": "apn",
          "bearer": "cellular",
          "sim_number": "+353520000000",
          "sim_number_type": "msisdn",
          "apn_id": "vodafone-vdc_ie",
          "network_id": "c7e8f24a-593e-4102-91fe-a78df7a231e5",
          "iccid": ""
        }
      ]
    }

IPsec_gateway_1port_data = \
    {
     "name": "Test gateway with 1 port and link",
     "gateway_type": "ipsec",
     "enabled": true,
     "enterprise_destination_networks": [
        "10.10.50.0/16"
     ],
     "ports": [
        {
            "location": "FRA-STG",
            "links": [
                 {
                       "enterprise_asn": 64512,
                       "pre_shared_key": "mellon#$%26#$#52grerehetr",
                       "enterprise_public_ip": "192.46.220.29",
                       "ike_identity": null,
                       "ipsec_options": null
                 }
              ]
        }
     ]
    }

IPsec_gateway_1port_linode = \
    {
        "gateway_type": "ipsec",
        "name": "AT&T_Automation",
        "enterprise_destination_networks": [
            "10.23.23.0/24"
        ],
        "ports": [
            {
                "location": "DFW",
                "links": [
                    {
                        "enterprise_asn": "64514",
                        "enterprise_public_ip": "170.187.138.132",
                        "pre_shared_key": "Xx+DhEd4+md5+6[sw]I~HFin",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.23.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

new_gateway_port = \
    {
        "location": "FRA14",
        "links": [
        ]
    }

IPsec_gateway_2port_data = \
    {
        "name": "Test gateway with 2 port and link",
        "enterprise_destination_networks": [
            "172.16.0.0/12",
            "192.168.0.0/16"
        ],
        "gateway_type": "ipsec",
        "enabled": true,
        "ports": [{
            "id": null,
            "location": "FRA-STG",
            "links": [
                {
                    "id": null,
                    "enterprise_asn": "1234",
                    "pre_shared_key": "sialababamakniewiedzialajak",
                    "enterprise_public_ip": "38.30.22.126",
                    "ike_identity": null,
                    "inside_cidr_ip": "169.254.0.9",
                    "platform_ip_first": true,
                    "ipsec_options": null
                }
            ]
        },
            {
                "id": null,
                "location": "FRA14",
                "links": [
                    {
                        "id": null,
                        "enterprise_asn": "1234",
                        "pre_shared_key": "adziadwiedizalniepowiedzialatobylotak",
                        "enterprise_public_ip": "38.30.22.6",
                        "ike_identity": null,
                        "inside_cidr_ip": "169.254.0.10",
                        "platform_ip_first": true,
                        "ipsec_options": null
                    }
                ]
            }
        ]
     }

IPsec_gateway_1port_2links_data = \
    {
        "gateway_type": "ipsec",
        "name": "Test_ipsec_gateway_1port_2links",
        "enterprise_destination_networks": [
            "192.168.128.224/25"
        ],
        "ports": [
            {
                "location": "FRA-STG",
                "links": [
                    {
                        "enterprise_asn": "65501",
                        "enterprise_public_ip": "172.105.179.245",
                        "pre_shared_key": "O8g5z4t5C=RTtIi9oj$U(047",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.20.0"
                    },
                    {
                        "enterprise_asn": "65501",
                        "enterprise_public_ip": "139.177.186.34",
                        "pre_shared_key": "7!c@9{GccacGcNBqaOaiG-2-",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.30.0"
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_2links_Linode = \
    {
        "gateway_type": "ipsec",
        "name": "Test_ipsec_gateway_1port_2_Linode",
        "enterprise_destination_networks": [
            "192.168.128.224/25"
        ],
        "ports": [
            {
                "location": "FRA-STG",
                "links": [
                    {
                        "enterprise_asn": "65501",
                        "enterprise_public_ip": "172.105.179.245",
                        "pre_shared_key": "O8g5z4t5C=RTtIi9oj$U(047",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.20.0"
                    },
                    {
                        "enterprise_asn": "65501",
                        "enterprise_public_ip": "139.177.186.34",
                        "pre_shared_key": "7!c@9{GccacGcNBqaOaiG-2-",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.30.0"
                    }
                ]
            }
        ]
    }

IPsec_gateway_2port_2links_Linode = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Jasper",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "ports": [
            {
                "location": "DFW",
                "links": [
                    {
                        "enterprise_asn": "64999",
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.99.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    },
                    {
                        "enterprise_asn": "65000",
                        "enterprise_public_ip": "143.42.68.186",
                        "pre_shared_key": "W6j}X#%-FTC}SJ^rx4n&Lv4R",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.100.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            },
            {
                "location": "ORD",
                "links": [
                    {
                        "enterprise_asn": "64999",
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.101.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    },
                    {
                        "enterprise_asn": "65000",
                        "enterprise_public_ip": "143.42.68.186",
                        "pre_shared_key": "W6j}X#%-FTC}SJ^rx4n&Lv4R",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.102.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_ATT_Jasper = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Jasper",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "DFW",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "64999",
                "links": [
                    {
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.99.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_Rogers = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Rogers",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "ports": [
            {
                "location": "TYO",
                "links": [
                    {
                        "enterprise_asn": "64999",
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.109.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_TMobile = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_TMobile",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "ports": [
            {
                "location": "DUB",
                "links": [
                    {
                        "enterprise_asn": "64999",
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.100.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }


IPsec_gateway_1port_1link_Liberty = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Liberty",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "ports": [
            {
                "location": "ORD",
                "links": [
                    {
                        "enterprise_asn": "64999",
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.101.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway__1port_1link_ATT_AML = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_AML",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "ORD",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "64999",
                "links": [
                    {
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.101.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_Optus_Yesflex = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Optus_Yesflex",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "SYD",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "64999",
                "links": [
                    {
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.107.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_Optus_Mbbflex = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Optus_Mbbflex",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "MEL",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "64999",
                "links": [
                    {
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.108.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_Verizon_Super_APN = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Verizon",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "TYO",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "64999",
                "links": [
                    {
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.109.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_Optus_M2Mflex = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Optus_M2Mflex",
        "enterprise_destination_networks": [
            "10.101.101.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "MEL",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "65000",
                "links": [
                    {
                        "enterprise_public_ip": "172.105.38.247",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.110.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_Vodafone_GDSP = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Vodafone_GDSP",
        "enterprise_destination_networks": [
            "10.101.101.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "YTO",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "65000",
                "links": [
                    {
                        "enterprise_public_ip": "172.105.38.247",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.115.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_Vodafone_UK = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Vodafone_UK",
        "enterprise_destination_networks": [
            "10.101.101.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "DUB",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "65000",
                "links": [
                    {
                        "enterprise_public_ip": "172.105.38.247",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.112.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_O2_UK = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_O2_UK",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "DUB",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "64999",
                "links": [
                    {
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.100.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_Telstra = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Telstra",
        "enterprise_destination_networks": [
            "10.99.99.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "MEL",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "64999",
                "links": [
                    {
                        "enterprise_public_ip": "173.255.224.198",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.108.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_A1_POC = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_A1_POC",
        "enterprise_destination_networks": [
            "10.101.101.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "FRA",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "65000",
                "links": [
                    {
                        "enterprise_public_ip": "172.105.38.247",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.111.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_gateway_1port_1link_BT_UK = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_BT_UK",
        "enterprise_destination_networks": [
            "10.101.101.0/24"
        ],
        "routing": "dynamic",
        "ports": [
            {
                "location": "ORD",
                "platform_port_redundancy": "dual_platform_ip",
                "enterprise_asn": "65000",
                "links": [
                    {
                        "enterprise_public_ip": "172.105.38.247",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.113.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_integrity_algorithm": null,
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_integrity_algorithm": null,
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }

IPsec_Static_gateway_1port_1link_Liberty = \
    {
        "gateway_type": "ipsec",
        "name": "Test_automation_Static_Liberty",
        "enterprise_destination_networks": [
            "10.90.90.0/24"
        ],
        "routing": "static",
        "ports": [
            {
                "location": "ORD",
                "links": [
                    {
                        "enterprise_public_ip": "172.104.159.21",
                        "pre_shared_key": "Fz~$=QwySfMdVC@kODrF]E=p",
                        "platform_ip_first": true,
                        "inside_cidr_ip": "169.254.90.0",
                        "ipsec_options": {
                            "phase1_lifetime": 86400,
                            "phase1_encryption_algorithm": "aes-128-gcm",
                            "phase1_dh_group": "20",
                            "phase2_lifetime": 28800,
                            "phase2_encryption_algorithm": "aes-128-gcm",
                            "phase2_dh_group": "20"
                        }
                    }
                ]
            }
        ]
    }


update_ipsec_gateway = \
    {
        "enabled": true
    }

add_access_policy = \
    {
        "denied_web_categories": [
            {
                "id": "social_networking"
            }
        ],
        "ip_acls": [
            {
                "action": "deny",
                "description": "",
                "direction": "inbound",
                "enabled": true,
                "network_cidr": "8.8.8.8",
                "port_range": "any",
                "priority": 1,
                "protocol": "IP",
                "read_only": false
            },
            {
                "action": "deny",
                "description": "",
                "direction": "inbound",
                "enabled": true,
                "network_cidr": "1.1.1.1",
                "port_range": "any",
                "priority": 2,
                "protocol": "IP",
                "read_only": false
            },
            {
                "action": "allow",
                "description": "",
                "direction": "inbound",
                "enabled": true,
                "network_cidr": "any",
                "port_range": "any",
                "priority": 3,
                "protocol": "IP",
                "read_only": false
            }
        ],
        "website_rules": [
            {
                "pattern": "facebook.com",
                "action": "deny",
                "condition": "matches_suffix"
            }
        ]
    }

delete_access_policy = \
    {
        "denied_web_categories": [],
        "ip_acls": [],
        "website_rules": []
    }

disable_ipsec_gateway = \
    {
        "enabled": false
    }

attach_network = \
    {
        "network_id": "294ca2c8-9c04-4e90-984d-ce6a38f5c1bb"
    }

attach_production_network = \
    {
        "network_id": "a313f35a-eae1-445d-a850-b7e50e7f811a"
    }

attach_production_network_Rogers = \
    {
        "network_id": "146b12e7-8bbc-4aec-b197-38def8757fca"
    }

attach_production_network_TMobile = \
    {
        "network_id": "b940da83-3588-4114-9946-cd509db6307d"
    }

attach_production_network_Liberty = \
    {
        "network_id": "bb41e8db-89ee-40a5-aba6-b25df6d15621"
    }

attach_production_network_AML = \
    {
        "network_id": "6cb696a5-3ae0-4fa3-8c72-6be484af572b"
    }

attach_production_network_Optus_Yesflex = \
    {
        "network_id": "66c07c0b-55a4-455c-8c92-f3154aabe01b"
    }

attach_production_network_Optus_Mbbflex = \
    {
        "network_id": "2f271d46-86aa-4233-9061-46ee9cf3890c"
    }

attach_production_network_Verizon = \
    {
         "network_id": "21cbaad2-222e-4191-b36f-4e6e63fa8625"
    }

attach_production_network_Optus_M2Mflex = \
    {
        "network_id": "07890076-c4f3-432f-b152-4f5ead2cd9db"
    }

attach_production_network_Vodafone_GDSP = \
    {
        "network_id": "3acd11e4-9f66-4abb-a91b-63f7e5eacdad"
    }

attach_production_network_Vodafone_UK = \
    {
        "network_id": "53f9b7c4-01c6-4f9f-b8c3-720ff8320b25"
    }

attach_production_network_O2_UK = \
    {
        "network_id": "6db82104-76d9-4e3c-a8e2-0a473ad69372"
    }

attach_production_network_Telstra = \
    {
        "network_id": "09115582-44e5-4483-b18f-4079f6de5ee6"
    }

attach_production_network_BT_UK = \
    {
        "network_id": "9d4098a2-9abe-4287-b163-e66a46388493"
    }

attach_production_network_A1_POC = \
    {
        "network_id": "d260e2eb-6004-4a35-a370-2ffca6656875"
    }

static_patch_body = \
    {
      "enabled": true,
      "service_limit_type": "feature"
    }

static_teardown_patch_body = \
    {
      "enabled": false,
      "service_limit_type": "feature"
    }
