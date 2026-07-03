$MyInvocation.MyCommand.Path | Split-Path -Parent | Set-Location

$sevenZip   = "C:\Program Files\7-Zip\7z.exe"     # CLI version; 7zG is GUI version
$targetPath = "Notepad++.7z"

function Create-Archive {
    $params = @(
        '-t7z',         # .7z archive
        '-m0=PPMd',     # PPMD compression (best for text/source code files)
        '-mx=9',        # Max compression level
        '-mmem=31',     # Max memory usage (2GB for performance)
        '-ms=e',        # Solid (files are grouped together, smaller size)
        '-x@.gitignore' # Exclude by masks from .gitignore
    )

    &$sevenZip a "$targetPath" @params -- Notepad++ README.md LICENSE.txt
}

function Get-ArchiveFiles {
    # list, output detailed info
    $lines = &$sevenZip l -slt -- $targetPath
    if ($LastExitCode -ne 0) {
        throw "Failed to list archive: $targetPath"
    }

    $result = [System.Collections.Generic.List[string]]@()
    foreach ($line in $lines) {
        if ($line.StartsWith('Path = ')) {
            $result.Add($line.Substring(7).Trim(" `r`n").Replace('\', '/'))
        }
    }

    if (!$result.Count) {
        throw "Archive is empty: $targetPath"
    }

    return $result
}

function Verify-Exclusions {
    $ignored  = git check-ignore Get-ArchiveFiles
    $exitCode = $LastExitCode

    if ($exitCode -ne 0 -and $exitCode -ne 1) {
        throw "git check-ignore failed"
    }

    if ($ignored.Count -gt 0) {
        Write-Host "Archive contains excluded files" -f red
        $ignored | Sort-Object -Unique | ForEach-Object { Write-Host $_ }
    } else {
        Write-Host "Archive does not contain excluded files" -f green
    }
}


Create-Archive
Verify-Exclusions