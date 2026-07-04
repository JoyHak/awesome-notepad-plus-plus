$MyInvocation.MyCommand.Path | Split-Path -Parent | Set-Location

$sevenZip   = "C:\Program Files\7-Zip\7z.exe"     # CLI version; 7zG is GUI version
$targetPath = "Notepad++.7z"

function Create-Archive {
    Copy-Item README.md Notepad++ -force
    Copy-Item LICENSE.txt Notepad++ -force

    $params = @(
        '-t7z',         # .7z archive
        '-m0=LZMA2',    # LZMA2 compression
        '-mx=9',        # Max compression level
        '-md=96m',      # Dictionary 96mb
        '-ms=on',       # Solid (files are grouped together, smaller size)
        '-mqs=on',      # Sort by extensions (better compression)
        '-mmt=on',      # Multi-threading
        '-xr@.gitignore'  # Exclude by masks from .gitignore
    )
    
    Remove-Item "$targetPath" -force -ErrorAction SilentlyContinue
    &$sevenZip a "$targetPath" @params -- Notepad++
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
    $ignored  = Get-ArchiveFiles | git check-ignore --stdin
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