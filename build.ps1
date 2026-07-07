$MyInvocation.MyCommand.Path | Split-Path -Parent | Set-Location

$sevenZip = "C:\Program Files\7-Zip\7z.exe"     # CLI version; 7zG is GUI version
$archive  = "Notepad++.7z"
$sourcePath = "Notepad++"

function Create-Archive {
    Copy-Item README.md $sourcePath -force
    Copy-Item LICENSE.txt $sourcePath -force

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
    
    Remove-Item "$archive" -force -ErrorAction SilentlyContinue
    &$sevenZip a "$archive" @params -- "$sourcePath"
}

function Get-ArchiveFiles {
    # list, output detailed info
    $lines = &$sevenZip l -slt -- $archive
    if ($LastExitCode -ne 0) {
        throw "Failed to list archive: $archive"
    }

    $result = [System.Collections.Generic.List[string]]@()
    foreach ($line in $lines) {
        if ($line.StartsWith('Path = ')) {
            $result.Add($line.Substring(7).Trim(" `r`n").Replace('\', '/'))
        }
    }

    if (!$result.Count) {
        throw "Archive is empty: $archive"
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
        $ignored | Sort-Object -unique | ForEach { Write-Host $_ }
    }
}

function Verify-Hash {
    $paths = @(
       "$archive", 
       "$sourcePath/notepad++.exe" 
    )
    
    Write-Host "`nSHA256 Digest:"
    foreach ($path in $paths) {
        Write-Host ((Get-FileHash $path SHA256).hash + '  ' + $path)
    }
}


# Create-Archive
Verify-Exclusions
Verify-Hash