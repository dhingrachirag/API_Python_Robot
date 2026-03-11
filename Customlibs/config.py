# MAINTAINER <Chirag Dhingra> <cdhingra@akamai.com>

# condition to send email if 'True' email will be sent
SEND_EMAIL = True

# email smtp (smpt of yahoo, gmail, msn, outlook etc.,)
SMPT = "Email-server"

# email subject
SUBJECT = "IpSec Gateway API Workflow"

# credentials
FROM = "chirag_dhingra_automation_mailer@akamai.com"
# PASSWORD = ""

# receivers
TO = ['dl-SRE-QA@akamai.com']
CC = ['asnagara@akamai.com', 'szalmijn@akamai.com', 'mmaurya@akamai.com',
      'sreqa-aaaahrsbtpuzpxvlg7czv5wlby@akamai.org.slack.com']

COMPANY_NAME = "IpSec Gateway API Workflow Status"
