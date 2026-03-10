# Quick Reference Card

## 🚀 Common Commands

### Running Tests

```bash
# Basic run
robot -d Results Tests/Mobileum.robot

# With custom naming
robot -d Results \
      --log Mobileum_Log.html \
      --report Mobileum_Report.html \
      Tests/Mobileum.robot

# Specific carrier
robot -d Results Tests/Verizon_Super_APN/*.robot

# Multiple carriers
robot -d Results Tests/Rogers/ Tests/T-Mobile/ Tests/Telstra/

# With trace logging
robot -L trace -d Results Tests/Mobileum.robot

# Dry run (no execution)
robot --dryrun -d Results Tests/Mobileum.robot

# Parallel execution
pabot --processes 4 -d Results Tests/
```

---

## 📋 Test File Locations

### By Carrier

| Carrier | Location | Command |
|---------|----------|---------|
| AT&T Jasper | `Tests/ATT_Jasper/` | `robot -d Results Tests/ATT_Jasper/*.robot` |
| AT&T AML | `Tests/ATT_AML/` | `robot -d Results Tests/ATT_AML/*.robot` |
| Verizon | `Tests/Verizon_Super_APN/` | `robot -d Results Tests/Verizon_Super_APN/*.robot` |
| T-Mobile | `Tests/TMobile/` | `robot -d Results Tests/TMobile/*.robot` |
| Rogers | `Tests/Rogers/` | `robot -d Results Tests/Rogers/*.robot` |
| Telstra | `Tests/Telstra/` | `robot -d Results Tests/Telstra/*.robot` |
| Optus | `Tests/Optus_*/` | `robot -d Results Tests/Optus_*/*.robot` |
| BT UK | `Tests/BT_UK/` | `robot -d Results Tests/BT_UK/*.robot` |
| O2 UK | `Tests/O2_UK/` | `robot -d Results Tests/O2_UK/*.robot` |
| Vodafone | `Tests/Vodafone_*/` | `robot -d Results Tests/Vodafone_*/*.robot` |

---

## 📚 Resource Files

| Resource | Purpose | Use When |
|----------|---------|----------|
| `Mobileum.robot` | All Mobileum test keywords | Writing Mobileum tests |
| `Geofeed.robot` | Geofeed validation | Validating geofeed data |
| `common.robot` | Shared keywords | Building cross-carrier tests |
| `production.robot` | Production test keywords | Production environment tests |
| `staging.robot` | Staging test keywords | Staging environment tests |

---

## 🔧 Configuration Files

| File | Purpose | Edit When |
|------|---------|-----------|
| `Variables/globalvariables.robot` | Global settings | Base URLs, API endpoints change |
| `Variables/mobileum_variables.robot` | Mobileum settings | Test paths, status values change |
| `Variables/production_variables.robot` | Production config | Production environment changes |
| `Customlibs/config.py` | Email settings | Email recipients or SMTP server changes |

---

## ⚙️ Variable Reference

### Global Variables
```robot
${mobileum_url}           # Mobileum API base URL
${global_roamer_url}      # Global Roamer API URL
${geofeed_url}            # Geofeed endpoint
${certicate_dir}          # Path to certificates
${password_mobileum}      # Certificate password
```

### Common Headers
```robot
${accept}                 # application/json
${aster}                  # */*
${host}                   # api.globalroamer.com
${user_agent}             # Mozilla/5.0
${enconding}              # gzip, deflate, br
```

### Expected Values
```robot
${done}                   # DONE
${aborted}                # ABORTED
${passed_state}           # PASS
${location}               # location (error keyword)
${pdpcontext}             # pdpContext (error keyword)
${webbrowsing}            # webbrowsing (error keyword)
${timeout}                # timeout (error keyword)
```

---

## 🔑 Keyword Cheat Sheet

