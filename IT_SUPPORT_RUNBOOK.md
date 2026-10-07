# IT Support Runbook

## 1. Log the support request
Capture:
- user
- device / asset tag
- location
- phone or in-person channel
- exact symptoms
- time issue began
- business impact
- screenshots / error messages

## 2. Triage
Determine:
- one user or multiple users?
- one device or multiple devices?
- hardware, Windows, Microsoft 365, network, access, printer, or application?
- severity / urgency
- whether a recent change may be related

## 3. Basic workstation checks
- power / cables / dock / monitor
- restart where appropriate
- disk capacity and memory
- Windows update status
- Event Viewer
- application version and error message

## 4. Network checks
- `ipconfig /all`
- confirm IP address, subnet, gateway, DNS
- ping loopback
- ping gateway
- ping known host
- `nslookup` for DNS
- escalate to network operations with test results if scope is larger than the endpoint

## 5. Microsoft 365 / access checks
- internet connection
- time synchronization
- account status
- profile / sign-in state
- approved access
- escalate identity or administrator-level issues with evidence

## 6. Hardware checks
- confirm asset tag / serial
- isolate cable, dock, display, keyboard, mouse, or printer issue
- test known-good peripheral where appropriate
- document replacement / shipment / repair action

## 7. Escalation
Provide:
- concise issue summary
- affected user and asset
- checks already completed
- error codes
- screenshots
- network results
- recent changes
- business impact

## 8. Validate and close
- reproduce original workflow
- confirm with the user
- record resolution
- update asset or change records if needed
- create / update knowledge documentation for repeatable fixes
