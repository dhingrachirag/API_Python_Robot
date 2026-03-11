*** Settings ***
Library    OperatingSystem
*** Variables ***
#${Shubham_nms_username}    crypt:vVgVyMnVL0seERCt1qldomcb+hRQC1uAS0eSgIznnFifvOf2nhxETtO9UNgiEU8ymflAKS85
#${Shubham_nms_pass}        crypt:8lS/BwJ4cgKWxKjQIjSuHArk977F5v/PtIlEp0oPjzci3955DpIiKzZWQpAp1HyEYdJczQv7rC2JOecJ
#${Chirag_nms_username}       crypt:IImzoheQOqYcThCRVb2w+zqjDUKhaKvB2X2f2ZhT1FILZD7YuaJ4fnA6qtfLCtbERh3uJaECyEo=
#${Chirag_nms_pass}    crypt:PeFinNojX/0FrWhoj15U8d5AGGXvZSjDBH9PTNEbfGpnoekddqx4XnGl4nf6f5EvUL79rSlfKBM=
#${TS_LAX_Pass}    crypt:a9Kd7UL+napy72U2dbLaQvwfk2IW9Y8L85RLoaFWNCLESXBapU4YlFe4OFz+3SD5b9q/SadGGhlIICNCPMYanm2ET44=
#${AMB_Lax_Password}    crypt:IfRss9I4dmyu/2+eNrhCG7yCrfME04Atllj+bFuhr2p8cR6spcA1bKGDbt297/NUXbSdtkKy8Gcmuvwo

# ATL DE Site
#${master_username}   root
#${ABR-01}    172.24.40.16
#${ABR-02}    172.24.40.17
#${ABR-03}    172.24.40.18
#${ABR-04}    172.24.40.19
#${ABR-05}    172.24.40.40
#${ABR-06}    172.24.40.41
#${ABR-07}    172.24.40.42
#${ABR-08}    172.24.40.43
#${RSX-01}    172.24.40.51
#${RSX-02}    172.24.40.52
#${RSX-03}    172.24.40.53
#${RSX-04}    172.24.40.54
#${RSX-05}    172.24.40.55
#${RSX-06}    172.24.40.56
#${RSX-07}    172.24.40.57
#${RSX-08}    172.24.40.58
#${AAA-01}    172.24.40.34
#${AAA-02}    172.24.40.35
#${XEPA-01}    172.24.40.28
#${XEPA-02}    172.24.40.29
#${WCS-01}    172.24.39.35
#${WCS-02} 	 172.24.39.36
#${AAA-Simulator}    172.24.40.33
#${UE-Simulator}     172.24.40.36
#${DE_PASSWORD}    crypt:L61cSu07yQFiHxoc1rj2WMgsQmZkqVdgxds/eh7ZNAd1CEHKkxTpnHlfmA5K3DfkeBspYY7sQdE6OgDSRw==
#${website_name}    google.com


# DFW DE Site
#${master_username}   root
#${ABR-01}    172.24.28.16
#${ABR-02}    172.24.28.17
#${ABR-03}    172.24.28.18
#${ABR-04}    172.24.28.19
#${ABR-05}    172.24.28.40
#${ABR-06}    172.24.28.41
#${ABR-07}    172.24.28.42
#${ABR-08}    172.24.28.43
#${RSX-01}    172.24.28.51
#${RSX-02}    172.24.28.52
#${RSX-03}    172.24.28.53
#${RSX-04}    172.24.28.54
#${RSX-05}    172.24.28.55
#${RSX-06}    172.24.28.56
#${RSX-07}    172.24.28.57
#${RSX-08}    172.24.28.58
#${AAA-01}    172.24.28.34
#${AAA-02}    172.24.28.35
#${XEPA-01}    172.24.28.28
#${XEPA-02}    172.24.28.29
#${WCS-01}    172.24.27.35
#${WCS-02} 	 172.24.27.36
#${AAA-Simulator}    172.24.28.33
#${UE-Simulator}     172.24.28.36
#${DE_PASSWORD}    crypt:mvKyZn01CvwCsUmVuWDwwuymJ0/Nzc9UVbmus8OgRxNBtBkAWQ9v9nu34KtCwTw50bPuMwnKms9tc2Gf
#${website_name}    google.com


