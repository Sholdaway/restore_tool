function Generate-Files {

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


Generate-Files
