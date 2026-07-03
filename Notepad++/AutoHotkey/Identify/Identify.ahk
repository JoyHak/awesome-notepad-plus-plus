;@Ahk2Exe-ConsoleApp

#Requires AutoHotkey v2.0
#ErrorStdOut
#Warn All, StdOut
#SingleInstance Off
#NoTrayIcon

#Include libs\Utilities.ahk
#Include libs\GetVersion.ahk
#Include libs\GetAhk.ahk

LocateAhk(require, prefer:='!UIA, 64, !ANSI') {
    best := '', bestscore := 0, cPrefMap := Map()
    for ,f in GetAhk() {
        try {
            ; Check requirements first
            fMajor := GetIntegerVersion(f.Version)
            Loop Parse require, ",", " " {
                if A_LoopField = ""
                    continue
                if m := ParseRequires(A_LoopField) {
                    if !VerCompare(f.Version, (m.op ? '' : '>=') A_LoopField) {
                        continue 2
                    }
                    if !m.op && fMajor > m.major {
                        continue 2
                    }
                }
                else if !matchPref(f.Description, A_LoopField) {
                    continue 2
                }
            }
            ; Determine additional user preferences based on major version
            if !(cPref := cPrefMap.Get(fMajor, 0)) {
                section := 'Launcher\v' fMajor
                cPref := ""
                cPref := {
                    V: cPref ? '=' cPref ',' : '<0,',
                    D: ',' ((A_Is64bitOS ? "64," : "") "!ANSI")
                    .  ',' '!UIA'
                }
                cPrefMap.Set(fMajor, cPref)
            }
            ; Calculate preference score
            fscore := 0
            Loop Parse cPref.V prefer cPref.D, ",", " " {
                if A_LoopField = ""
                    continue
                fscore <<= 1
                if !(A_LoopField ~= '^[<>=]' ? VerCompare(f.Version, A_LoopField)
                    : matchPref(f.Description, A_LoopField))
                    continue
                fscore |= 1
            }
            ; Prefer later version if all else matches.  If version also matches, prefer later files,
            ; as enumeration order is generally AutoHotkey.exe, ..A32.exe, ..U32.exe, ..U64.exe.
            if bestscore < fscore
                || bestscore = fscore && VerCompare(f.Version, best.Version) >= 0
                bestscore := fscore, best := f
        }
        catch as e {
            trace "Error: " type(e) " checking file " A_LoopFileName ": " e.message
            trace "" e.file ":" e.line
        }
    }    
    return best
    matchPref(desc, pref) => SubStr(pref,1,1) != "!" ? InStr(desc, pref) : !InStr(desc, SubStr(pref,2))
}

GetPath(ScriptPath) {
    code := FileRead(ScriptPath, 'UTF-8')
    require := prefer := rule := exe := ""
    if RegExMatch(code, 'im)^[ `t]*#Requires[ `t]+AutoHotkey[ `t]+([^;`r`n]*?)[ `t]*(?:;[ `t]*prefer[ `t]+([^;`r`n\.]+))?(?:$|;)', &m) {
        require := RegExReplace(m.1, '[^\s,]\K\s+(?!$)', ",")
        prefer := RegExReplace(m.2, '[^\s,]\K\s+(?!$)', ",")
        rule := "#Requires"
    }
    else {
        i := IdentifyBySyntax(code)
        if i.v
            require := String(i.v)
        rule := i.r
        if rule = "error"
            trace "Syntax detection has failed due to an error in the launcher.`n`n" Type(i.err) ": " i.err.Message " " i.err.Extra "`n`n"
                . "Character index " i.pos "`n" SubStr(code, i.pos, 50)
    }
    if !(hasv := RegExMatch(require, '(^|,)\s*(?!(32|64)-bit)[<>=]*v?\d')) {
        ; No version specified or detected
        if hasv := v := "" {
            require .= (require=''?'':',') v
        }
    }
    if !hasv {
        exe := ChooseVersion(ScriptPath, require, prefer)
    } else {
        if !exe := LocateAhk(require, prefer) {
            return ierror(require, ScriptPath)
        }
    }
    try {
        trace exe.path
    } catch{
        ierror(require, ScriptPath)
    }
}

GetPath(A_Args.RemoveAt(1))