# EWR DE Site
#${master_username}   root
#${ABR-01}    172.24.25.16
#${ABR-02}    172.24.25.17
#${ABR-03}    172.24.25.18
#${ABR-04}    172.24.25.19
#${ABR-05}    172.24.25.40
#${ABR-06}    172.24.25.41
#${ABR-07}    172.24.25.42
#${ABR-08}    172.24.25.43
#${RSX-01}    172.24.25.51
#${RSX-02}    172.24.25.52
#${RSX-03}    172.24.25.53
#${RSX-04}    172.24.25.54
#${RSX-05}    172.24.25.55
#${RSX-06}    172.24.25.56
#${RSX-07}    172.24.25.57
#${RSX-08}    172.24.25.58
#${AAA-01}    172.24.25.34
#${AAA-02}    172.24.25.35
#${XEPA-01}    172.24.25.28
#${XEPA-02}    172.24.25.29
#${WCS-01}    172.24.24.35
#${WCS-02} 	 172.24.24.36
#${AAA-Simulator}    172.24.28.33
#${UE-Simulator}     172.24.28.36
#${DE_PASSWORD}    crypt:DnEN5wi8vTo5pApWPS+4xbHiqtTT2gJZjFVos0EbGElF2j3mehH/tcAZG9J9bSdSLutfgZ6C9JXi2Jinhr4=
#${website_name}    google.com


# FRA04 DE Site
${master_username}   root
${ABR-01}    172.24.70.16
${ABR-02}    172.24.70.17
${ABR-03}    172.24.70.18
${ABR-04}    172.24.70.19
${RSX-01}    172.24.70.51
${RSX-02}    172.24.70.52
${RSX-03}    172.24.70.53
${RSX-04}    172.24.70.54
${AAA-01}    172.24.70.34
${AAA-02}    172.24.70.35
${XEPA-01}    172.24.70.28
${XEPA-02}    172.24.70.29
${WCS-01}    172.24.69.35
${WCS-02} 	 172.24.69.36
${AAA-Simulator}    172.24.70.33
${UE-Simulator}     172.24.70.36
${DE_PASSWORD}    crypt:nxJvy+W1fAfB6CspPi98xTXn4hGJ83wPoumw4uQ/BFEGDtA+G4M0vgamzX4tV3oFGjJAvfiiuSBBQnw3
${website_name}    google.com
${Radius_Message_execution}     ip netns exec AAA12 ./testapex_working -D -cfg cfg_examples/cfg_de_AAASim_zz2.yml -scn fullsession_CAN001_Core_internet_SREQA.xml
${Radius_Message_execution_ABR34}   ip netns exec AAA34 ./testapex_working -D -cfg cfg_examples/cfg_de_AAASim_dt0.yml -scn stg_test_internet_SREQA.xml

# FRA08 DE Site
#${master_username}   root
#${ABR-01}    172.24.67.16
#${ABR-02}    172.24.67.17
#${ABR-03}    172.24.67.18
#${ABR-04}    172.24.67.19
#${RSX-01}    172.24.67.51
#${RSX-02}    172.24.67.52
#${RSX-03}    172.24.67.53
#${RSX-04}    172.24.67.54
#${AAA-01}    172.24.67.34
#${AAA-02}    172.24.67.35
#${XEPA-01}    172.24.67.28
#${XEPA-02}    172.24.67.29
#${WCS-01}    172.24.66.35
#${WCS-02} 	 172.24.66.36
#${AAA-Simulator}    172.24.67.33
#${UE-Simulator}     172.24.67.36
#${DE_PASSWORD}    crypt:wMytGuNI1bGq6Tug+aM6sVFeuWk0JcUE+Bgx8b4nnCg16BfzrEuCagKn+N01J21eGHzmvwLPT5mLlKne
#${website_name}    google.com


# HKG DE Site
#${master_username}   root
#${ABR-01}    172.24.52.16
#${ABR-02}    172.24.52.17
#${ABR-03}    172.24.52.18
#${ABR-04}    172.24.52.19
#${RSX-01}    172.24.52.51
#${RSX-02}    172.24.52.52
#${RSX-03}    172.24.52.53
#${RSX-04}    172.24.52.54
#${AAA-01}    172.24.52.34
#${AAA-02}    172.24.52.35
#${XEPA-01}    172.24.52.28
#${XEPA-02}    172.24.52.29
#${WCS-01}    172.24.51.35
#${WCS-02} 	 172.24.51.36
#${AAA-Simulator}    172.24.52.33
#${UE-Simulator}     172.24.52.36
#${DE_PASSWORD}    crypt:r49IEx4O8YNev8YyORhtJtljzi0/0P6dRuAYjeDSMElYeAv7L0DaUyxh4qWCwffjyRx5IsPGQzsIdiEY
#${website_name}    google.com


