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

## Why this exists (and who built it)

Built by **@h4ckd4d** — Red Team / offensive security practitioner with **30+ years** of hands-on experience across:
- adversary simulation & threat emulation
- OPSEC for investigations and sensitive browsing
- privacy hardening and anti-fingerprinting strategy
- incident-driven defensive tuning (real-world learnings)

This framework is designed to help operators, analysts, and privacy-conscious users deploy **repeatable, auditable browser hardening** across platforms and browsers — without guesswork.

**Keywords (SEO):** browser hardening, Firefox user.js, Brave hardening, Chrome policies, Chromium enterprise policies, anti-fingerprinting, OSINT browser, Red Team OPSEC, privacy configuration, security browser profile, hardened browsing, investigation browser setup, threat emulation tooling.

---

## Profiles (choose your mode)

This repo ships multiple hardened profiles with different trade-offs:

- **redteam** — aggressive OPSEC hardening for operations & adversary simulation
- **osint** — investigation-focused browsing; reduced leaks; practical compatibility
- **banking** — safer daily banking (less breaking changes; more compatibility)
- **everyday** — balanced privacy + usability for normal browsing
- **ultra** — maximum privacy (expect breakage)
- **kiosk** — locked-down mode for dedicated machines / limited interaction

---

## How it works (high level)

- **Firefox:** each profile uses a `user.js` that applies hardened preferences on startup.
- **Chromium-based browsers (Brave/Chrome/DuckDuckGo):** policies are applied via managed policy files / OS-level policy paths.
- **Scripts:** one command installs the chosen profile for your OS and browser.
- **Verify:** verification scripts confirm what was actually applied (no “trust me” configs).

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
