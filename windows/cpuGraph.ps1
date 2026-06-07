Clear-Host
$history = New-Object System.Collections.Generic.Queue[double]

while ($true) {

    $cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

    if ($history.Count -ge 30) {
        $history.Dequeue()
    }

    $history.Enqueue([math]::Round($cpu, 1))

    Clear-Host
    Write-Host "CPU USAGE GRAPH" -ForegroundColor Cyan
    Write-Host ""

    foreach ($v in $history) {
        Write-Host ("{0,5}% | {1}" -f $v, ("#" * ($v / 2)))
    }

    Start-Sleep 1
}