# IAD DE Site
#${master_username}   root
#${ABR-01}    172.24.37.16
#${ABR-02}    172.24.37.17
#${ABR-03}    172.24.37.18
#${ABR-04}    172.24.37.19
#${ABR-05}    172.24.37.40
#${ABR-06}    172.24.37.41
#${ABR-07}    172.24.37.42
#${ABR-08}    172.24.37.43
#${RSX-01}    172.24.37.51
#${RSX-02}    172.24.37.52
#${RSX-03}    172.24.37.53
#${RSX-04}    172.24.37.54
#${RSX-05}    172.24.37.55
#${RSX-06}    172.24.37.56
#${RSX-07}    172.24.37.57
#${RSX-08}    172.24.37.58
#${AAA-01}    172.24.37.34
#${AAA-02}    172.24.37.35
#${XEPA-01}    172.24.37.28
#${XEPA-02}    172.24.37.29
#${WCS-01}    172.24.36.35
#${WCS-02} 	 172.24.36.36
#${AAA-Simulator}    172.24.37.33
#${UE-Simulator}     172.24.37.36
#${DE_PASSWORD}    crypt:qJHOeBrm9+P2u861/0KAEVA9DioG0iVLn8yu1KTSo0YotfSJj8/QHV3yoQo/fEOOSzOcWgpAoHHq7zorTE8=
#${website_name}    google.com


# LAX DE Site
#${master_username}   root
#${ABR-01}    172.24.22.16
#${ABR-02}    172.24.22.17
#${ABR-03}    172.24.22.18
#${ABR-04}    172.24.22.19
#${ABR-05}    172.24.22.40
#${ABR-06}    172.24.22.41
#${ABR-07}    172.24.22.42
#${ABR-08}    172.24.22.43
#${RSX-01}    172.24.22.51
#${RSX-02}    172.24.22.52
#${RSX-03}    172.24.22.53
#${RSX-04}    172.24.22.54
#${RSX-05}    172.24.22.55
#${RSX-06}    172.24.22.56
#${RSX-07}    172.24.22.57
#${RSX-08}    172.24.22.58
#${AAA-01}    172.24.22.34
#${AAA-02}    172.24.22.35
#${XEPA-01}    172.24.22.28
#${XEPA-02}    172.24.22.29
#${WCS-01}    172.24.21.35
#${WCS-02} 	 172.24.21.36
#${AAA-Simulator}    172.24.22.33
#${UE-Simulator}     172.24.22.36
#${DE_PASSWORD}    crypt:QIugagYbPIpaoNK6O3cN0IDKRzfxhXwW07iLvgRlCmrMRl+t+Nw2ag6IxPeF6WLfBzvtxnxkyYwtbK86
#${website_name}    google.com


# LON DE Site
#${master_username}   root
#${ABR-01}    172.24.49.16
#${ABR-02}    172.24.49.17
#${ABR-03}    172.24.49.18
#${ABR-04}    172.24.49.19
#${RSX-01}    172.24.49.51
#${RSX-02}    172.24.49.52
#${RSX-03}    172.24.49.53
#${RSX-04}    172.24.49.54
#${AAA-01}    172.24.49.34
#${AAA-02}    172.24.49.35
#${XEPA-01}    172.24.49.28
#${XEPA-02}    172.24.49.29
#${WCS-01}    172.24.48.35
#${WCS-02} 	 172.24.48.35
#${AAA-Simulator}    172.24.49.33
#${UE-Simulator}     172.24.49.36
#${DE_PASSWORD}    crypt:B12ODPF9LNsmPuF0E476wds4Ag5a2cUeranfFHhTpnPIGgXYII3pyqvPcBXjfdTJOIPL1Zr4LmZRIoKL
#${website_name}    google.com


