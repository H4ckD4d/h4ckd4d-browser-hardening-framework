$ErrorActionPreference = "Stop"

param(
  [string]$FirefoxProfileDir,
  [string]$BackupFile
)

function Resolve-TargetProfileDir {
  param([string]$CandidateDir)

  $profilesRoot = Join-Path $env:APPDATA "Mozilla\Firefox\Profiles"
  if (!(Test-Path $profilesRoot)) {
    throw "Firefox profiles directory not found: $profilesRoot"
  }

  if ($CandidateDir) {
    if (!(Test-Path $CandidateDir)) {
      throw "Provided profile directory does not exist: $CandidateDir"
    }
    return (Resolve-Path $CandidateDir).Path
  }

  $dirs = Get-ChildItem $profilesRoot -Directory | Sort-Object Name
  if ($dirs.Count -eq 0) {
    throw "No Firefox profile directories found in: $profilesRoot"
  }

  Write-Host "[*] Available Firefox profile directories:"
  $dirs | ForEach-Object { Write-Host ("  - " + $_.Name) }

  if ($dirs.Count -eq 1) {
    return $dirs[0].FullName
  }

  $selectedName = Read-Host "[?] Enter target profile directory name"
  $selectedDir = Join-Path $profilesRoot $selectedName

  if (!(Test-Path $selectedDir)) {
    throw "Profile directory not found: $selectedDir"
  }

  return (Resolve-Path $selectedDir).Path
}

$targetProfileDir = Resolve-TargetProfileDir -CandidateDir $FirefoxProfileDir
$targetUserJs = Join-Path $targetProfileDir "user.js"

if ($BackupFile) {
  if (!(Test-Path $BackupFile)) {
    throw "Provided backup file not found: $BackupFile"
  }
  $selectedBackup = (Resolve-Path $BackupFile).Path
} else {
  $backups = Get-ChildItem $targetProfileDir -Filter "user.js.bak.*" -File | Sort-Object LastWriteTime -Descending
  if ($backups.Count -eq 0) {
    throw "No backup files found in: $targetProfileDir"
  }

  Write-Host "[*] Available backups:"
  $backups | ForEach-Object { Write-Host ("  - " + $_.Name) }

  $selectedBackup = $backups[0].FullName
  Write-Host "[*] No backup specified. Using latest: $($backups[0].Name)"
}

Copy-Item $selectedBackup $targetUserJs -Force
Write-Host "[+] Restored backup to: $targetUserJs"
Write-Host "[*] Restart Firefox for rollback to apply."
