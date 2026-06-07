Clear-Host

function Get-CPU {
    (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
}

function Get-RAM {
    $os = Get-CimInstance Win32_OperatingSystem
    (($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100
}

function Get-Disk {
    $d = Get-PSDrive C
    ($d.Used / ($d.Used + $d.Free)) * 100
}

while ($true) {

    $cpu = [math]::Round((Get-CPU), 1)
    $ram = [math]::Round((Get-RAM), 1)
    $disk = [math]::Round((Get-Disk), 1)

    Clear-Host
    Write-Host "=========== SYSTEM DASHBOARD ===========" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "CPU  : $cpu %"
    Write-Host "RAM  : $ram %"
    Write-Host "DISK : $disk %"

    Write-Host ""
    Write-Host "Live monitoring..." -ForegroundColor DarkGray

    Start-Sleep 1
}