# MAD DE Site
#${master_username}   root
#${ABR-01}    172.24.34.16
#${ABR-02}    172.24.34.17
#${ABR-03}    172.24.34.18
#${ABR-04}    172.24.34.19
#${RSX-01}    172.24.34.51
#${RSX-02}    172.24.34.52
#${RSX-03}    172.24.34.53
#${RSX-04}    172.24.34.54
#${AAA-01}    172.24.34.34
#${AAA-02}    172.24.34.35
#${XEPA-01}    172.24.34.28
#${XEPA-02}    172.24.34.29
#${WCS-01}    172.24.33.35
#${WCS-02} 	 172.24.33.36
#${AAA-Simulator}    172.24.34.33
#${UE-Simulator}     172.24.34.36
#${DE_PASSWORD}    crypt:CABfS4AThJBJyFGOPvD4SdYXJL/4iIrHKNEWwnrD2GDtRUOHHteT65N8vAF/r8PMubd7OGHJS05bB4OW
#${website_name}    google.com


# MEL DE Site
#${master_username}   root
#${ABR-01}    172.24.46.16
#${ABR-02}    172.24.46.17
#${ABR-03}    172.24.46.18
#${ABR-04}    172.24.46.19
#${ABR-05}    172.24.46.40
#${ABR-06}    172.24.46.41
#${RSX-01}    172.24.46.51
#${RSX-02}    172.24.46.52
#${RSX-03}    172.24.46.53
#${RSX-04}    172.24.46.54
#${RSX-05}    172.24.46.55
#${RSX-06}    172.24.46.56
#${AAA-01}    172.24.46.34
#${AAA-02}    172.24.46.35
#${XEPA-01}    172.24.46.28
#${XEPA-02}    172.24.46.29
#${WCS-01}    172.24.45.35
#${WCS-02} 	 172.24.45.36
#${AAA-Simulator}    172.24.46.33
#${UE-Simulator}     172.24.46.36
#${DE_PASSWORD}    crypt:Uy6Vu6HfAsVP8tmM9D7vPJV5l2WEQ2HYCgigjagU8AG9WB8T+3y4ZsqHxUBPObig1yPCQtFCuVIXdK5q
#${website_name}    google.com



# ORD DE Site
#${master_username}   root
#${ABR-01}    172.24.31.16
#${ABR-02}    172.24.31.17
#${ABR-03}    172.24.31.18
#${ABR-04}    172.24.31.19
#${ABR-05}    172.24.31.40
#${ABR-06}    172.24.31.41
#${ABR-07}    172.24.31.42
#${ABR-08}    172.24.31.43
#${RSX-01}    172.24.31.51
#${RSX-02}    172.24.31.52
#${RSX-03}    172.24.31.53
#${RSX-04}    172.24.31.54
#${RSX-05}    172.24.31.55
#${RSX-06}    172.24.31.56
#${RSX-07}    172.24.31.57
#${RSX-08}    172.24.31.58
#${AAA-01}    172.24.31.34
#${AAA-02}    172.24.31.35
#${XEPA-01}    172.24.31.28
#${XEPA-02}    172.24.31.29
#${WCS-01}    172.24.30.35
#${WCS-02} 	 172.24.30.36
#${AAA-Simulator}    172.24.31.33
#${UE-Simulator}     172.24.31.36
#${DE_PASSWORD}    crypt:ELB+ASWbkhb9QPhp8q2cIwJFRRnN7ljkZ1x7EoO/P0jUk/LUcWhkvxL0NpH0d62O4DIHhyGnulsNhXWlonc=
#${website_name}    google.com


# PAR DE Site
#${master_username}   root
#${ABR-01}    172.24.61.16
#${ABR-02}    172.24.61.17
#${ABR-03}    172.24.61.18
#${ABR-04}    172.24.61.19
#${RSX-01}    172.24.61.51
#${RSX-02}    172.24.61.52
#${RSX-03}    172.24.61.53
#${RSX-04}    172.24.61.54
#${AAA-01}    172.24.61.34
#${AAA-02}    172.24.61.35
#${XEPA-01}    172.24.61.28
#${XEPA-02}    172.24.61.29
#${WCS-01}    172.24.60.35
#${WCS-02} 	 172.24.60.36
#${AAA-Simulator}    172.24.61.33
#${UE-Simulator}     172.24.61.36
#${DE_PASSWORD}    crypt:RdxigrAZZJaPFLMrQcogWLN5EAy/xRuyDpLEPj3lelIZb8uNkSUFh4ArFk/8kVBTldNKl0zbPxmytA9y
#${website_name}    google.com


