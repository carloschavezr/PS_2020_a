Write-Host "Saving the following files" `
            "to the ""Backup"" folder:"

$BUCount = 0
$BUSize = 0

Get-ChildItem -File | Where-Object {
     $_.LastWriteTime -ge "2000-01-01" } | 
     ForEach-Object {
         Write-Host " Backup\$($_.Name)"
         $BUSize += $_.Length
         $BUCount ++
         
         $FileName = [io.path]::GetFileNameWithoutExtension( $_.Name )  # Getting just the base name
         $FileType = [io.path]::GetExtension( $_.Name )  ##
         $NewFileName = "Backup\$FileName" + "_" + $_.LastWriteTime.ToString("yyyy-MM-dd") + $FileType   ## 
        

         Copy-Item $_ $NewFileName }

Write-Host "Saved:" $BUCount "files," `
                    $BUSize.ToString("N0") "bytes"