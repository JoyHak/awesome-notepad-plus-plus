SetRegView 64
A_AllowMainWindow := true
DirExist(ROOT_DIR := RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoHotkey", "InstallDir", ""))
    ||  (ROOT_DIR := RegRead("HKEY_CURRENT_USER\SOFTWARE\AutoHotkey", "InstallDir", ""))

if !(ROOT_DIR && DirExist(ROOT_DIR))
    ROOT_DIR := "C:\Program Files\AutoHotkey"

VerifyAhk(exeinfo) {
    return exeinfo.HasProp('Description')
        && RegExMatch(exeinfo.Description, '^AutoHotkey.* (32|64)-bit', &m)
        && (m.1 != '64' || A_Is64bitOS)
        && !InStr(exeinfo.Path, '\AutoHotkeyUX.exe')
}

ReadHashes(path, filter?) {
    filemap := Map(), filemap.CaseSense := 0
    if !FileExist(path)
        return filemap
    csvfile := FileOpen(path, 'r')
    props := StrSplit(csvfile.ReadLine(), ',')
    while !csvfile.AtEOF {
        item := {}
        Loop Parse csvfile.ReadLine(), 'CSV'
            item.%props[A_Index]% := A_LoopField
        if IsSet(filter) && !filter(item)
            continue
        filemap[item.Path] := item
    }
    return filemap
}

GetAhkInfo(exe) {
    if !(verSize := DllCall("version\GetFileVersionInfoSize", "str", exe, "uint*", 0, "uint"))
        || !DllCall("version\GetFileVersionInfo", "str", exe, "uint", 0, "uint", verSize, "ptr", verInfo := Buffer(verSize))
        throw OSError()
    prop := {Path: exe}
    static Properties := {
        Version: 'FileVersion',
        Description: 'FileDescription',
        ProductName: 'ProductName'
    }
    for propName, infoName in Properties.OwnProps()
        if DllCall("version\VerQueryValue", "ptr", verInfo, "str", "\StringFileInfo\040904b0\" infoName, "ptr*", &p:=0, "uint*", &len:=0)
            prop.%propName% := StrGet(p, len)
        else throw OSError()
    if InStr(exe, '_UIA')
        prop.Description .= ' UIA'
    prop.Version := RegExReplace(prop.Version, 'i)-[a-z]{4,}\K(?=\d)|, ', '.') ; Hack-fix for erroneous version numbers (AutoHotkey_H v2.0-beta3-H...)
    return prop
}

GetAhk() {
    static files
    if IsSet(files) {
        return files
    }
    files := ReadHashes(ROOT_DIR '\UX\installed-files.csv',
        item => VerifyAhk(item) && (
            item.Path ~= '^(?!\w:|\\\\)' && item.Path := ROOT_DIR '\' item.Path,
            true
        ))
    if files.Count {
        return files
    }
    Loop Files ROOT_DIR '\AutoHotkey*.exe', 'R' {
        try {
            item := GetAhkInfo(A_LoopFilePath)
            if VerifyAhk(item)
                files[item.Path] := item
        }
    }
    return files
}