$ErrorActionPreference='Continue'
[Console]::OutputEncoding=[Text.Encoding]::UTF8
function H($t){ Write-Host "`n===== $t" }
$K=3
H 'T2 process tree: K windows with ping -t'
1..$K | ForEach-Object { Start-Process cmd -ArgumentList '/k','ping -t 127.0.0.1' -WindowStyle Hidden }
Start-Sleep 4
"PING.EXE count (expect $K): " + @(Get-Process ping -ErrorAction SilentlyContinue).Count
cmd /c 'tasklist /fi "imagename eq ping.exe"'
$pings=Get-CimInstance Win32_Process -Filter "Name='ping.exe'" | Select-Object ProcessId, ParentProcessId
$pings | Format-Table
$first=$pings[0]
Stop-Process -Id $first.ProcessId -Force
Start-Sleep 1
"after end process: ping=" + @(Get-Process ping -ErrorAction SilentlyContinue).Count + " (expect $($K-1)); parent cmd alive=" + [bool](Get-Process -Id $first.ParentProcessId -ErrorAction SilentlyContinue) + " (expect True)"
$p2=(Get-CimInstance Win32_Process -Filter "Name='ping.exe'")[0]
cmd /c "taskkill /t /f /pid $($p2.ParentProcessId)"
Start-Sleep 1
"after end tree: ping=" + @(Get-Process ping -ErrorAction SilentlyContinue).Count + " (expect $($K-2))"
Get-Process ping -ErrorAction SilentlyContinue | Stop-Process -Force
Get-CimInstance Win32_Process -Filter "Name='cmd.exe' AND CommandLine LIKE '%ping -t%'" | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
Start-Sleep 1
cmd /c 'tasklist /fi "imagename eq ping.exe"'
H 'T3 services -> svchost'
$svc='Dnscache'
$q=sc.exe queryex $svc; $q
$pid_=[int](($q | Select-String 'PID').ToString().Split(':')[1].Trim())
cmd /c "tasklist /svc /fi `"PID eq $pid_`""
H 'T4 performance'
$env:NUMBER_OF_PROCESSORS
(Get-Process).Count
[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1)
H 'T5 network'
Get-NetAdapter | Select-Object Name, LinkSpeed
H 'T7/T8 priority'
$n=Start-Process notepad -PassThru; Start-Sleep 2
Get-Process -Id $n.Id | Select-Object Id, ProcessName, PriorityClass
(Get-Process -Id $n.Id).PriorityClass='AboveNormal'
Get-Process -Id $n.Id | Select-Object Id, ProcessName, PriorityClass
(Get-Process -Id $n.Id).PriorityClass='Normal'
Get-Process -Id $n.Id | Select-Object PriorityClass
Stop-Process -Id $n.Id -Force
H 'T10 memory/disk'
[math]::Round((Get-PSDrive C).Free / 1GB, 1)
H 'T11 listening ports'
Get-NetTCPConnection -State Listen -LocalPort 135 | Select-Object LocalPort, OwningProcess
cmd /c 'netstat -ano | findstr LISTENING | findstr :135'
H 'T12 cleanup check'
cmd /c 'tasklist /fi "imagename eq ping.exe"'
cmd /c 'tasklist /fi "imagename eq notepad.exe"'
