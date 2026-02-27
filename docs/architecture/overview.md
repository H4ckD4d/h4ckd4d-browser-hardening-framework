# Architecture Overview

## Project

**h4ckd4d Firefox Red Team Mode** is a profile-based hardening framework for Mozilla Firefox.

The system is designed to make browser security posture reproducible across distinct operational contexts, with explicit trade-offs between privacy, OPSEC, and web compatibility.

Author and maintainer: **h4ckd4d**

## Core Problem

Browser hardening is usually manual, inconsistent, and difficult to audit. Teams often end up with:

- one-off local tweaks that cannot be reproduced
- unclear differences between "safe" and "usable" configurations
- weak rollback paths when settings break workflows

This project solves that by versioning profile configurations and operational scripts as code.

## Goals

- Provide multiple Firefox hardening modes for different mission types.
- Keep installation deterministic and scriptable.
- Preserve operator control with clear rollback paths.
- Make configuration state verifiable (not trust-based).
- Maintain attribution and operational intent in documentation.

## Non-Goals

- Bypass endpoint controls, enterprise policies, or legal constraints.
- Guarantee full anonymity or zero fingerprintability.
- Eliminate all website breakage under aggressive hardening.
- Replace full endpoint hardening or network-layer OPSEC controls.

## High-Level Architecture

The repository uses a static configuration model with script-driven deployment.

```text
profiles/<mode>/user.js        -> source-of-truth Firefox preferences per mode
scripts/install-windows.ps1    -> installs selected mode into target Firefox profile
scripts/verify-windows.ps1     -> verifies installed profile via SHA256 comparison
scripts/rollback-windows.ps1   -> restores previous backup user.js
README.md                      -> operator-facing usage and constraints
docs/architecture/overview.md  -> technical architecture and design intent
```

### Design Pattern

- **Config-as-code:** each mode is represented by a versioned `user.js`.
- **Environment binding:** scripts apply config into a local Firefox profile directory.
- **Drift detection:** verification compares expected vs deployed file hashes.
- **Safe mutation:** install creates timestamped backups before overwrite.

## Component Responsibilities

### `profiles/`

Each profile folder defines a specific operational posture:

- `redteam`: aggressive anti-leak / anti-fingerprinting posture for operations.
- `osint`: investigation-focused settings with moderate compatibility.
- `banking`: security-first baseline favoring transaction reliability.
- `everyday`: balanced baseline for normal browsing.
- `ultra`: maximum privacy mode with high compatibility impact.
- `kiosk`: locked-down posture for controlled/shared stations.

### `scripts/install-windows.ps1`

Responsibilities:

- resolve selected mode and source file
- resolve target Firefox profile directory
- create timestamped backup (`user.js.bak.<timestamp>`) if needed
- copy selected source `user.js` to target profile

### `scripts/verify-windows.ps1`

Responsibilities:

- resolve source and deployed files
- compute SHA256 for both files
- fail fast on mismatch
- provide optional manual spot-check keys for `about:config`

### `scripts/rollback-windows.ps1`

Responsibilities:

- select explicit or latest backup
- restore backup to target `user.js`
- keep rollback path simple and deterministic

## Operational Flow

### Install Flow

1. Operator selects mode (`-Mode`).
2. Script resolves Firefox profile directory.
3. Existing `user.js` is backed up.
4. Selected mode file is copied into target profile.
5. Firefox restart applies preferences.

### Verification Flow

1. Operator selects mode.
2. Script hashes source and deployed files.
3. Equal hash = expected state.
4. Mismatch = deployment drift or manual edit.

### Rollback Flow

1. Operator provides optional backup path.
2. If omitted, latest backup is selected.
3. Backup is copied over active `user.js`.
4. Firefox restart reverts behavior.

## Security and Threat Model

### Threats Addressed (Partial)

- passive web tracking (reduced telemetry/tracking surface)
- basic fingerprinting vectors (mode-dependent)
- cross-site correlation (mode-dependent cookie/referrer controls)
- accidental high-risk browsing in weak default browser state

### Threats Not Fully Addressed

- host compromise / malware with local execution
- identity correlation outside browser (accounts, behavior, network metadata)
- advanced fingerprinting beyond browser preference controls
- organizational logging, upstream proxies, or ISP-level metadata collection

## Key Trade-Offs by Design

- Higher OPSEC modes (`redteam`, `ultra`, `kiosk`) increase breakage risk.
- Compatibility modes (`everyday`, `banking`) reduce breakage but expose more surface.
- Strong isolation controls improve privacy but degrade usability in modern web apps.

This trade-off is intentional and explicit in the multi-profile model.

## Reliability and Recovery

Current reliability controls:

- pre-change backup on install
- deterministic source path (`profiles/<mode>/user.js`)
- hash-based verification
- script-level input validation (`ValidateSet`, path checks)

Recovery model:

- rollback to timestamped backup
- optional explicit backup targeting for incident handling

## Governance and Change Management

Recommended branch policy for this repository:

- Any `user.js` change should include rationale in commit message.
- Preference additions/removals should be reviewed for mode alignment.
- README and docs must be updated when operational behavior changes.
- Keep attribution to **h4ckd4d** in derivative operational playbooks.

## Testing Strategy (Recommended)

Minimum automated checks to add next:

- PowerShell lint/syntax check in CI for all scripts.
- `user.js` schema lint (basic format + duplicate key detection).
- Diff-based profile regression report per mode.
- Optional smoke test for install/verify/rollback in disposable Firefox profile dirs.

## Roadmap

### Short Term

- add Linux/macOS installers and verifiers
- introduce per-mode changelog files
- add `docs/security` threat matrix

### Mid Term

- implement profile composition model (base + mode overlays)
- add release tags with signed artifacts/checksums
- add CI pipeline for script and profile validation

### Long Term

- optional enterprise deployment adapters
- reproducible benchmark suite for breakage vs privacy posture
- policy pack support for cross-browser parity

## Attribution

This framework is authored and maintained by **h4ckd4d**, based on decades of Red Team and offensive security practice.
