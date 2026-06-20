param(
    [switch]$Install
)

$tools = @(
    @{ Name = "node"; Command = "node --version"; InstallCommand = "winget install -e --id OpenJS.NodeJS" }
    @{ Name = "npm"; Command = "npm --version"; InstallCommand = "winget install -e --id OpenJS.NodeJS" }
    @{ Name = "php"; Command = "php --version"; InstallCommand = "winget install -e --id PHP.PHP" }
    @{ Name = "python"; Command = "python --version"; InstallCommand = "winget install -e --id Python.Python.3" }
    @{ Name = "uv"; Command = "uv --version"; InstallCommand = "powershell -c `"irm https://astral.sh/uv/install.ps1 | iex`"" }
    @{ Name = "composer"; Command = "composer --version"; InstallCommand = "php -r `"copy('https://getcomposer.org/installer', 'composer-setup.php');`" && php composer-setup.php && php -r `"unlink('composer-setup.php');`"" }
)

$passed = 0
$failed = 0

Write-Output "========================================"
Write-Output "  Tool Check Script"
Write-Output "========================================"

foreach ($tool in $tools) {
    Write-Output "----------------------------------------"
    Write-Output "Checking $($tool.Name)..."
    
    $version = & cmd /c "$($tool.Command) 2>nul" 2>$null
    if ($LASTEXITCODE -eq 0 -and $version) {
        $version = $version.Trim()
        Write-Output "[PASS] $($tool.Name) is available. Version: $version"
        $passed++
    } else {
        if ($tool.Name -eq "npm") {
            Write-Output "npm check failed. Attempting Set-ExecutionPolicy..."
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            $version = & cmd /c "$($tool.Command) 2>nul" 2>$null
            if ($LASTEXITCODE -eq 0 -and $version) {
                $version = $version.Trim()
                Write-Output "[PASS] $($tool.Name) is available. Version: $version"
                $passed++
                continue
            }
        }
        
        Write-Output "$($tool.Name) is not available."
        $failed++
        
        if ($Install) {
            Write-Output "Installing $($tool.Name)..."
            Invoke-Expression $tool.InstallCommand
            if ($LASTEXITCODE -eq 0) {
                Write-Output "$($tool.Name) installed successfully."
                $passed++
                $failed--
            } else {
                Write-Output "Failed to install $($tool.Name)."
            }
        }
    }
}

Write-Output "========================================"
Write-Output "  Check complete. Passed: $passed, Failed: $failed"
Write-Output "========================================"
