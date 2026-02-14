Set-Location -Path $PSScriptRoot
$configFile = "key.txt"

if (Test-Path ".venv\Scripts\Activate.ps1") {
    . ".venv\Scripts\Activate.ps1"
} else {
    Write-Host "Setting up for the first use..."
    Write-Host ""
    python -m venv .venv
    . ".venv\Scripts\Activate.ps1"
    pip install -r requirements.txt
}

if (-not (Test-Path $configFile)) {
    $userInput = Read-Host "Enter API Key: "
    [System.IO.File]::WriteAllText($configFile, $userInput, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Key saved to $configFile"
}

do {
    Write-Host "`nPlease Select your Image..."

    Add-Type -AssemblyName System.Windows.Forms

    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.InitialDirectory = [Environment]::GetFolderPath('Desktop')
    $dialog.Filter = "All Files (*.*)|*.*"
    $dialog.ShowHelp = $true

    $result = $dialog.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedImage = $dialog.FileName
        Write-Host "Selected Image: $selectedImage"

        & python convert.py --f "$selectedImage"

        $repeat = Read-Host "`nProcess Another Image? (Y/N)"
    } else {
        Write-Host "Exiting..."
        break
    }
} while ($repeat -eq 'Y' -or $repeat -eq 'y')

Write-Host "Done"