# Threat Matrix

## Scope

This matrix describes what **h4ckd4d Firefox Red Team Mode** can reduce at browser preference level, and what remains out of scope.

It is not a guarantee of anonymity. It is a practical control map for operational decision-making.

## Profile Legend

- `High`: strong mitigation intent in this mode
- `Medium`: partial mitigation with compatibility balance
- `Low`: minimal mitigation or not targeted

## Threat Coverage Matrix

| Threat Category | redteam | osint | banking | everyday | ultra | kiosk | Notes |
|---|---|---|---|---|---|---|---|
| Passive tracking scripts | High | High | Medium | Medium | High | High | ETP + cookie controls reduce common tracking paths |
| Cross-site correlation | High | Medium | Medium | Medium | High | High | Driven by cookie behavior and referrer restrictions |
| Browser fingerprinting | High | Medium | Low | Low | High | High | RFP/WebGL/WebRTC posture varies by mode |
| WebRTC IP exposure | High | High | Low | Low | High | High | `media.peerconnection.enabled=false` in stricter modes |
| TLS downgrade / insecure transport | High | High | High | High | High | High | HTTPS-Only enabled across all modes |
| Session persistence risk on shared host | High | High | Low | Low | High | High | Shutdown-clearing stronger in strict modes |
| Telemetry leakage to vendor endpoints | High | High | High | High | High | High | Telemetry and studies disabled in all modes |
| Site breakage risk | High | Medium | Low | Low | High | High | Trade-off is intentional by profile design |
| Account-based deanonymization | Low | Low | Low | Low | Low | Low | Out of scope for browser prefs alone |
| Host malware / local compromise | Low | Low | Low | Low | Low | Low | Must be handled at endpoint/security stack level |
| Enterprise proxy / upstream logging | Low | Low | Low | Low | Low | Low | Network/operator visibility remains external |

## Mapping to Key Preferences

Primary controls used across profiles:

- `dom.security.https_only_mode`
- `network.cookie.cookieBehavior`
- `network.http.referer.XOriginPolicy`
- `privacy.resistFingerprinting`
- `privacy.firstparty.isolate`
- `media.peerconnection.enabled`
- `webgl.disabled`
- `privacy.clearOnShutdown.*`

## Threats Not Solved by This Project

- credential reuse and real identity login behavior
- endpoint compromise, keylogging, browser process injection
- traffic inspection by corporate proxies, ISP, or hostile network operators
- metadata leakage through DNS, timing, browsing habits, and account ecosystems

## Operational Recommendations

1. Use separate Firefox profiles per mission and identity.
2. Prefer `redteam` or `ultra` only when breakage is acceptable.
3. Use `banking` or `everyday` for lower-friction workflows.
4. Validate deployed state with `scripts/verify-windows.ps1` after each install.
5. Keep rollback backups and test critical workflows before live operations.

## Attribution

Framework created and maintained by **h4ckd4d**.
