cat > scripts/verify-windows.ps1 <<'EOF'
Write-Host "[*] Verify in Firefox (target profile):"
Write-Host "  - about:config"
Write-Host "    privacy.resistFingerprinting = true"
Write-Host "    media.peerconnection.enabled = false"
Write-Host "    webgl.disabled = true"
Write-Host "    dom.security.https_only_mode = true"
Write-Host ""
Write-Host "[+] Done."
EOF
