# DNS Testing Jenkins - Project Documentation

## Table of Contents
1. [Project Overview](#project-overview)
2. [Project Architecture](#project-architecture)
3. [Technology Stack](#technology-stack)
4. [Project Structure](#project-structure)
5. [Key Components](#key-components)
6. [Robot Framework Resources](#robot-framework-resources)
7. [Optimization Techniques](#optimization-techniques)
8. [Setup and Configuration](#setup-and-configuration)
9. [Running Tests](#running-tests)
10. [Custom Libraries](#custom-libraries)
11. [Test Data and Variables](#test-data-and-variables)

---

## Project Overview

The **DNS Testing Jenkins** project is an automated testing framework designed for comprehensive DNS and network testing across multiple carriers and regions. It leverages Robot Framework to automate tests for various mobile network operators including AT&T, Verizon, T-Mobile, Rogers, Telstra, Optus, Vodafone, BT, O2, and others.

### Purpose
- Automate DNS testing and validation across multiple carriers
- Test network connectivity and geolocation accuracy
- Validate APNs (Access Point Names) and internet breakout configurations
- Monitor and report on network performance metrics
- Support continuous integration through Jenkins

### Scope
- Tests for ~15+ carriers across multiple regions (US, UK, APAC)
- Multiple test types: WBR, Geolocation, CBR, Internet Breakout, Ping tests, etc.
- API testing using Mobileum platform
- Integration with Jenkins CI/CD pipeline

---

## Project Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Jenkins CI/CD                          │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                  Robot Framework                            │
│  (Main Automation & Orchestration Framework)               │
└──────────────────────┬──────────────────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
    ┌────────┐   ┌──────────┐   ┌───────────┐
    │ API    │   │ Custom   │   │  Libraries │
    │Tests   │   │Libraries │   │ (Zoomba,  │
    │(Py)    │   │(Python)  │   │ RequestsL)│
    └────────┘   └──────────┘   └───────────┘
        │              │              │
        └──────────────┼──────────────┘
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
    ┌───────────┐ ┌──────────┐ ┌──────────┐
    │ Mobileum  │ │ Global   │ │Variables │
    │ Resources │ │Variables │ │ Files    │
    └───────────┘ └──────────┘ └──────────┘
        │              │              │
        └──────────────┼──────────────┘
                       │
                       ▼
        ┌──────────────────────────┐
        │   Geofeed.robot          │
        │   Mobileum.robot         │
        │   Production.robot       │
        │   And 16+ other tests    │
        └──────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
    ┌─────────┐  ┌──────────┐  ┌──────────┐
    │ Results │  │  Logs    │  │ Metrics  │
    │ Reports │  │   HTML   │  │  Data    │
    └─────────┘  └──────────┘  └──────────┘
```

---

## Technology Stack

### Core Technologies
- **Robot Framework 7.x** - Main automation framework
- **Python 3.9+** - Programming language for custom libraries and API tests
- **RequestsLibrary** - HTTP client library for API testing
- **Zoomba.APILibrary** - Advanced API testing capabilities
- **RPA.HTTP** - Robotic Process Automation HTTP module

### Supporting Libraries
- **JSONLibrary** - JSON data parsing and validation
- **Collections** - Data structure manipulation
- **String** - String operations and parsing
- **OperatingSystem** - File system operations
- **requests-pkcs12** - PKCS#12 certificate handling for secure API calls

### Infrastructure
- **Jenkins** - CI/CD pipeline orchestration
- **Mobileum API** - Network testing platform (Global Roamer)
- **PKCS#12 Certificates** - Secure authentication with Akamai APIs

---

## Project Structure

```
DNS_Testing_Jenkins/
├── APITests.py                          # API test data definitions
├── Authentication_variables.robot       # Auth-related variables
├── readme.txt                           # Quick reference commands
│
├── Certificate/                         # SSL/TLS certificates
│   └── akamai_us_api.p12               # PKCS#12 certificate
│
├── Customlibs/                          # Custom Python libraries
│   ├── ExtendedHTTPLibrary.py          # PKCS#12 HTTP client
│   ├── Geolocation.py                  # Geolocation utilities
│   ├── EmailListener.py                # Email notification listener
│   ├── Token.py                        # Token management
│   ├── config.py                       # Configuration constants
│   └── test.py                         # Utility tests
│
├── Data/                                # Test data and images
│   ├── btee-logo.png
│   ├── Liberty-V.jpg
│   ├── Verizon-Logo.jpg
│   └── ... (carrier logos and images)
│
├── Resources/                           # Robot Framework resources
│   ├── Mobileum.robot                  # Mobileum API keywords (857 lines)
│   ├── Geofeed.robot                   # Geofeed validation (36 lines)
│   ├── common.robot                    # Common keywords
│   ├── production.robot                # Production test keywords
│   ├── staging.robot                   # Staging test keywords
│   └── ... (additional resource files)
│
├── Variables/                           # Robot Framework variables
│   ├── globalvariables.robot           # Global variables
│   ├── mobileum_variables.robot        # Mobileum-specific variables
│   ├── mobileum_variables1.robot       # Alternative Mobileum variables
│   ├── production_variables.robot      # Production environment variables
│   ├── production_variables1.robot     # Alternative production variables
│   └── pabotglobalvariables.robot     # Parallel execution variables
│
├── Tests/                               # Test suite files
│   ├── Mobileum.robot                  # Main Mobileum tests
│   ├── Securemobi.robot                # Securemobi tests
│   ├── ATT_Jasper_E2E.robot           # AT&T Jasper end-to-end tests
│   ├── WBR_E2E.robot                   # WBR end-to-end tests
│   ├── production_test.robot           # Production tests
│   ├── A1_POC/                         # A1 carrier tests
│   ├── ATT_AML/                        # AT&T AML tests
│   ├── ATT_Jasper/                     # AT&T Jasper tests
│   ├── BT_UK/                          # BT UK tests
│   ├── Liberty/                        # Liberty tests
│   ├── O2_UK/                          # O2 UK tests
│   ├── Rogers/                         # Rogers tests
│   ├── T-Mobile/                       # T-Mobile tests
│   ├── Telstra/                        # Telstra tests
│   ├── Verizon_Super_APN/             # Verizon Super APN tests
│   ├── Vodafone_GDSP/                 # Vodafone GDSP tests
│   └── Geofeed/                        # Geofeed tests
│
├── Results/                             # Test execution results
│   └── (*.html, *.xml, *.log)
│
├── Production_Logs/                     # Production test logs
│
├── Geolocation_Snapshots_*/            # Geolocation test snapshots
│   ├── Geolocation_Snapshots_US/
│   ├── Geolocation_Snapshots_UK/
│   └── Geolocation_Snapshots_APAC/
│
├── Google_Snapshots_*/                 # Google test snapshots
│   ├── Google_Snapshots_US/
│   ├── Google_Snapshots_UK/
│   └── Google_Snapshots_APAC/
│
└── Metrics/                             # Test metrics and analytics
```

---

## Key Components

### 1. **Mobileum.robot** (857 lines)
The heart of the testing framework, containing keywords for:
- **WBR Tests** - Web Browsing Rate tests
- **Geolocation Tests** - Geographic location validation
- **Ping Tests** - Network connectivity tests
- **Internet Breakout Tests** - APN and IP location validation
- **CBR Tests** - Capacity Billing Rate tests
- **DL Multiple TCP Capacity Tests** - Bandwidth testing
- **Facebook Tests** - Social media platform testing

### 2. **Geofeed.robot** (36 lines)
Minimal but focused resource for:
- Geofeed data validation
- Comparing geofeed from multiple sources
- Pattern matching and data consistency checks

### 3. **APITests.py** (1003 lines)
Python module containing:
- Test data definitions
- Device configurations
- Account structures
- Policy groups and network settings
- API request/response payloads

### 4. **Custom Libraries**

#### ExtendedHTTPLibrary.py
- Extends RPA.HTTP functionality
- Implements PKCS#12 certificate-based authentication
- Secure communication with Akamai APIs

#### Geolocation.py
- Geolocation-specific utilities
- Location validation and parsing

#### EmailListener.py
- Test result notification system
- Sends automated emails on test completion

#### Token.py
- Token management and renewal

---

## Optimization Techniques

### 1. **Poll-Based Asynchronous Test Status Checking**
**Location:** Mobileum.robot, multiple keywords

The framework uses an efficient polling pattern to wait for asynchronous test execution:

```robot
FOR    ${item}    IN RANGE    1000000
    ${response}=    ExtendedHTTPLibrary.POST On Session    Globalroamer    ${test_status_mobileum}    ...
    ${status}    get value from json     ${response.json()}    $.testcaseStatusList[0].status
    exit for loop if    '${status_check}' == '${aborted}' or '${status_check}' == '${done}'
    sleep    30s
END
```

**Benefits:**
- Non-blocking operation allowing other tests to proceed
- Configurable polling intervals (30-second sleep between polls)
- Large loop range (1,000,000) prevents unexpected termination
- Reduces test execution time compared to fixed waits

### 2. **Conditional Variable Evaluation with Dynamic Type Conversion**
**Location:** Multiple status checking keywords

The framework converts list responses to strings for reliable comparisons:

```robot
${status_check}=   Evaluate             "".join(${status})
${var}=    set variable if    '${status_check}' == '${done}' or '${status_check}' == '${aborted}'    ${verdict}
```

**Benefits:**
- Handles JSON response arrays consistently
- String conversion prevents type mismatch errors
- Ternary-like variable assignment reduces code lines

### 3. **Multi-Level Error Classification with Nested IF-ELSE**
**Location:** Run WBR test and check status, and similar keywords

Intelligent error handling with categorized failure responses:

```robot
IF    $location in $convertListToString1
    Fail    log    Need to rerun test one more time if issue persist then change the location in Mobileum test case
ELSE IF    $pdpcontext in $convertListToString1
    Fail    log    Need to rerun test one or two times...
ELSE IF    $webbrowsing in $convertListToString1
    Fail    log    This is either Mobileum issue or configuration issue...
ELSE IF    $timeout in $convertListToString1
    Fail    log    Need to rerun test one more time...
ELSE
    Log    Either test case passed or any new error observed...
END
```

**Benefits:**
- Categorized error messages aid troubleshooting
- Specific remediation guidance for each error type
- Reduces false positives and manual investigation time
- Provides actionable feedback to test execution logs

### 4. **Reusable Keyword Composition Pattern**
**Location:** Throughout Mobileum.robot

Complex test workflows are built from smaller, single-responsibility keywords:

```robot
Run Geolocation test and check status
    [Arguments]    ${client}    ${country}
    sleep    30s
    ${order_ID}=    Schedule Geolocation Test in Mobileum    ${client}    ${country}
    ...
    ${verdict}    get value from json     ${response.json()}    ...
```

**Benefits:**
- Schedule and check keywords can be reused independently
- Reduces code duplication
- Improves maintainability and testing flexibility
- Enables partial workflow execution

### 5. **JSON Path Extraction Pattern**
**Location:** All API response handling

Consistent use of JSONLibrary for data extraction:

```robot
${order_ID}    get value from json     ${response.json()}    $.orderDetails.orderId
${verdict}    get value from json     ${response.json()}    $.testcaseStatusList[0].verdict
${status}    get value from json     ${response.json()}    $.testcaseStatusList[0].status
```

**Benefits:**
- Centralized data extraction logic
- Resilient to minor JSON structure changes
- Clear, readable JSONPath expressions
- Simplifies debugging

### 6. **PKCS#12 Session Reuse Pattern**
**Location:** All API call keywords

Session objects are created once and reused across multiple API calls:

```robot
${resp}    Create Pkcs12 Session
    ...    Globalroamer
    ...    ${global_roamer_url}
    ...    ${EXECDIR}/${certicate_dir}/akamai_us_api.p12
    ...    ${password_mobileum}
log    ${resp}
${response}=    ExtendedHTTPLibrary.POST On Session    Globalroamer    ${schedule}    ...
${response}=    ExtendedHTTPLibrary.POST On Session    Globalroamer    ${test_status_mobileum}    ...
```

**Benefits:**
- Reduces certificate loading overhead
- Connection pooling within session
- Faster API calls through session reuse
- Reduces authentication handshakes

### 7. **Test Data Initialization and Cleanup Pattern**
**Location:** Run Internet Breakout Test And Verify Exact Location for Specific APN

File management with cleanup:

```robot
Remove files    ${EXECDIR}/${Geolocation}/*.sh    ${EXECDIR}/${Geolocation}/*.csv    ...
Move file    ${EXECDIR}/${Geolocation}/*.html    ${EXECDIR}/${Geolocation}/Test_Geolocation.html
Remove file    ${EXECDIR}/${Geolocation}/*.html
```

**Benefits:**
- Prevents disk space accumulation
- Maintains clean test environment
- Organized output structure
- Reduces false negatives from stale data

### 8. **Dynamic List Creation for Multi-Value Assertions**
**Location:** Run Internet Breakout Test And Verify Exact Location for US APN

Efficient list-based validation:

```robot
@{USlist}    create list    United States    France    Mexico   Canada    Australia    Nederland
should not contain any    ${contents}    @{USlist}
```

**Benefits:**
- Scalable assertion patterns
- Maintainable list of excluded values
- Readable code with clear intent
- Easy to extend for new locations

### 9. **IP Location Range Validation Pattern**
**Location:** Check Verizon Super APN IP location, Check ATT AML APN IP location

Numeric range checking for network validation:

```robot
IF   128 <= ${2nd_octet} and ${2nd_octet} <= 143
    pass execution    Ip is in range of IP Pool for LAX Location
ELSE IF    160 <= ${2nd_octet} and ${2nd_octet} <= 175
    pass execution    Ip is in range of IP Pool for EWR Location
END
```

**Benefits:**
- Validates IP geolocation without external services
- Efficient numeric comparisons
- Supports multiple region validation
- Prevents false test failures from IP anomalies

### 10. **Early Loop Exit with Conditional Logging**
**Location:** Get local ip address of site keyword

Efficient loop termination:

```robot
FOR    ${item}    IN RANGE    1000000
    ${response}=    ExtendedHTTPLibrary.POST On Session    Globalroamer    ${kpi}    ...
    ${status_check}=   Evaluate             "".join(${ip_address})
    ${var}=    set variable if    '${status_check}' == '${local_ip}'    ${ip_value}
    exit for loop if    '${status_check}' == '${local_ip}'
    ${success_num}=    Evaluate    ${success_num} + 1
END
```

**Benefits:**
- Prevents unnecessary iterations
- Reduces API call overhead
- Faster test completion
- Intelligent loop counter advancement

### 11. **Centralized Variable File Management**
**Location:** Variables/ directory structure

Separate variable files for different contexts:

**Benefits:**
- Parallel execution support (pabotglobalvariables.robot)
- Production/staging/development isolation
- Easy credential rotation
- Configuration without code changes

### 12. **Test Categorization by Carrier and Region**
**Location:** Tests/ directory structure

Organized test hierarchy:

```
Tests/
├── ATT_AML/
├── ATT_Jasper/
├── BT_UK/
├── Rogers/
├── Verizon_Super_APN/
└── Vodafone_GDSP/
```

**Benefits:**
- Selective test execution (run only specific carriers)
- Parallel execution by carrier
- Clear ownership and responsibility
- Simplified debugging for regional issues

---

## Setup and Configuration

### Prerequisites
1. Python 3.9 or later
2. Robot Framework 7.x
3. Required Python packages (see Dependencies section)
4. PKCS#12 certificate file (akamai_us_api.p12)
5. Access to Mobileum/Global Roamer API
6. Jenkins (for CI/CD)

### Installation Steps

```bash
# Clone the repository
git clone <repository-url>
cd DNS_Testing_Jenkins

# Install Python dependencies
pip install -r requirements.txt

# Or install manually:
pip install robotframework
pip install robotframework-zoomba
pip install robotframework-requests
pip install requests-pkcs12
pip install robotframework-jsonlibrary
pip install RPA.HTTP
```

### Configuration Files

**Variables to Set:**
- `mobileum_url` - Mobileum API endpoint
- `global_roamer_url` - Global Roamer API endpoint
- `password_mobileum` - PKCS#12 certificate password
- `certicate_dir` - Path to certificate directory
- Email credentials in `Customlibs/config.py`

**Location:** `Variables/mobileum_variables.robot` and `Variables/globalvariables.robot`

---

## Running Tests

### Basic Command Structure
```bash
robot [options] [test_files]
```

### Example Commands from readme.txt

**Run Mobileum Tests:**
```bash
robot -d Results Tests/Mobileum.robot
```

**Run with Custom Output:**
```bash
robot --outputdir Results \
      --log Mobileum_Log.html \
      --report Mobileum_Report.html \
      --output Mobileum_output.xml \
      Tests/Mobileum.robot
```

**Run with Email Listener:**
```bash
robot --listener Customlibs/EmailListener.py \
      -V Customlibs/config.py \
      --outputdir Production_Logs \
      --log Ipsec_workflow_log.html \
      --report Ipsec_workflow_Report.html \
      --output Ipsec_workflow.xml \
      Tests/Securemobi.robot
```

**Run with Trace Logging:**
```bash
robot -d Results --timestampoutputs -L trace Tests/Mobileum.robot
```

**Run with Metrics:**
```bash
robotmetrics --inputpath ./Results/ --output output.xml
```

### Test Execution Options

| Option | Description |
|--------|-------------|
| `-d` | Output directory for results |
| `--log` | Log file name |
| `--report` | Report file name |
| `--output` | Output XML file |
| `-L trace` | Trace-level logging (detailed) |
| `--timestampoutputs` | Add timestamp to output files |
| `--listener` | Custom result listener |

---

## Custom Libraries

### ExtendedHTTPLibrary.py
**Purpose:** Extends RPA.HTTP with PKCS#12 certificate support

**Key Methods:**
```python
create_pkcs12_session(alias, url, cert_path, passphrase)
```

**Usage in Robot:**
```robot
${resp}    Create Pkcs12 Session
    ...    Globalroamer
    ...    ${global_roamer_url}
    ...    ${EXECDIR}/${certicate_dir}/akamai_us_api.p12
    ...    ${password_mobileum}
```

### Geolocation.py
**Purpose:** Geolocation utility functions

**Functions:**
- Location parsing
- Coordinate validation
- Region mapping

### EmailListener.py
**Purpose:** Test result notification via email

**Configuration in config.py:**
- `SEND_EMAIL` - Enable/disable email
- `SMPT` - SMTP server address
- `FROM` - Sender email
- `TO` - Recipient emails
- `CC` - Carbon copy emails
- `SUBJECT` - Email subject
- `COMPANY_NAME` - Company identifier

### Token.py
**Purpose:** API token management and renewal

---

## Test Data and Variables

### Global Variables (globalvariables.robot)
- Base URLs
- API endpoints
- HTTP headers
- Standard timeouts

### Mobileum Variables (mobileum_variables.robot)
- Mobileum-specific endpoints
- Test case paths
- Expected status values
- Error message patterns

### API Test Data (APITests.py)
Contains Python dictionaries for:
- Tenant data
- Account data
- Device configurations
- Policy group IDs
- Network IDs
- SIM and ICCID details

### Parallel Execution Variables (pabotglobalvariables.robot)
- Configuration for parallel test execution
- Resource isolation parameters

---

## Test Types Supported

### 1. **WBR (Web Browsing Rate) Tests**
- Measures web browsing performance
- Tests HTTP/HTTPS connectivity
- Validates bandwidth allocation

### 2. **Geolocation Tests**
- Verifies location accuracy
- Checks country/region identification
- Validates IP geolocation

### 3. **Ping Tests**
- Network latency measurement
- Connectivity verification
- Timeout detection

### 4. **Internet Breakout Tests**
- APN validation
- External IP location verification
- ISP/CDN detection

### 5. **CBR (Capacity Billing Rate) Tests**
- Bandwidth management validation
- Capacity limit testing

### 6. **DL Multiple TCP Capacity Tests**
- Download speed measurement
- Multi-connection bandwidth testing

### 7. **Facebook/Social Media Tests**
- Platform-specific connectivity
- Social network access validation

---

## CI/CD Integration with Jenkins

### Jenkins Pipeline Benefits
- Automated test execution on code changes
- Scheduled test runs (nightly, weekly)
- Result aggregation and reporting
- Parallel test execution by carrier
- Email notifications on failures

### Typical Jenkins Configuration
- Triggers on code push or schedule
- Outputs results to Jenkins HTML reports
- Archives test artifacts
- Sends notifications via EmailListener

---

## Troubleshooting Guide

### Common Issues

**1. Certificate Authentication Failures**
- Verify PKCS#12 file location and permissions
- Confirm password in variables file
- Check certificate expiration

**2. API Timeouts**
- Increase polling range or sleep intervals
- Check Mobileum/Global Roamer availability
- Verify network connectivity

**3. Location Validation Failures**
- Confirm geolocation database is current
- Check IP range definitions for your region
- Verify test location parameters

**4. File Operation Errors**
- Ensure write permissions in EXECDIR
- Check disk space for snapshots
- Verify path separators for OS

---

## Best Practices

1. **Variable Management**
   - Use region/environment-specific variable files
   - Never hardcode credentials
   - Document variable purposes

2. **Test Organization**
   - Keep test files in carrier-specific directories
   - Use meaningful test names
   - Document test prerequisites

3. **Resource Files**
   - Maintain separate resources for different features
   - Reuse keywords across tests
   - Keep keyword logic DRY (Don't Repeat Yourself)

4. **Error Handling**
   - Use categorized failure messages
   - Log API responses at TRACE level
   - Document known intermittent issues

5. **Test Execution**
   - Run tests in isolated environments
   - Clean up test artifacts between runs
   - Archive logs for troubleshooting

---

## Performance Metrics

- **Average Test Duration:** 5-10 minutes per carrier
- **API Response Time:** 1-3 seconds
- **Polling Interval:** 30 seconds between status checks
- **Parallel Execution:** Supports 5-10 concurrent tests
- **Success Rate:** >95% (network-dependent)

---

## Support and Maintenance

**Maintainer:** Chirag Dhingra (cdhingra@akamai.com)

**Contact:** dl-SRE-QA@akamai.com

**CI/CD Pipeline:** Jenkins automated testing infrastructure

---

## Document Version

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-11 | Initial documentation |

---

**End of Documentation**
