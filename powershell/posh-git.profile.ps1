$powershellPath = (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
Import-Module (Join-Path $powershellPath 'posh-git')

# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-VcsStatus
    Write-Host

    $pathPrompt = ""
    if ($PWD -eq $env:HOME) {
        $pathPrompt = "~"
    } else {
        $pathPrompt = (Split-Path -Leaf $PWD)
    }

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "[$pathPrompt] "
}

$GitPromptSettings.BeforeText = '['
$GitPromptSettings.AfterText = ']'
