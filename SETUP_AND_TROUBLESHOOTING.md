# Setup and Troubleshooting Guide

## Quick Start Guide

### Prerequisites Checklist

- [ ] Python 3.9+
- [ ] Git (for repository cloning)
- [ ] pip package manager
- [ ] PKCS#12 certificate file (akamai_us_api.p12)
- [ ] Access to Mobileum/Global Roamer API
- [ ] Jenkins account (for CI/CD)

### Installation Steps

#### 1. Clone the Repository

```bash
git clone <repository-url>
cd DNS_Testing_Jenkins
```

#### 2. Create Virtual Environment (Recommended)

```bash
python -m venv venv
source venv/bin/activate  # On macOS/Linux
# or
venv\Scripts\activate  # On Windows
```

#### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

Or manually install:

```bash
pip install robotframework==7.x
pip install robotframework-zoomba
pip install robotframework-requests
pip install requests-pkcs12
pip install robotframework-jsonlibrary
pip install RPA.HTTP
pip install requests
```

#### 4. Configure Certificates

1. Place `akamai_us_api.p12` in `Certificate/` directory
2. Note the password (for Variables/mobileum_variables.robot)

#### 5. Set Environment Variables

Create a `.env` file in project root:

```bash
# Mobileum API
MOBILEUM_URL=https://api.globalroamer.com
MOBILEUM_PASSWORD=<your-certificate-password>
MOBILEUM_USERNAME=<your-akamai-username>

# Email Configuration
SMTP_SERVER=email.msg.corp.akamai.com:25
FROM_EMAIL=chirag_dhingra_automation_mailer@akamai.com
TO_EMAIL=dl-SRE-QA@akamai.com
```

#### 6. Update Variables Files

**File:** `Variables/globalvariables.robot`

```robot
*** Variables ***
${mobileum_url}           https://api.globalroamer.com
${global_roamer_url}      https://api.globalroamer.com
${geofeed_url}            <your-geofeed-endpoint>
${certicate_dir}          Certificate
${password_mobileum}      <certificate-password>
```

**File:** `Variables/mobileum_variables.robot`

```robot
*** Variables ***
${testcases_path}         /Customers/Akamai_US/akamai_us_api
${accept}                 application/json
${aster}                  */*
${host}                   api.globalroamer.com
${keep-alive}             keep-alive
${user_agent}             Mozilla/5.0
${enconding}              gzip, deflate, br
```

---

## Running Your First Test

### Simple Test Run

```bash
# Run a single test file
robot -d Results Tests/Mobileum.robot

# Run with timestamps
robot -d Results --timestampoutputs Tests/Mobileum.robot

# Run with custom logging
robot -d Results \
      --log Mobileum_Log.html \
      --report Mobileum_Report.html \
      Tests/Mobileum.robot
```

### View Results

After execution, open the HTML reports:

```bash
# Open in default browser
open Results/Mobileum_Log.html      # macOS
xdg-open Results/Mobileum_Log.html  # Linux
start Results\Mobileum_Log.html     # Windows
```

### Run Specific Carrier Tests

```bash
# AT&T Jasper tests
robot -d Results Tests/ATT_Jasper_E2E.robot

# Verizon Super APN
robot -d Results Tests/Verizon_Super_APN/*.robot

# Multiple carriers in sequence
robot -d Results Tests/Rogers/ Tests/T-Mobile/ Tests/Telstra/
```

---

## Common Issues and Solutions

### Issue 1: Certificate Authentication Failure

**Error:**
```
SSLError: [SSL: TLSV1_ALERT_UNKNOWN_CA] tlsv1 alert unknown ca
```

**Solutions:**

a) **Verify Certificate Path**
```bash
ls -la Certificate/akamai_us_api.p12
# Should exist and be readable
```

b) **Check Certificate Password**
- Confirm password in Variables/mobileum_variables.robot
- Passwords are case-sensitive
- Try with quotes: `password_mobileum    "${PASSWORD}"`

c) **Verify Certificate Validity**
```bash
# Check expiration date
openssl pkcs12 -in Certificate/akamai_us_api.p12 -noout -info
```

d) **Test Certificate Loading**
```python
from requests_pkcs12 import Pkcs12Adapter
import requests

session = requests.Session()
try:
    adapter = Pkcs12Adapter(
        pkcs12_filename='Certificate/akamai_us_api.p12',
        pkcs12_password='your_password'
    )
    session.mount('https://', adapter)
    print("Certificate loaded successfully")
except Exception as e:
    print(f"Error: {e}")
```

---

### Issue 2: Connection Timeout to Mobileum API

**Error:**
```
requests.exceptions.ConnectionError: 
  Failed to establish a new connection: [Errno 110] Connection timed out
```

**Solutions:**

a) **Check Network Connectivity**
```bash
ping api.globalroamer.com
curl -v https://api.globalroamer.com
```

b) **Verify VPN Connection**
- Ensure VPN is connected (if required)
- Check VPN credentials and connectivity

