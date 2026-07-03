/* 
Case-insensitive search for a value by key in the specified ini file:
IniReadFuzzy [filepath] [key]

Ini must contain key-value pair in UTF encoding:
key=value
ABM_QUERYPOS=0x2
achDELNODE="DelNode"

Examples:
IniReadFuzzy win32.ini ABM_QUERYPOS => 0x2
IniReadFuzzy win32.ini achDELNODE => DelNode

If a key does not exist, finds all values corresponding to parts of the specified key:
IniReadFuzzy win32.ini QUERYPOS => 0x2

IniReadFuzzy win32.ini DELNODE =>
    achDELNODE = "DelNode"
    achDELNODERUNDLL32 = "DelNodeRunDLL32"
    
IniReadFuzzy win32.ini ACLUI =>
    ACLUIAPI = DECLSPEC_IMPORT
    CFSTR_ACLUI_SID_INFO_LIST = "CFSTR_ACLUI_SID_INFO_LIST"
    
IniReadFuzzy shell.ini Downloads =>
    shell:CommonDownloads = %Public%\Downloads
    shell:downloads = %UserProfile%\Downloads
    
The search is performed in both directions:
IniReadFuzzy shell.ini "%Public%\Downloads"      => shell:CommonDownloads
IniReadFuzzy shell.ini "%UserProfile%\Downloads" => shell:downloads

IniReadFuzzy clsid.ini ECDB0924-4208-451E-8EE0-373C0956DE16 => Work Folders
IniReadFuzzy clsid.ini Work Folders => ECDB0924-4208-451E-8EE0-373C0956DE16

IniReadFuzzy win32.ini CFSTR_MIME_POSTSCRIPT => application/postscript
IniReadFuzzy win32.ini "application/postscript" => CFSTR_MIME_POSTSCRIPT
*/

#Requires AutoHotkey v2
#ErrorStdOut
#Warn All, StdOut

; Functions ──────────────────────────────────────────────────────────────────────

output(msg, *) {
    try {
        FileAppend msg "`n", "*"
    } catch {
        MsgBox msg, "Result from clipboard"
        A_Clipboard := msg
    }
}

OnError exerror
exerror(ex, *) {
    output(ex.what " error: " ex.message "`n" ex.extra)
    ExitApp 1
}

_IniRead(filepath, needle) {
    if !FileExist(filepath)
        throw ValueError("File not found", "ini path", filepath)
    
    needle := Trim(needle, " `s`t`r`n`"`'(){}[]?")
    
    result := ""
    count  := 0
    
    loop read, filepath {
        pos := InStr(A_LoopReadLine, "=", , -1)
        if pos {
            key   := SubStr(A_LoopReadLine, 1, pos - 1)
            value := SubStr(A_LoopReadLine, pos + 1)
            
            ; Exact match
            if (key = needle)
                return value
            if (value = needle)
                return key
            
            ; Fuzzy match
            if InStr(key, needle) { 
                result .= key " = " value "`n"
                count++
            } else if InStr(value, needle) {  
                result .= value " = " key "`n"
                count++
            }
        } else if InStr(A_LoopReadLine, needle) {            
            result .= A_LoopReadLine "`n"
            count++
        }
    }
    
    if !(count && result)
        throw TargetError(needle " not found in `"" filepath "`"", "value")
    
    result := RTrim(result, " `n")
    if (count > 1)
        return "Found multiple matches:`n" result
    
    pos := InStr(result, "=", , -1)
    if pos {
        ; One-line result, remove "key = " and return value only
        return Trim(SubStr(result, pos + 1))
    }
        
    return result
}

; Read file ──────────────────────────────────────────────────────────────────────

if GetKeyState("Shift")
    output("Shift")
    
output(_IniRead(A_Args[1], A_Args[2]))
