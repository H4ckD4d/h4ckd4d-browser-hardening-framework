# Windows Installation Guide

## Prerequisites

- Windows host with Firefox installed.
- PowerShell available (`pwsh` or Windows PowerShell).
- A cloned copy of this repository.

## Repository Layout Used by This Guide

- `profiles/<mode>/user.js`
- `scripts/install-windows.ps1`
- `scripts/verify-windows.ps1`
- `scripts/rollback-windows.ps1`

## Available Modes

- `redteam`
- `osint`
- `banking`
- `everyday`
- `ultra`
- `kiosk`

## Step 1: Clone

```powershell
git clone https://github.com/H4ckD4d/h4ckd4d-firefox-redteam.git
cd h4ckd4d-firefox-redteam
```

## Step 2: Install a Mode

Default install (redteam):

```powershell
.\scripts\install-windows.ps1
```

Explicit mode selection:

```powershell
.\scripts\install-windows.ps1 -Mode osint
.\scripts\install-windows.ps1 -Mode ultra
```

Optional explicit Firefox profile path:

```powershell
.\scripts\install-windows.ps1 -Mode redteam -FirefoxProfileDir "$env:APPDATA\Mozilla\Firefox\Profiles\xxxx.default-release"
```

## Step 3: Verify Deployment

```powershell
.\scripts\verify-windows.ps1 -Mode redteam
```

What verification does:

- Computes SHA256 of source mode file (`profiles/<mode>/user.js`)
- Computes SHA256 of deployed target `user.js`
- Fails on mismatch

## Step 4: Rollback (If Needed)

Rollback to latest backup:

```powershell
.\scripts\rollback-windows.ps1
```

Rollback using explicit backup file:

```powershell
.\scripts\rollback-windows.ps1 -BackupFile "C:\Users\<user>\AppData\Roaming\Mozilla\Firefox\Profiles\xxxx.default-release\user.js.bak.20260227-120000"
```

## Troubleshooting

### Firefox profile directory not found

Check if Firefox has been launched at least once for the user account and confirm:

`$env:APPDATA\Mozilla\Firefox\Profiles`

### Verification mismatch

Likely causes:

- different mode installed than expected
- manual changes in target `user.js`
- wrong target profile directory selected

Fix:

1. rerun install with explicit `-Mode`
2. rerun verify using same `-Mode`
3. provide explicit `-FirefoxProfileDir`

### Sites are broken after install

Expected in strict modes (`redteam`, `ultra`, `kiosk`).

Use rollback or switch to `osint` / `banking` / `everyday`.

## Operational Notes

- Restart Firefox after install/rollback.
- Keep separate Firefox profiles for different missions.
- Treat strict modes as purpose-built operational environments.

## Attribution

Created and maintained by **h4ckd4d**.