c) **Check Firewall Rules**
```bash
# macOS/Linux
sudo lsof -i :443  # Check if port 443 is open

# Test with different timeout
robot --variable TIMEOUT:60s Tests/Mobileum.robot
```

d) **Update URL in Variables**
- Confirm `global_roamer_url` is correct
- Check for typos or protocol (https, not http)

---

### Issue 3: JSON Parsing Error

**Error:**
```
JSONParseError: Expecting value: line 1 column 1 (char 0)
```

**Solutions:**

a) **Verify API Response**
```robot
Log    ${response}    level=TRACE
Log    ${response.text}
Log    ${response.status_code}
```

b) **Check Content-Type Header**
```robot
${headers}=    Create Dictionary    Content-Type=application/json
# Add to all POST requests
```

c) **Validate JSON Path**
```robot
# Use Try Except to handle missing paths
${verdict}    get value from json    ${response.json()}    $.testcaseStatusList[0].verdict
Should Not Be Empty    ${verdict}    msg=Verdict not found in response
```

d) **Common Response Structure Issues**
- API might return error response (status 4xx/5xx)
- JSON structure might differ (typo in path)
- Response might be empty

---

### Issue 4: Test Hangs/Timeout

**Error:**
```
Test execution timed out after X seconds
```

**Solutions:**

a) **Increase Polling Timeout**
```robot
Set Test Timeout    3600s    # 1 hour instead of default 3 minutes
```

b) **Check Mobileum Test Status**
- Login to Mobileum web interface
- Check if test is running or stuck

c) **Reduce Polling Interval (Use Caution)**
```robot
# Current: sleep 30s
# Reduces API call load
# Can increase to 60s for long-running tests
FOR    ${item}    IN RANGE    1000000
    ${response}=    ExtendedHTTPLibrary.POST On Session    ...
    sleep    60s    # Increased from 30s
    exit for loop if    '${status_check}' == '${done}' or '${status_check}' == '${aborted}'
END
```

d) **Check for Stuck Tests**
```bash
# Search for "RUNNING" status in logs
grep -i "running\|pending" Results/*.log
```

---

### Issue 5: File Not Found Errors

**Error:**
```
OperatingSystem: Directory/file does not exist
```

**Solutions:**

a) **Verify Working Directory**
```bash
# Robot uses EXECDIR as current directory
robot -d Results Tests/Mobileum.robot  # EXECDIR = project root

# Check in test
Log    ${EXECDIR}    # Print current directory
```

b) **Use Absolute Paths**
```robot
${cert_path}=    Evaluate    os.path.abspath('${EXECDIR}/${certicate_dir}/akamai_us_api.p12')
```

c) **Create Required Directories**
```bash
mkdir -p Results
mkdir -p Production_Logs
mkdir -p Geolocation_Snapshots_US
```

d) **Check File Permissions**
```bash
# macOS/Linux
ls -la Certificate/akamai_us_api.p12
chmod 600 Certificate/akamai_us_api.p12  # Restrict permissions
```

---

### Issue 6: Email Notification Not Sending

**Error:**
```
SMTPAuthenticationError: (535, b'5.7.8 Error: ...')
```

**Solutions:**

a) **Verify Email Configuration**

File: `Customlibs/config.py`

```python
SEND_EMAIL = True  # Must be True
SMPT = "email.msg.corp.akamai.com:25"
FROM = "chirag_dhingra_automation_mailer@akamai.com"
TO = ['dl-SRE-QA@akamai.com']
```

b) **Test SMTP Connection**
```python
import smtplib

try:
    server = smtplib.SMTP("email.msg.corp.akamai.com", 25)
    server.starttls()
    print("SMTP connection successful")
    server.quit()
except Exception as e:
    print(f"SMTP Error: {e}")
```

c) **Enable Email Listener in Jenkins**
```bash
robot --listener Customlibs/EmailListener.py \
      -V Customlibs/config.py \
      Tests/Mobileum.robot
```

d) **Check Email Logs**
```bash
# Search for email-related messages
grep -i "email\|send\|smtp" Results/*.log
```

---

### Issue 7: Variable Not Defined

**Error:**
```
Variable '${variable_name}' not found
```

**Solutions:**

a) **Check Variable File Imports**

Ensure variables are imported in Robot test:

```robot
*** Settings ***
Resource    ../Variables/globalvariables.robot
Resource    ../Variables/mobileum_variables.robot
```

b) **Check Variable Scope**
```robot
# Set Test Variable for local scope
Set Test Variable    ${success_num}    ${0}

# Set Suite Variable for suite scope
Set Suite Variable    ${test_data}    some_value

# Set Global Variable for global scope
Set Global Variable    &{headers2}    Accept=application/json
```

c) **Verify Variable Format**
```robot
# Should use ${} for scalars
${variable_name}    Set Variable    value

# Should use &{} for dictionaries
&{dictionary}    Create Dictionary    key1=value1    key2=value2

# Should use @{} for lists
@{list}    Create List    item1    item2
```

