# restore_tool

At the moment the tool just reports on what would be overwritten. To run it and show some basic output, give it an old and a new directory as input:

```Restore-Files.ps1 -BackupDataDir C:\Temp\Parent1\ -LiveDataDir C:\Temp\Parent2\```

NOTE: The folders within the two directories passed in have to match. Currently if there is a folder in one but not the other you'll probably see an error. I would suggest running it against folders at the bottom of your filesystem (i.e. ones with no child folders) rather than the top level

