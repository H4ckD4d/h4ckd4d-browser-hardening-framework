cat > scripts/install-windows.ps1 <<'EOF'
$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$UserJs   = Join-Path $RepoRoot "profiles\redteam\user.js"

$ProfilesIni = Join-Path $env:APPDATA "Mozilla\Firefox\profiles.ini"
if (!(Test-Path $ProfilesIni)) {
  Write-Host "[!] profiles.ini not found at $ProfilesIni"
  exit 1
}

$BaseDir = Split-Path $ProfilesIni -Parent
Write-Host "[*] Found profiles.ini: $ProfilesIni"
Write-Host "[*] Base profiles dir : $BaseDir"
Write-Host ""

Write-Host "[*] Available profile directories:"
Get-ChildItem $BaseDir -Directory | ForEach-Object { Write-Host ("  - " + $_.Name) }
Write-Host ""

$ProfileDirName = Read-Host "[?] Enter target profile directory name (e.g. xxxx.default-release)"
$TargetDir = Join-Path $BaseDir $ProfileDirName

if (!(Test-Path $TargetDir)) {
  Write-Host "[!] Profile directory not found: $TargetDir"
  exit 1
}

$Existing = Join-Path $TargetDir "user.js"
if (Test-Path $Existing) {
  $Backup = Join-Path $TargetDir ("user.js.bak." + (Get-Date -Format "yyyyMMdd-HHmmss"))
  Copy-Item $Existing $Backup
  Write-Host "[*] Backup created: $Backup"
}

Copy-Item $UserJs $Existing -Force
Write-Host "[+] Installed user.js to: $Existing"
Write-Host "[*] Done. Restart Firefox for changes to apply."
EOF