d) **Print All Variables**
```bash
# Enable debug mode
robot -d Results --dryrun Tests/Mobileum.robot

# Or in test
Log Variables    # Prints all variables in current scope
```

---

### Issue 8: Assertion Failures - "Should Be Equal" Mismatch

**Error:**
```
AssertionError: 'FAILED' != 'PASS'
```

**Solutions:**

a) **Check Status Variable Conversion**
```robot
# Debug status comparison
${status}    get value from json    ${response.json()}    $.testcaseStatusList[0].status
Log    Status type: ${status.__class__.__name__}    # Check type
Log    Status value: ${status}    # Check value
${status_check}=    Evaluate    "".join(${status})    # Convert to string
Log    Status after conversion: ${status_check}
```

b) **Verify Expected Status Values**
```robot
# Should match constants from Variables
Log    Expected: ${done}    # Should be 'DONE'
Log    Expected: ${passed_state}    # Should be 'PASS'
```

c) **Handle Variable Types**
```robot
# Safe comparison
${status_str}=    Convert To String    ${status}[0]
Should Be Equal    ${status_str}    DONE
```

---

## Configuration Best Practices

### 1. Separate Configuration by Environment

```
Variables/
├── globalvariables.robot        # Shared across all
├── mobileum_variables.robot     # Production Mobileum endpoints
├── mobileum_variables1.robot    # Alternative/staging endpoints
├── production_variables.robot   # Production network configs
└── production_variables1.robot  # Backup configs
```

**Usage:**
```bash
# Production
robot -V Variables/mobileum_variables.robot Tests/Mobileum.robot

# Staging (if needed)
robot -V Variables/mobileum_variables1.robot Tests/Mobileum.robot
```

### 2. Secure Credential Management

**Don't:**
```robot
${password}    Set Variable    actual_password_here  # EXPOSED!
```

**Do:**
```bash
# Set environment variable
export MOBILEUM_PASSWORD="your_password"

# Reference in Robot
${password}    Get Environment Variable    MOBILEUM_PASSWORD
```

### 3. Use Profiles for Different Scenarios

Create separate test profiles:

```bash
# Development
robot -d Results --loglevel DEBUG Tests/

# Staging  
robot -d Results --loglevel INFO Tests/

# Production
robot -d Results --loglevel WARN Tests/
```

---

## Performance Tuning

### 1. Optimize Poll Intervals

Current: 30 seconds between status checks

**For faster tests:**
```robot
sleep    15s    # More frequent checks
```

**For slower tests:**
```robot
sleep    60s    # Less API load
```

### 2. Enable Parallel Execution

```bash
pip install robotframework-pabot

pabot --processes 4 \
      -d Results \
      Tests/
```

### 3. Monitor Resource Usage

```bash
# macOS
top -l 1 | grep -E "Processes|PhysMem|CPU"

# Linux
free -h && ps aux --sort=-%mem | head -10
```

---

## Debugging Tips

### 1. Run with Trace Logging

```bash
robot -L trace -d Results Tests/Mobileum.robot
```

**Output:** Very detailed logs with every variable assignment

### 2. Use Breakpoints

```robot
Debug    # Pauses execution, allows interactive inspection
```

### 3. Dry Run Mode

```bash
robot --dryrun -d Results Tests/Mobileum.robot
```

**Output:** Shows test structure without execution

### 4. Variable Inspection

```robot
Log Variables    # Print all variables
Log    ${variable}    # Print single variable
Log    ${variable}    level=TRACE    # Debug-level output
```

### 5. Create Custom Test Log

```python
# In Customlibs/logging_helper.py
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

handler = logging.FileHandler('custom.log')
handler.setLevel(logging.DEBUG)

formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
```

---

## Maintenance Tasks

### Weekly

- [ ] Review test result summaries
- [ ] Check email notifications for failures
- [ ] Monitor average test execution time

### Monthly

- [ ] Verify all carrier test suites pass
- [ ] Check disk usage on Jenkins server
- [ ] Review and archive old test results
- [ ] Update API endpoint URLs if changed

### Quarterly

- [ ] Review certificate expiration (renew if needed)
- [ ] Update dependencies to latest versions
- [ ] Perform performance baseline testing
- [ ] Document any new test scenarios

---

## Support Contacts

| Role | Name | Email |
|------|------|-------|
| QA Lead | Chirag Dhingra | cdhingra@akamai.com |
| QA Team | | dl-SRE-QA@akamai.com |
| Slack Channel | #qa-automation | sreqa-aaaahrsbtpuzpxvlg7czv5wlby@akamai.org.slack.com |

---

## Additional Resources

- [Robot Framework Documentation](https://robotframework.org)
- [RequestsLibrary Documentation](https://github.com/MarketSquare/robotframework-requests)
- [Zoomba Library Documentation](https://github.com/Accellere/Zoomba)
- [Mobileum API Documentation](https://www.mobileum.com/api-docs)
- [PKCS#12 Certificate Guide](https://en.wikipedia.org/wiki/PKCS_12)

---

**Document Version:** 1.0  
**Last Updated:** 2026-02-11
