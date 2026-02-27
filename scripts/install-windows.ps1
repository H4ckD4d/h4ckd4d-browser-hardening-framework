$ErrorActionPreference = "Stop"

param(
  [ValidateSet("redteam", "osint", "banking", "everyday", "ultra", "kiosk")]
  [string]$Mode = "redteam",
  [string]$FirefoxProfileDir
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
    Write-Host "[*] Only one profile found. Selecting: $($dirs[0].FullName)"
    return $dirs[0].FullName
  }

  $selectedName = Read-Host "[?] Enter target profile directory name (example: xxxx.default-release)"
  $selectedDir = Join-Path $profilesRoot $selectedName

  if (!(Test-Path $selectedDir)) {
    throw "Profile directory not found: $selectedDir"
  }

  return (Resolve-Path $selectedDir).Path
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$sourceUserJs = Join-Path $repoRoot ("profiles\{0}\user.js" -f $Mode)

if (!(Test-Path $sourceUserJs)) {
  throw "Source profile file not found: $sourceUserJs"
}

$targetProfileDir = Resolve-TargetProfileDir -CandidateDir $FirefoxProfileDir
$targetUserJs = Join-Path $targetProfileDir "user.js"

Write-Host "[*] Mode            : $Mode"
Write-Host "[*] Source user.js  : $sourceUserJs"
Write-Host "[*] Target profile  : $targetProfileDir"

if (Test-Path $targetUserJs) {
  $backupPath = Join-Path $targetProfileDir ("user.js.bak.{0}" -f (Get-Date -Format "yyyyMMdd-HHmmss"))
  Copy-Item $targetUserJs $backupPath
  Write-Host "[*] Backup created  : $backupPath"
}

Copy-Item $sourceUserJs $targetUserJs -Force
Write-Host "[+] Installed user.js to: $targetUserJs"
Write-Host "[*] Done. Restart Firefox for changes to apply."
