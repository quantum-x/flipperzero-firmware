Set-StrictMode -Version 2.0
$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
$repo_root = (Get-Item "$PSScriptRoot\..\..").FullName
$toolchain_url = "https://github.com/flipperdevices/flipperzero-firmware/archive/refs/tags/0.60.0-rc.zip"
$toolchain_zip = "gcc-arm-none-eabi-10.3-2022.06-win32.zip"

if (Test-Path -LiteralPath "$repo_root\toolchain") {
	Write-Host -NoNewline "Removing old Windows toolchain.."
	Remove-Item -LiteralPath "$repo_root\toolchain" -Force -Recurse
	Write-Host "done!"
}

Write-Host -NoNewline "Downloading Windows toolchain.."
Invoke-WebRequest -Uri "$toolchain_url" -OutFile "$repo_root\$toolchain_zip"
Write-Host "done!"

Write-Host -NoNewline "Unziping Windows toolchain.."
Expand-Archive -LiteralPath "$toolchain_zip" -DestinationPath "$repo_root\" -Force
Rename-Item "$repo_root\flipperzero-firmware-0.60.0-rc" "$repo_root\toolchain"
Write-Host "done!"

Write-Host -NoNewline "Clearing temporary files.."
Remove-Item -LiteralPath "$repo_root\$toolchain_zip" -Force
Write-Host "done!"