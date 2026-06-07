$logDir = "..\logs"

if (!(Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir | Out-Null
}
function Log($msg) {
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$time - $msg" | Out-File -Append "..\logs\system_report.log"
}

while ($true) {

    $cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

    $os = Get-CimInstance Win32_OperatingSystem
    $ram = (($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100

    $disk = Get-PSDrive C
    $diskUsage = ($disk.Used / ($disk.Used + $disk.Free)) * 100

    if ($cpu -gt 80) {
        Write-Host "HIGH CPU: $cpu%" -ForegroundColor Red
        Log "High CPU usage: $cpu%"
    }

    if ($ram -gt 90) {
        Write-Host "HIGH RAM: $ram%" -ForegroundColor Red
        Log "High RAM usage: $ram%"
    }

    if ($diskUsage -gt 90) {
        Write-Host "HIGH DISK: $diskUsage%" -ForegroundColor Red
        Log "High Disk usage: $diskUsage%"
    }

    Start-Sleep 2
}