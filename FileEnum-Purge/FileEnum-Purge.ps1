# ASCII art banner
Write-Host @"
------
< - Deadly Data >
[+] FileEnum-Purge Script.
 ------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w | `
                ||     ||  ` ./$:Color Blind Key Bangers                     
"@

# Prompt user for the first two directories
$dir1 = Read-Host -Prompt 'Enter the path of the first directory'
$dir2 = Read-Host -Prompt 'Enter the path of the second directory'

# Get the folder names from both directories and write them into 'movies.txt'
Get-ChildItem -Path $dir1,$dir2 -Directory | ForEach-Object { 
    $_.Name | Out-File -Append 'movies.txt' 
    Write-Host "Found folder: $($_.Name)" -ForegroundColor Green
}
Write-Host "All subfolder names have been written to movies.txt" -ForegroundColor Yellow

# Prompt user for the third directory
$dir3 = Read-Host -Prompt 'Enter the path of the directory that will have its subfolders deleted'

# Load the names from 'movies.txt'
$movies = Get-Content 'movies.txt'

# Enumerate all subfolders in the third directory
Get-ChildItem -Path $dir3 -Directory | ForEach-Object -Parallel {
    # Check if the current subfolder's name is in 'movies.txt'
    if ($using:movies -contains $_.Name) {
        # Output the folder name to console and write it to 'removed.txt'
        $_.Name | Out-File -Append 'removed.txt'
        Write-Host "Deleting folder: $($_.Name)" -ForegroundColor Red

        # Remove the folder (and all its content)
        Remove-Item -Path $_.FullName -Recurse -Force
    } else {
        Write-Host "Keeping folder: $($_.Name)" -ForegroundColor Green
    }
}
Write-Host "All matching subfolders have been removed and their names written to removed.txt" -ForegroundColor Yellow
