---
name: powershell-generator
description: A skill that generates PowerShell scripts based on user requirements.
---

## Golden Rule

- Use powershell 5.1 only.
- The powershell script should be able to run on windows 10 and windows 11.
- Use powershell simple syntax and avoid using advanced features that may not be supported in older versions of powershell.
- Don't use colors or special characters when showing logs.
- Plain messaging is enough.

## Example of Simple Syntax

These are some examples of simple syntax in powershell that can be used in the generated scripts:

### Basic Cmdlet Syntax

```powershell
Get-Process
Set-Content -Path "C:\example.txt" -Value "Hello, World!"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Variables

```powershell
$greeting = "Hello, World!"
$number = 42
```

### Comparison and Conditional Statements

```powershell
if ($number -gt 10) {
    Write-Output "The number is greater than 10."
} else {
    Write-Output "The number is less than 10."
}
```

### Loops

```powershell
for ($i = 0; $i -lt 5; $i++) {
    Write-Output "Iteration: $i"
}
foreach ($item in $items) {
    Write-Output "Item: $item"
}
```

### Functions

```powershell
function Get-Greeting {
    param (
        [string]$name
    )
    return "Hello, $name!"
}
```
