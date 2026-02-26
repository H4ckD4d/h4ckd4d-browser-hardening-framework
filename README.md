# h4ckd4d Firefox Red Team Mode

Hi — I’m **h4ckd4d**.  
This repository provides a hardened **Firefox “Red Team Mode”** profile configuration designed for:
- OSINT & investigation workflows
- OPSEC-focused browsing
- Reduced tracking & fingerprinting exposure
- Minimal data retention

> ⚠️ This is a dedicated profile setup. Expect some websites to break (banking, heavy web apps, video calls, certain dashboards).

## What’s inside
- `profiles/redteam/user.js` — hardened preferences (privacy/security/anti-leak)
- Install scripts for:
  - Linux/macOS (`bash`)
  - Windows (`PowerShell`)
- Rollback scripts
- Verification scripts

## Quick start

---

## 🔥 Multi-Profile Architecture

profiles/
 ├── redteam/
 ├── osint/
 ├── banking/
 ├── everyday/
 ├── ultra/
 └── kiosk/

### What this means

Each folder contains a dedicated `user.js` configuration tailored for a specific operational scenario.

### Profiles Explained

🛡 redteam  
Full hardened mode for Red Team operations and penetration testing.

🔎 osint  
Balanced investigative mode for OSINT and recon workflows.

🏦 banking  
Security-first browsing for financial operations.

🌍 everyday  
Hardened daily browsing profile.

🚫 kiosk  
Locked-down environment for controlled/public systems.

🧨 ultra  
Extreme privacy mode for high-risk environments.




### macOS / Linux
```bash
git clone https://github.com/H4ckD4d/h4ckd4d-firefox-redteam.git
cd h4ckd4d-firefox-redteam
bash scripts/install-linux-macos.sh
bash scripts/verify-linux-macos.sh
```
