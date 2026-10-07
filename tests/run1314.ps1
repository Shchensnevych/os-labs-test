$ErrorActionPreference='Continue'
[Console]::OutputEncoding=[Text.Encoding]::UTF8
$S='ivanenko'; $D="$env:PUBLIC\lab1314_$S"; $F="lab1314_$S"
function Hd($t){ Write-Host "`n===== $t" }
Hd 'T1 service/library/audit'
sc.exe query Schedule
sc.exe qc Schedule
(schtasks /query /fo csv /nh | Measure-Object -Line).Lines
cmd /c 'dir "%SystemRoot%\System32\Tasks" /ad /b'
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache" | Select-Object -First 5
Get-ScheduledTask | Where-Object { $_.TaskPath -notlike "\Microsoft\*" } | Select-Object TaskPath, TaskName, State, Author | Format-Table -AutoSize
"hidden: " + (Get-ScheduledTask | Where-Object { $_.Settings.Hidden }).Count
Hd 'T2 who_am_i direct'
New-Item -ItemType Directory -Force $D | Out-Null
Copy-Item "$PSScriptRoot\..\labs\1314\*.bat" $D -Force
cmd /c "`"$D\who_am_i.bat`" $S MAN"
Get-Content "$D\run.log"
Hd 'T3/T6 tasks: create T1_basic-like + SYSTEM + high via schtasks'
schtasks /create /tn "$F\T1_basic" /tr "`"$D\who_am_i.bat`" $S T1" /sc once /st 00:01 /f
schtasks /create /tn "$F\T8_system" /tr "`"C:\Users\Public\lab1314_$S\who_am_i.bat`" $S T8S" /sc once /st 00:01 /ru SYSTEM /f
schtasks /create /tn "$F\T8_high" /tr "`"$D\who_am_i.bat`" $S T8H" /sc once /st 00:01 /rl HIGHEST /f
schtasks /run /tn "$F\T1_basic"; schtasks /run /tn "$F\T8_system"; schtasks /run /tn "$F\T8_high"
Start-Sleep 8
Get-Content "$D\run.log"
Hd 'T7 cli + powershell'
schtasks /create /tn "$F\T9_cli" /tr "`"C:\Users\Public\lab1314_$S\who_am_i.bat`" $S T9" /sc once /st 00:01 /f
schtasks /query /tn "$F\T9_cli" /v /fo list | Select-Object -First 12
schtasks /run /tn "$F\T9_cli"; Start-Sleep 4
(Get-ScheduledTaskInfo -TaskPath "\$F\" -TaskName 'T9_cli').LastTaskResult
schtasks /change /tn "$F\T9_cli" /disable
(Get-ScheduledTask -TaskPath "\$F\" -TaskName 'T9_cli').State
schtasks /change /tn "$F\T9_cli" /enable
$a = New-ScheduledTaskAction -Execute "$env:PUBLIC\lab1314_$S\who_am_i.bat" -Argument "$S T10"
$t = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(3)
Register-ScheduledTask -TaskName "T10_ps" -TaskPath "\$F\" -Action $a -Trigger $t -Description "PS test" -Force | Out-Null
Start-ScheduledTask -TaskName "T10_ps" -TaskPath "\$F\"; Start-Sleep 4
Get-ScheduledTask -TaskPath "\$F\" | Get-ScheduledTaskInfo | Select-Object TaskName, LastRunTime, LastTaskResult, NextRunTime | Format-Table -AutoSize
Hd 'T8 export/import'
Export-ScheduledTask -TaskName 'T9_cli' -TaskPath "\$F\" | Out-File "$D\T9.xml" -Encoding unicode
Get-Content "$D\T9.xml" -TotalCount 20
([xml](Get-Content "$D\T9.xml" -Raw)).Task.Actions.Exec.Command
(Get-Content "$D\T9.xml" -Raw) -replace 'T9','T11' | Out-File "$D\T11.xml" -Encoding unicode
schtasks /create /tn "$F\T11_imported" /xml "$D\T11.xml" /f
schtasks /run /tn "$F\T11_imported"; Start-Sleep 4
Select-String -Path "$D\run.log" -Pattern 'T11' | ForEach-Object Line
Hd 'T9 diagnostics: exit code 7, missing file, event log'
wevtutil sl Microsoft-Windows-TaskScheduler/Operational /e:true
schtasks /create /tn "$F\T12_fail" /tr "`"$D\fail7.bat`"" /sc once /st 00:01 /f
schtasks /create /tn "$F\T13_missing" /tr "`"$D\no_such_file.bat`"" /sc once /st 00:01 /f
schtasks /run /tn "$F\T12_fail"; schtasks /run /tn "$F\T13_missing"; Start-Sleep 6
"T12 result: " + (Get-ScheduledTaskInfo -TaskPath "\$F\" -TaskName 'T12_fail').LastTaskResult + " (expect 7)"
"T13 result: " + (Get-ScheduledTaskInfo -TaskPath "\$F\" -TaskName 'T13_missing').LastTaskResult
schtasks /create /tn "$F\T13b_missing_exe" /tr "`"$D\nofile.exe`"" /sc once /st 00:01 /f
schtasks /run /tn "$F\T13b_missing_exe"; Start-Sleep 5
"T13b missing exe: " + ('0x{0:X}' -f [int64](Get-ScheduledTaskInfo -TaskPath "\$F\" -TaskName 'T13b_missing_exe').LastTaskResult) + " (lab claims 0x80070002)"
"T13 missing bat: " + ('0x{0:X}' -f [int64](Get-ScheduledTaskInfo -TaskPath "\$F\" -TaskName 'T13_missing').LastTaskResult)
Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-TaskScheduler/Operational"; Id=100,102,110,129,200,201; StartTime=(Get-Date).AddMinutes(-30)} | Select-Object TimeCreated, Id | Select-Object -First 12 | Format-Table -AutoSize
Hd 'T5 long_run via task (60 s)'
schtasks /create /tn "$F\T6_long" /tr "`"$D\long_run.bat`" $S" /sc once /st 00:01 /f
schtasks /run /tn "$F\T6_long"; Start-Sleep 70
cmd /c "find /c `"START`" `"$D\long.log`""
cmd /c "find /c `"END`" `"$D\long.log`""
Hd 'T10 backup_job'
New-Item -ItemType Directory -Force "$D\source" | Out-Null
1..5 | ForEach-Object { "File $_" | Out-File "$D\source\doc$_.txt" -Encoding ascii }
cmd /c "dir /b `"$D\source`" | find /c /v `"`""
cmd /c "`"$D\backup_job.bat`" $S"; "rc1=$LASTEXITCODE"
cmd /c "`"$D\backup_job.bat`" $S"; "rc2=$LASTEXITCODE"
Get-Content "$D\backup.log"
Hd 'cleanup'
cmd /c "schtasks /query /fo csv /nh | find /c `"lab1314_$S`""
foreach($n in 'T1_basic','T6_long','T8_high','T8_system','T9_cli','T10_ps','T11_imported','T12_fail','T13_missing','T13b_missing_exe'){ schtasks /delete /tn "$F\$n" /f }
cmd /c "schtasks /query /fo csv /nh | find /c `"lab1314_$S`""
