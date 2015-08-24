. posh-git.profile.ps1

function LoadSolution {
    $matchingFiles = Get-ChildItem (Get-Location).Path *.sln
    if ($matchingFiles.Length -gt 0) {
        $slnFile = Join-Path -Path (Get-Location).Path -ChildPath $matchingFiles[0]
        
        Write-Host "Loading solution: $slnFile"
        Invoke-Expression $slnFile
    } else {
        Write-Error "No solution files found."
    }
}

Set-Alias -Name sln -Value LoadSolution

function Sublime($path) {
    & "C:\Program Files\Sublime Text 2\sublime_text.exe" $path
}

Set-Alias -Name slime -Value Sublime
Set-Alias -Name subl -Value Sublime

function PrintWorkingDirectory {
    Write-Host $PWD
}

rm alias:pwd -ea SilentlyContinue
Set-Alias -Name pwd -Value PrintWorkingDirectory

function Append-Path ($path) {
    if ($env:PATH -like "*$path*") { return }

    if ($env:PATH -notlike '*;') { $env:PATH += ';' }
    $env:PATH += $path + ';'
}

# Add current directory to path
Append-Path '.'

# Delete the stupid CURL alias
rm alias:curl -ea SilentlyContinue
