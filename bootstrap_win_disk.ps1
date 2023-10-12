$disks = Get-Disk | Where-Object PartitionStyle -eq 'RAW'

foreach ($disk in $disks) {
  # Output the disk number
  Write-Host "b $($disk.Number) with MBR partition style"
  # Initialize the disk with MBR partition style
  Initialize-Disk -Number $disk.Number -PartitionStyle MBR -PassThru |
  # Create a new partition on the disk, do not assign a drive letter, and use maximum size
  New-Partition -AssignDriveLetter -UseMaximumSize |
  # Format the partition with NTFS
  Format-Volume -FileSystem NTFS -NewFileSystemLabel "Data" -Confirm:$false
}

# Rewrite the letter of the partition to custom letter, you can choose which letter do you like, you can set a letters according to the number of partitions
Write-Host "Initialization and formatting complete."
if (!(Test-Path ("L:\"))){
  Set-Partition -DriveLetter D -NewDriveLetter L
}
if (!(Test-Path ("I:\"))){
  Set-Partition -DriveLetter E -NewDriveLetter I
}