### Schedule Keywords (Return Order ID)
```robot
Schedule WBR Test in Mobileum                    ${customer}  ${country}
Schedule Geolocation Test in Mobileum            ${customer}  ${country}
Schedule Ping WBR Test in Mobileum               ${customer}  ${country}
Schedule Internet Breakout Test in Mobileum      ${customer}  ${country}
Schedule CBR Test in Mobileum                    ${customer}  ${country}
Schedule DL Multiple TCP Capacity Test in Mobileum   ${customer}
Schedule Ping Internet Test in Mobileum          ${customer}  ${country}
Schedule Facebook Test in Mobileum               ${customer}  ${country}
```

### Status Check Keywords (Return Verdict/Test ID)
```robot
Run WBR test and check status                    ${client}  ${country}
Run Geolocation test and check status            ${client}  ${country}
Run Ping WBR test and check status               ${client}  ${country}
Run Internet Breakout Test and check status      ${client}  ${country}
Run CBR Test and check status                    ${client}  ${country}
Run DL Multiple TCP Capacity Test and check status    ${client}
Run Ping Internet test and check status          ${client}  ${country}
Run Facebook test and check status               ${client}  ${country}
```

### Verification Keywords (Return IP or Validate Location)
```robot
Run Geolocation Test And Verify Exact Location for Specific APN
    ${client}  ${country}  ${Geolocation}  ${test_country}

Run Internet Breakout Test And Verify Exact Location for Specific APN
    ${client}  ${Test}  ${Geolocation}  ${country}

Run Internet Breakout Test And Verify Exact Location for US APN
    ${client}  ${Geolocation}  ${country}

Get local ip address of site                     ${Test}

Check Verizon Super APN IP location              ${2nd_octet}
Check ATT AML APN IP location                    ${2nd_octet}
Check T-Mobile IP location                       ${2nd_octet}
Check Rogers IP location                         ${2nd_octet}
```

---

## 🐛 Troubleshooting Quick Fixes

### Certificate Error
```bash
# Check certificate exists
ls -la Certificate/akamai_us_api.p12

# Check password in Variables/mobileum_variables.robot
# Update if incorrect
${password_mobileum}    your_actual_password
```

### Connection Timeout
```bash
# Check network
ping api.globalroamer.com

# Check VPN (if required)
# Verify firewall allows port 443
```

### Test Hangs
```bash
# Increase timeout
robot --loglevel TRACE Tests/Mobileum.robot

# Check Mobileum status manually
# Monitor Results/*.log for "RUNNING" status
```

### JSON Parse Error
```robot
# Add debug logging
Log    ${response}    level=TRACE
Log    ${response.text}
Log    ${response.status_code}

# Verify JSON path
${data}    get value from json    ${response.json()}    $.expected.path
```

### Variable Not Found
```robot
# Check imports
Resource    ../Variables/globalvariables.robot
Resource    ../Variables/mobileum_variables.robot

# Print all variables
Log Variables
```

---

## 📊 Test Status Values

| Status | Meaning | Action |
|--------|---------|--------|
| DONE | Test completed | Check verdict (PASS/FAIL) |
| ABORTED | Test aborted | Retry or investigate |
| PENDING | Test waiting | Continue polling |
| RUNNING | Test executing | Continue polling |

---

## 🌍 Carrier-Location Mapping

| Carrier | Test Location | Region |
|---------|---------------|--------|
| Verizon | LAX, EWR, DFW, ORD | US |
| AT&T AML | Test/Prod APN | US |
| T-Mobile | Specific location | US |
| Rogers | Canada location | Canada |
| Telstra | APAC location | Australia |
| Optus | APAC location | Australia |
| BT | UK location | UK |
| O2 | UK location | UK |
| Vodafone | UK/APAC location | UK/International |

---

## 🔐 Security Checklist

- [ ] Certificate file permissions restricted (600)
- [ ] Password not hardcoded in test files
- [ ] Credentials stored in environment variables
- [ ] VPN connected (if required)
- [ ] Firewall rules allow access
- [ ] SMTP credentials configured
- [ ] Email recipients verified
- [ ] Log files don't contain sensitive data

---

## 📈 Performance Tips

