# SanDisk USB Diagnose fuer Windows 11
$ErrorActionPreference='SilentlyContinue'
$stamp=Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
$out=Join-Path ([Environment]::GetFolderPath('Desktop')) ('SanDisk-Diagnose_'+$stamp+'.txt')
function S($t,$d){Add-Content $out ('===== '+$t+' =====');$d|Out-String -Width 300|Add-Content $out}
'SanDisk / USB Diagnose - Windows 11'|Set-Content $out
('Erstellt: '+(Get-Date))|Add-Content $out
'Das Skript uebertraegt keine Daten.'|Add-Content $out
$c=Get-ComputerInfo
S 'WINDOWS / COMPUTER' ($c|Select WindowsProductName,WindowsVersion,OsBuildNumber,CsManufacturer,CsModel,CsSystemType,BiosManufacturer,BiosSMBIOSBIOSVersion)
S 'MAINBOARD' (Get-CimInstance Win32_BaseBoard|Select Manufacturer,Product,Version)
$u=Get-PnpDevice -PresentOnly|Where-Object {$_.Class -eq 'USB'}
S 'USB-CONTROLLER UND USB-GERAETE' ($u|Select Status,FriendlyName,InstanceId|Format-Table -AutoSize)
$d=Get-Disk
S 'LAUFWERKE' ($d|Select Number,FriendlyName,SerialNumber,@{N='Groesse_GB';E={[math]::Round($_.Size/1GB,2)}},BusType,OperationalStatus,HealthStatus,PartitionStyle|Format-Table -AutoSize)
S 'PHYSISCHE DATENTRAEGER' (Get-PhysicalDisk|Select FriendlyName,SerialNumber,MediaType,@{N='Groesse_GB';E={[math]::Round($_.Size/1GB,2)}},BusType,HealthStatus,OperationalStatus|Format-Table -AutoSize)
S 'PARTITIONEN' (Get-Partition|Select DiskNumber,PartitionNumber,DriveLetter,@{N='Groesse_GB';E={[math]::Round($_.Size/1GB,2)}},Type|Format-Table -AutoSize)
S 'VOLUMES' (Get-Volume|Select DriveLetter,FileSystemLabel,FileSystem,@{N='Groesse_GB';E={[math]::Round($_.Size/1GB,2)}},HealthStatus,OperationalStatus|Format-Table -AutoSize)
S 'GERAETE MIT FEHLERSTATUS' (Get-PnpDevice -PresentOnly|Where-Object {$_.Status -ne 'OK'}|Select Status,Class,FriendlyName,InstanceId|Format-Table -AutoSize)
$x=$u|Where-Object {$_.FriendlyName -match 'xHCI|USB 3|USB3'};$ud=$d|Where-Object {$_.BusType -eq 'USB'};$sd=$d|Where-Object {$_.FriendlyName -match 'SanDisk|Extreme'}
Add-Content $out '===== KURZAUSWERTUNG ====='
Add-Content $out ('USB 3.x/xHCI Controller erkennbar: '+$(if($x){'JA'}else{'NICHT EINDEUTIG ERKANNT'}))
Add-Content $out ('USB-Datentraeger erkannt: '+$(if($ud){'JA'}else{'NEIN'}))
Add-Content $out ('SanDisk/Extreme erkannt: '+$(if($sd){'JA'}else{'NEIN'}))
Add-Content $out 'Hinweis: Die Stromabgabe des konkreten USB-C-Ports kann mit Windows-Bordmitteln nicht verlaesslich gemessen werden.'
Write-Host ('FERTIG: '+$out) -ForegroundColor Green
Start-Process notepad.exe $out