# QRO DE Site
#${master_username}   root
#${ABR-01}    172.24.64.16
#${ABR-02}    172.24.64.17
#${ABR-03}    172.24.64.18
#${ABR-04}    172.24.64.19
#${RSX-01}    172.24.64.51
#${RSX-02}    172.24.64.52
#${RSX-03}    172.24.64.53
#${RSX-04}    172.24.64.54
#${AAA-01}    172.24.64.34
#${AAA-02}    172.24.64.35
#${XEPA-01}    172.24.64.28
#${XEPA-02}    172.24.64.29
#${WCS-01}    172.24.63.35
#${WCS-02} 	 172.24.63.36
#${AAA-Simulator}    172.24.64.33
#${UE-Simulator}     172.24.64.36
#${DE_PASSWORD}    crypt:eLbOt+KNo1bqZDcthf1aHwggrMeOXBxToSO95fTPyXHs6cQOFB7dT0wd5+7cPFyJry77LzjDPRvTNAHT
#${website_name}    google.com


# SYD DE Site
#${master_username}   root
#${ABR-01}    172.24.43.16
#${ABR-02}    172.24.43.17
#${ABR-03}    172.24.43.18
#${ABR-04}    172.24.43.19
#${ABR-05}    172.24.43.40
#${ABR-06}    172.24.43.41
#${RSX-01}    172.24.43.51
#${RSX-02}    172.24.43.52
#${RSX-03}    172.24.43.53
#${RSX-04}    172.24.43.54
#${RSX-05}    172.24.43.55
#${RSX-06}    172.24.43.56
#${AAA-01}    172.24.43.34
#${AAA-02}    172.24.43.35
#${XEPA-01}    172.24.43.28
#${XEPA-02}    172.24.43.29
#${WCS-01}    172.24.42.35
#${WCS-02} 	  172.24.42.36
#${AAA-Simulator}    172.24.43.33
#${UE-Simulator}     172.24.43.36
#${DE_PASSWORD}    crypt:IAyMrMdGpsS+XRXAUNP14HyjRdudXF569syJB8ZuLiyFqe1PkCD6jQF1n27A7U0+RbuWEzxP0D/aLtQU
#${website_name}    google.com


# TYO DE Site
#${master_username}   root
#${ABR-01}    172.24.58.16
#${ABR-02}    172.24.58.17
#${ABR-03}    172.24.58.18
#${ABR-04}    172.24.58.19
#${RSX-01}    172.24.58.51
#${RSX-02}    172.24.58.52
#${RSX-03}    172.24.58.53
#${RSX-04}    172.24.58.54
#${AAA-01}    172.24.58.34
#${AAA-02}    172.24.58.35
#${XEPA-01}    172.24.58.28
#${XEPA-02}    172.24.58.29
#${WCS-01}    172.24.57.35
#${WCS-02} 	 172.24.57.36
#${AAA-Simulator}    172.24.58.33
#${UE-Simulator}     172.24.58.36
#${DE_PASSWORD}    crypt:X1NNw3Lx12oscuhYnFtQVHy7hykdFHRpMcd+OtqX0RLlcv/qH+5hNIDiJDz7RYHY3ZryCLzbtdNb1qfz
#${website_name}    google.com


# YMQ DE Site
#${master_username}   root
#${ABR-01}    172.24.55.16
#${ABR-02}    172.24.55.17
#${ABR-03}    172.24.55.18
#${ABR-04}    172.24.55.19
#${RSX-01}    172.24.55.51
#${RSX-02}    172.24.55.52
#${RSX-03}    172.24.55.53
#${RSX-04}    172.24.55.54
#${AAA-01}    172.24.55.34
#${AAA-02}    172.24.55.35
#${XEPA-01}    172.24.55.28
#${XEPA-02}    172.24.55.29
#${WCS-01}    172.24.54.35
#${WCS-02} 	 172.24.54.36
#${AAA-Simulator}    172.24.55.33
#${UE-Simulator}     172.24.55.36
#${DE_PASSWORD}    crypt:TrE3a9KneQdKxdS/azkCzPVLQmtNVEprGZEACJ0WMWEprFnDU2/TwZ8tbEn5KgBcLS2e01xD9twbIS+G
#${website_name}    google.com
