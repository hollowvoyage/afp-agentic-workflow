---
description: Generate script base on the steps given by the user.
---

## Step by Step Procedure

Follow these steps when generating the script.

Load skill first:
Skill({ name: "powershell-generator" })

### Step 1:

Create parameter for option to install.

### Step 2:

Create variable for tool listing and for pass and fail flag.

### Step 3:

- Display Tool check script message then loop through all tool list.
- Run check version for each tool.
- Check `node` first.
- Check if the current tool is npm then if fais run `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
- If check failed, intall the tool.
