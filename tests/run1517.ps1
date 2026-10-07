$ErrorActionPreference='Continue'
[Console]::OutputEncoding=[Text.Encoding]::UTF8
$S='ivanenko'; $N=7; $H='example.com'
function Hd($t){ Write-Host "`n===== $t" }
function Cnt($d){ (netsh advfirewall firewall show rule name=all dir=$d | Select-String -SimpleMatch '------------------------------' | Measure-Object).Count }
Hd 'T1 state'
netsh advfirewall show allprofiles state
sc.exe query mpssvc | Select-String STATE
sc.exe query bfe | Select-String STATE
netsh advfirewall show currentprofile | Select-Object -First 4
Hd 'T2 policy + baseline'
netsh advfirewall show allprofiles firewallpolicy
$Ain=Cnt in; $Aout=Cnt out; "A_in=$Ain A_out=$Aout"
Hd 'T3 backup'
$w="$env:USERPROFILE\lab1517_$S"; New-Item -ItemType Directory -Force $w | Out-Null
netsh advfirewall export "$w\fw_backup.wfw"
Get-Item "$w\fw_backup.wfw" | Select-Object Name, Length
Hd 'T4 outbound port 80 for powershell only'
"before: 80=" + (Test-NetConnection $H -Port 80 -InformationLevel Quiet -WarningAction SilentlyContinue) + " 443=" + (Test-NetConnection $H -Port 443 -InformationLevel Quiet -WarningAction SilentlyContinue)
netsh advfirewall firewall add rule name="FW_${S}_ps80" dir=out action=block protocol=TCP remoteport=80 program="$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
"with rule: 80=" + (Test-NetConnection $H -Port 80 -InformationLevel Quiet -WarningAction SilentlyContinue) + " (expect False) 443=" + (Test-NetConnection $H -Port 443 -InformationLevel Quiet -WarningAction SilentlyContinue) + " (expect True)"
"curl.exe http 80 (other program, expect 200/301): " + (curl.exe -s -o NUL -m 15 -w "%{http_code}" "http://$H")
netsh advfirewall firewall set rule name="FW_${S}_ps80" new enable=no
"rule disabled: 80=" + (Test-NetConnection $H -Port 80 -InformationLevel Quiet -WarningAction SilentlyContinue) + " (expect True)"
Hd 'T5 ICMP'
cmd /c "ping -n 2 -w 1500 8.8.8.8"; "base errorlevel=$LASTEXITCODE"
netsh advfirewall firewall add rule name="FW_${S}_icmp" dir=out action=block protocol=icmpv4:8,any
cmd /c "ping -n 2 -w 1500 8.8.8.8"; "with rule errorlevel=$LASTEXITCODE (expect 1, General failure)"
cmd /c "ping -n 2 127.0.0.1"; "loopback errorlevel=$LASTEXITCODE (expect 0)"
netsh advfirewall firewall set rule name="FW_${S}_icmp" new enable=no
cmd /c "ping -n 2 -w 1500 8.8.8.8"; "icmp rule off errorlevel=$LASTEXITCODE"
Hd 'T6 inbound rule with scope'
netsh advfirewall firewall add rule name="FW_${S}_in" dir=in action=allow protocol=TCP localport=$(5000+$N) profile=private remoteip=10.20.$N.0/24
netsh advfirewall firewall show rule name="FW_${S}_in" verbose
netsh advfirewall firewall set rule name="FW_${S}_in" new enable=no
netsh advfirewall firewall show rule name="FW_${S}_in" verbose | Select-String -Pattern 'Enabled'
Hd 'T7 logging'
netsh advfirewall show currentprofile logging
netsh advfirewall set currentprofile logging droppedconnections enable
netsh advfirewall firewall set rule name="FW_${S}_ps80" new enable=yes
"log test 80=" + (Test-NetConnection $H -Port 80 -InformationLevel Quiet -WarningAction SilentlyContinue)
Start-Sleep 5
1..3 | ForEach-Object { Test-NetConnection $H -Port 80 -InformationLevel Quiet -WarningAction SilentlyContinue | Out-Null }
$lf="$env:SystemRoot\System32\LogFiles\Firewall"
"log dir:"; Get-ChildItem $lf -ErrorAction SilentlyContinue | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
Start-Sleep 40
"log dir after 40s:"; Get-ChildItem $lf -ErrorAction SilentlyContinue | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
"log tail:"; Get-Content "$lf\pfirewall.log" -Tail 8 -ErrorAction SilentlyContinue
cmd /c 'findstr /c:"DROP TCP" "%SystemRoot%\System32\LogFiles\Firewall\pfirewall.log" | findstr /c:" 80 "'
Get-WinEvent -LogName 'Microsoft-Windows-Windows Firewall With Advanced Security/Firewall' -MaxEvents 15 -ErrorAction SilentlyContinue | Select-Object TimeCreated, Id, @{n='Msg';e={$_.Message.Split("`n")[0]}} | Format-Table -AutoSize
netsh advfirewall firewall set rule name="FW_${S}_ps80" new enable=no
netsh advfirewall set currentprofile logging droppedconnections disable
Hd 'T8 cleanup + verify'
netsh advfirewall firewall delete rule name="FW_${S}_ps80"
netsh advfirewall firewall delete rule name="FW_${S}_icmp"
netsh advfirewall firewall delete rule name="FW_${S}_in"
Start-Sleep 2
"events after deletes:"; Get-WinEvent -LogName 'Microsoft-Windows-Windows Firewall With Advanced Security/Firewall' -MaxEvents 8 -ErrorAction SilentlyContinue | ForEach-Object { "$($_.Id) $($_.Message.Split([char]10)[0])" }
"left: " + ((netsh advfirewall firewall show rule name=all | Select-String "FW_$S" | Measure-Object).Count) + " (expect 0)"
"counts now in=$(Cnt in) out=$(Cnt out) baseline in=$Ain out=$Aout"
"after: 80=" + (Test-NetConnection $H -Port 80 -InformationLevel Quiet -WarningAction SilentlyContinue)
netsh advfirewall show allprofiles state
netsh advfirewall show allprofiles firewallpolicy
