# Endpoint_Inventory_Audit.ps1
# Portfolio lab script - collects endpoint inventory and basic health information.
# Designed for a Windows workstation.

Write-Host "=== IT Endpoint Inventory & Audit ==="

$computer = $env:COMPUTERNAME
$user = $env:USERNAME

$cs = Get-CimInstance Win32_ComputerSystem
$bios = Get-CimInstance Win32_BIOS
$os = Get-CimInstance Win32_OperatingSystem
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$result = [PSCustomObject]@{
    ComputerName = $computer
    CurrentUser = $user
    Manufacturer = $cs.Manufacturer
    Model = $cs.Model
    SerialNumber = $bios.SerialNumber
    OperatingSystem = $os.Caption
    OSVersion = $os.Version
    RAM_GB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 2)
    C_Free_GB = [math]::Round($disk.FreeSpace / 1GB, 2)
    IPAddress = (
        Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
        Where-Object {$_.IPAddress -notlike "169.254*" -and $_.IPAddress -ne "127.0.0.1"} |
        Select-Object -First 1 -ExpandProperty IPAddress
    )
    DefaultGateway = (
        Get-NetRoute -DestinationPrefix "0.0.0.0/0" -ErrorAction SilentlyContinue |
        Sort-Object RouteMetric |
        Select-Object -First 1 -ExpandProperty NextHop
    )
    AuditTimestamp = Get-Date
}

$result | Format-List

Write-Host "`n[DNS Test]"
try {
    Resolve-DnsName "www.microsoft.com" -ErrorAction Stop |
        Select-Object -First 2 Name, Type, IPAddress
} catch {
    Write-Host "DNS resolution failed."
}

Write-Host "`n[Recent Critical / Error Events]"
Get-WinEvent -FilterHashtable @{
    LogName='System'
    Level=1,2
    StartTime=(Get-Date).AddHours(-24)
} -ErrorAction SilentlyContinue |
Select-Object -First 10 TimeCreated, Id, ProviderName, Message

# Optional CSV output for an equipment audit
$result | Export-Csv -Path ".\endpoint_inventory.csv" -NoTypeInformation
Write-Host "`nInventory exported to endpoint_inventory.csv"
