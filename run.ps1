function Show-Menu {
    Clear-Host
    Write-Host "================ SYSTEM MONITOR TOOLKIT ================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. System Dashboard (Live)"
    Write-Host "2. CPU Graph"
    Write-Host "3. System Monitor (Alerts)"
    Write-Host "4. Exit"
    Write-Host ""
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Select option"

    switch ($choice) {

        "1" {
            powershell -ExecutionPolicy Bypass -File ".\windows\systemDashboard.ps1"
        }

        "2" {
            powershell -ExecutionPolicy Bypass -File ".\windows\cpuGraph.ps1"
        }

        "3" {
            powershell -ExecutionPolicy Bypass -File ".\windows\systemMonitor.ps1"
        }

        "4" {
            exit
        }

        default {
            Write-Host "Invalid option" -ForegroundColor Red
            Start-Sleep 1
        }
    }
}