function New-TestFiles {

    1..2 | ForEach-Object {

        $ParentDir = "C:\Temp\Parent$_"

        if (-not (Test-Path $ParentDir))
        {
            New-Item -ItemType Directory -Path $ParentDir 
        }

        1..3 | ForEach-Object {

            $ChildDir = "$ParentDir\Child$_"

            if (-not (Test-Path $ChildDir))
            {
                New-Item -ItemType Directory -Path $ChildDir
            }

            1..5 | ForEach-Object {
                    
                $Filename = "File$_.txt"

                $FilePath = "$ChildDir\$Filename"

                if (-not (Test-Path $FilePath)) {
                    New-Item -ItemType File -Path $FilePath
                }
            }
        }
    }
}


function Set-RandomTimestamps {

    $DateInPast = Get-Date -Date 1.6.21

    $TestFiles = Get-ChildItem C:\Temp\Parent2 -Filter *.txt -Recurse

    $TestFiles | ForEach-Object {

        $RandomInt = Get-Random -Minimum 1 -Maximum 10

        $IsOdd = $RandomInt % 2 -as [bool]

        if ($IsOdd) 
        {
            $_.LastWriteTime=$DateInPast
        }
    }
}


function Restore-Files {

    param 
    (
        [Parameter()]
        [string]
        $OldDir,

        [Parameter()]
        [string]
        $NewDir
    )

    Get-ChildItem -Path $OldDir -Recurse -File | ForEach-Object {

        $OldFile = $_.FullName
        
        $NewFile = $OldFile.Replace($OldDir, $NewDir)

        $OldFileDetails = Get-Item $OldFile
        
        $NewFileDetails = Get-Item $NewFile

        if ($NewFileDetails.LastWriteTime -le $OldFileDetails.LastWriteTime)
        {
            $Output = [PSCustomObject]@{OldFileName = $OldFileDetails.FullName
                                        OldFileLastWrite = $OldFileDetails.LastWriteTime
                                        NewFileName = $NewFileDetails.Fullname
                                        NewFileLastWrite = $NewFileDetails.LastWriteTime}
                                    
            Write-Output $Output
        }
    }
}



New-TestFiles

Set-RandomTimestamps

Restore-Files -OldDir C:\Temp\Parent1 -NewDir C:\Temp\Parent2


#Get-ChildItem C:\Temp\Parent* -Filter *.txt -Recurse | Remove-Item