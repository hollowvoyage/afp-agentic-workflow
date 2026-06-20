## AGENTS.md

This will govern the general behavior of the agent.

## Format

- Filename should be `tool-check.ps1`
- follow this logging display:

```bash
========================================
  Tool Check Script
========================================
----------------------------------------
Checking <tool>...
[PASS] <tool> is available. Version: <version_number>
----------------------------------------
Checking <tool>...
<error_message>

========================================
  Check complete. Passed: 6, Failed: 0
========================================
```
