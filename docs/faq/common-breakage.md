# Common Breakage FAQ

## Why do some websites stop working after hardening?

Strict profiles intentionally disable or restrict browser features that many modern sites depend on (for example WebRTC, some fingerprinting APIs, and persistent state behavior).

This is expected behavior in `redteam`, `ultra`, and `kiosk`.

## Why did video calls stop working?

Likely cause: WebRTC disabled (`media.peerconnection.enabled=false`) in stricter modes.

Options:

1. Use a less strict mode (`osint`, `banking`, or `everyday`).
2. Use a separate Firefox profile dedicated to video/meeting tools.

## Why does SSO or enterprise login fail intermittently?

Likely causes:

- strict cookie and cross-site restrictions
- anti-fingerprinting behavior affecting challenge flows
- site assumptions about persistent browser state

Recommended approach:

- keep a dedicated compatibility profile for that identity provider
- avoid mixing high-OPSEC and enterprise SSO workflows in the same browser profile

## Why are banking sites challenging me more often?

Banking anti-fraud systems often use device/browser consistency checks. Strong anti-fingerprinting settings can increase friction.

Use the `banking` mode for best balance in this project.

## Why do I keep getting logged out?

Some modes clear state on shutdown (`privacy.clearOnShutdown.*`) and/or enforce stricter cookie behavior.

This is an OPSEC trade-off, not a script failure.

## How do I confirm the right profile is installed?

Run:

```powershell
.\scripts\verify-windows.ps1 -Mode <mode>
```

If hashes match, the deployed `user.js` matches the selected repository mode.

## How do I recover quickly if a mission-critical site breaks?

1. Roll back immediately:

```powershell
.\scripts\rollback-windows.ps1
```

2. Reinstall a softer mode:

```powershell
.\scripts\install-windows.ps1 -Mode osint
```

## Should I use one browser profile for everything?

No. Split by mission and identity context.

Recommended minimum separation:

- operations/redteam tasks
- OSINT/investigation tasks
- finance/banking tasks
- everyday personal browsing

## Is this framework enough for full anonymity?

No. It hardens browser behavior, but does not solve endpoint compromise, account-based identity leakage, or network-level visibility.

## Attribution

FAQ for **h4ckd4d Firefox Red Team Mode**, maintained by **h4ckd4d**.