1. **Use Pabot for parallel execution**
   ```bash
   pabot --processes 4 -d Results Tests/
   ```

2. **Run only needed tests**
   ```bash
   robot -d Results Tests/Verizon_Super_APN/*.robot
   ```

3. **Use fewer log details (production)**
   ```bash
   robot -L WARN -d Results Tests/Mobileum.robot
   ```

4. **Archive old results frequently**
   ```bash
   tar -czf Results_backup.tar.gz Results/
   rm -rf Results/*
   ```

---

## 📝 Logging Levels

| Level | When to Use | Output |
|-------|------------|--------|
| TRACE | Deep debugging | All operations, variables, API responses |
| DEBUG | Development | Variable assignments, major steps |
| INFO | Standard | Test progress, key milestones |
| WARN | Production | Warnings, recoverable issues |
| ERROR | Always | Errors, failures |

---

## 🎯 Common Test Scenarios

### Test Single Carrier
```bash
robot -d Results Tests/Verizon_Super_APN/
```

### Test by Region
```bash
# US tests
robot -d Results Tests/ATT_* Tests/Verizon_* Tests/T-Mobile/ Tests/Rogers/

# UK tests
robot -d Results Tests/BT_UK/ Tests/O2_UK/ Tests/Vodafone_UK/

# APAC tests
robot -d Results Tests/Telstra/ Tests/Optus_* Tests/Vodafone_GDSP/
```

### Test Type
```bash
# WBR tests (usually first test in carrier suite)
# Geolocation tests (mid-suite)
# Internet Breakout tests (end-suite)
```

### Production Run
```bash
robot --listener Customlibs/EmailListener.py \
      -V Customlibs/config.py \
      --outputdir Production_Logs \
      --log Production_Log.html \
      --report Production_Report.html \
      Tests/Mobileum.robot
```

---

## 🆘 Getting Help

**Quick Questions:** Check FAQ in README.md

**Setup Issues:** See SETUP_AND_TROUBLESHOOTING.md

**Understanding Code:** See PROJECT_DOCUMENTATION.md

**Performance Questions:** See OPTIMIZATION_TECHNIQUES.md

**Contact Team:** dl-SRE-QA@akamai.com

---

## 📅 Regular Maintenance

### Daily
- Monitor test results
- Check Jenkins job status

### Weekly
- Review failure trends
- Archive old results

### Monthly
- Verify carrier test suites
- Update dependencies
- Check certificate expiration

### Quarterly
- Performance baselines
- Security audit
- Documentation updates

---

## 🔗 Important Links

- **Robot Framework:** https://robotframework.org
- **RequestsLibrary:** https://github.com/MarketSquare/robotframework-requests
- **Zoomba Library:** https://github.com/Accellere/Zoomba
- **Mobileum API:** https://www.mobileum.com
- **PKCS#12 Guide:** https://en.wikipedia.org/wiki/PKCS_12

---

## 📞 Support Contacts

| Issue | Contact | Response Time |
|-------|---------|---------------|
| Test failures | dl-SRE-QA@akamai.com | 1-2 hours |
| Setup help | cdhingra@akamai.com | 1-2 hours |
| Configuration | dl-SRE-QA@akamai.com | 1-4 hours |
| Emergency | Slack #qa-automation | 15-30 min |

---

## ✅ Pre-Test Checklist

- [ ] Certificate file present and valid
- [ ] Variables configured correctly
- [ ] Network connectivity working
- [ ] VPN connected (if needed)
- [ ] Jenkins updated with latest code
- [ ] Results directory writable
- [ ] Sufficient disk space (50+ GB)
- [ ] Email settings configured (for notifications)

---

## 📌 Bookmark This!

Save these quick reference locations:
1. **Setup:** SETUP_AND_TROUBLESHOOTING.md
2. **Optimization:** OPTIMIZATION_TECHNIQUES.md
3. **Full Docs:** PROJECT_DOCUMENTATION.md
4. **Overview:** README.md

---

**Last Updated:** 2026-02-11  
**Print Friendly:** Yes  
**Version:** 1.0
