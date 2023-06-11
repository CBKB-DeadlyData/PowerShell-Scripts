# Prompt user for the first two directories
$dir1 = Read-Host -Prompt 'Enter the path of the first directory'
$dir2 = Read-Host -Prompt 'Enter the path of the second directory'

# Get the folder names from both directories and write them into 'movies.txt'
Get-ChildItem -Path $dir1,$dir2 -Directory | ForEach-Object { $_.Name | Out-File -Append 'movies.txt' }
Write-Host "All subfolder names have been written to movies.txt"

# Prompt user for the third directory
$dir3 = Read-Host -Prompt 'Enter the path of the third directory'

# Load the names from 'movies.txt'
$movies = Get-Content 'movies.txt'

# Enumerate all subfolders in the third directory
Get-ChildItem -Path $dir3 -Directory | ForEach-Object -Parallel {
    # Check if the current subfolder's name is in 'movies.txt'
    if ($using:movies -contains $_.Name) {
        # Output the folder name to console and write it to 'removed.txt'
        $_.Name | Write-Host
        $_.Name | Out-File -Append 'removed.txt'
        
        # Remove the folder (and all its content)
        Remove-Item -Path $_.FullName -Recurse -Force
    }
}
Write-Host "All matching subfolders have been removed and their names written to removed.txt"
