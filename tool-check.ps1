param(
    [switch]$Install
)

$tools = @("node", "npm", "php", "python", "uv", "composer")
$passed = 0
$failed = 0

Write-Output "========================================"
Write-Output "  Tool Check Script"
Write-Output "========================================"

foreach ($tool in $tools) {
    Write-Output "----------------------------------------"
    Write-Output "Checking $tool..."

    $cmd = Get-Command $tool -ErrorAction SilentlyContinue
    $versionStr = ""
    $checkSuccess = $false
    $errorMsg = ""

    if ($cmd) {
        $versionOutput = & $tool --version 2>&1
        $checkSuccess = $LASTEXITCODE -eq 0

        if ($tool -eq "npm" -and -not $checkSuccess) {
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser 2>$null
            $versionOutput = & npm --version 2>&1
            $checkSuccess = $LASTEXITCODE -eq 0
        }

        if ($checkSuccess) {
            $outputStr = "$versionOutput"

            switch ($tool) {
                "node" {
                    if ($outputStr -match 'v?(\d+\.\d+\.\d+)') {
                        $versionStr = $matches[1]
                    }
                }
                "npm" {
                    $versionStr = $outputStr.Trim()
                }
                "php" {
                    if ($outputStr -match 'PHP (\d+\.\d+\.\d+)') {
                        $versionStr = $matches[1]
                    }
                }
                "python" {
                    if ($outputStr -match 'Python (\d+\.\d+\.\d+)') {
                        $versionStr = $matches[1]
                    }
                }
                "uv" {
                    if ($outputStr -match 'uv (\d+\.\d+\.\d+)') {
                        $versionStr = $matches[1]
                    }
                }
                "composer" {
                    if ($outputStr -match 'Composer version (\d+\.\d+\.\d+)') {
                        $versionStr = $matches[1]
                    }
                }
            }
        } else {
            $errorMsg = "$tool check failed (exit code: $LASTEXITCODE)"
        }
    } else {
        $errorMsg = "$tool is not installed or not found in PATH"
    }

    if ($checkSuccess -and $versionStr -ne "") {
        Write-Output "[PASS] $tool is available. Version: $versionStr"
        $passed++
    } else {
        Write-Output $errorMsg
        $failed++

        if ($Install) {
            Write-Output "Installing $tool..."
            switch ($tool) {
                "node" {
                    Write-Output "Running winget install for Node.js..."
                    winget install -e --id OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements 2>&1
                }
                "npm" {
                    Write-Output "npm is bundled with Node.js. Installing Node.js instead..."
                    winget install -e --id OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements 2>&1
                }
                "php" {
                    Write-Output "Running winget install for PHP..."
                    winget install -e --id PHP.PHP --accept-package-agreements --accept-source-agreements 2>&1
                }
                "python" {
                    Write-Output "Running winget install for Python..."
                    winget install -e --id Python.Python.3.13 --accept-package-agreements --accept-source-agreements 2>&1
                }
                "uv" {
                    Write-Output "Installing uv..."
                    powershell -c "irm https://astral.sh/uv/install.ps1 | iex" 2>&1
                }
                "composer" {
                    Write-Output "Running winget install for Composer..."
                    winget install -e --id Composer.Composer --accept-package-agreements --accept-source-agreements 2>&1
                }
            }
            Write-Output "$tool installation completed."
        }
    }
}

Write-Output "========================================"
Write-Output "  Check complete. Passed: $passed, Failed: $failed"
Write-Output "========================================"
