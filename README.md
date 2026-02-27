# h4ckd4d Firefox Red Team Mode

A multi-profile Firefox hardening framework for operators, investigators, and privacy-focused users.

Author and maintainer: **h4ckd4d**

## Why this project exists

This repository was created to make browser hardening repeatable, auditable, and operationally useful for real-world security work.

It is built and maintained by **h4ckd4d**, a Red Team and offensive security practitioner with over 30 years of field experience across adversary simulation, OPSEC-heavy investigations, and defensive hardening informed by real incidents.

## What it does

This project provides scenario-specific Firefox `user.js` profiles that you can install into an existing Firefox profile directory:

- `redteam`: aggressive OPSEC hardening for operations and threat emulation
- `osint`: investigation-focused mode with moderate compatibility
- `banking`: security-first profile with better site compatibility
- `everyday`: balanced privacy and usability for normal browsing
- `ultra`: maximum privacy with high breakage risk
- `kiosk`: locked-down mode for shared or controlled systems

Each mode lives in:

- `profiles/<mode>/user.js`

## Repository structure

```text
profiles/
  banking/user.js
  everyday/user.js
  kiosk/user.js
  osint/user.js
  redteam/user.js
  ultra/user.js

scripts/
  install-windows.ps1
  verify-windows.ps1
  rollback-windows.ps1
```

## Current platform support

Currently versioned and ready:

- Windows PowerShell scripts

If you are on Linux/macOS, you can still manually copy `profiles/<mode>/user.js` into your Firefox target profile, but automated installers for those OSes are not yet versioned in this branch.

## Quick start (Windows)

1. Clone the repository.
2. Open PowerShell in the repository root.
3. Install your chosen mode.

```powershell
git clone https://github.com/H4ckD4d/h4ckd4d-firefox-redteam.git
cd h4ckd4d-firefox-redteam

# Example: install redteam mode (default)
.\scripts\install-windows.ps1 -Mode redteam

# Example: install osint mode
.\scripts\install-windows.ps1 -Mode osint
```

You can optionally pass a direct Firefox profile directory:

```powershell
.\scripts\install-windows.ps1 -Mode ultra -FirefoxProfileDir "$env:APPDATA\Mozilla\Firefox\Profiles\xxxx.default-release"
```

## Verification

Verify that the installed `user.js` matches the selected mode:

```powershell
.\scripts\verify-windows.ps1 -Mode redteam
```

The verifier compares SHA256 hashes between:

- source file: `profiles/<mode>/user.js`
- target file: `<FirefoxProfileDir>\user.js`

## Rollback

Rollback to the latest backup created during install:

```powershell
.\scripts\rollback-windows.ps1
```

Or provide a specific backup file:

```powershell
.\scripts\rollback-windows.ps1 -BackupFile "C:\Users\<user>\AppData\Roaming\Mozilla\Firefox\Profiles\xxxx.default-release\user.js.bak.20260227-120000"
```

## Notes and caveats

- This is a dedicated hardening setup, not a general "everything works" browser profile.
- Expect breakage on some web apps, SSO flows, media stacks, and real-time tools, especially in `redteam`, `ultra`, and `kiosk`.
- `user.js` preferences are applied when Firefox starts.

## Credits

Created and maintained by **h4ckd4d**.

If you use this framework in your organization or workflow, keep attribution in derivative guides and internal playbooks.
