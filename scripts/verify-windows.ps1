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
    return $dirs[0].FullName
  }

  $selectedName = Read-Host "[?] Enter target profile directory name"
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

if (!(Test-Path $targetUserJs)) {
  throw "Target user.js not found: $targetUserJs"
}

$sourceHash = (Get-FileHash $sourceUserJs -Algorithm SHA256).Hash
$targetHash = (Get-FileHash $targetUserJs -Algorithm SHA256).Hash

Write-Host "[*] Mode            : $Mode"
Write-Host "[*] Source user.js  : $sourceUserJs"
Write-Host "[*] Target user.js  : $targetUserJs"
Write-Host "[*] Source SHA256   : $sourceHash"
Write-Host "[*] Target SHA256   : $targetHash"

if ($sourceHash -eq $targetHash) {
  Write-Host "[+] Verification passed: target user.js matches selected mode."
} else {
  Write-Host "[!] Verification failed: target user.js does NOT match selected mode."
  exit 1
}

Write-Host ""
Write-Host "[*] Optional manual checks in Firefox about:config:"
Write-Host "  - dom.security.https_only_mode"
Write-Host "  - media.peerconnection.enabled"
Write-Host "  - privacy.resistFingerprinting"
