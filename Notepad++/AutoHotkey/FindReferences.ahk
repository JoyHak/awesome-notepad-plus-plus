; Searches for specified word references in Notepad++

;@Ahk2Exe-ConsoleApp
#Requires AutoHotkey v2.0
#ErrorStdOut
#Warn All, StdOut
#SingleInstance force
#NoTrayIcon
DetectHiddenWindows(true)

; Functions ──────────────────────────────────────────────────────────────────────

output(msg) {
    try
        FileAppend msg "`n", "*"
    catch
        A_Clipboard := msg
}

GetDlgItem(dialogId, controlId) => DllCall("GetDlgItem", "Ptr", dialogId, "Int", controlId, "Ptr")

ClickButton(id) {
    static BM_CLICK := 0x00F5
    SendMessage(BM_CLICK, 0, 0, id)
}

; Dialog ID ──────────────────────────────────────────────────────────────────────

title := "Find in Files ahk_exe Notepad++.exe"
loop 100 {
    if (dialogId := WinExist(title))
        break
    
    sleep 50
} 

if !dialogId {
    output(Format("Error: could not find a dialog with a title `"{}`". Dialog HWND: {}", title, dialogId))
    Exit
}

if (A_Args.Length < 1) {
    output("Error: " A_ScriptName " requires search keyword")
    Exit
}

; Set controls ──────────────────────────────────────────────────────────────────────

FindWhatId   := GetDlgItem(dialogId, 1601)
WholeWordId  := GetDlgItem(dialogId, 1603)
MatchCaseId  := GetDlgItem(dialogId, 1604)
RegExId      := GetDlgItem(dialogId, 1605)
WrapAroundId := GetDlgItem(dialogId, 1606)
FindAllId    := GetDlgItem(dialogId, 1656)

ControlSetText(Format("((^[ \t]*[;\/*])|[`"`'])\b{1}\b(*SKIP)(*FAIL)|[`"'].*{1}.*[`"'](*SKIP)(*FAIL)|\b{1}\b", A_Args[1]), FindWhatId)
ControlSetChecked(true, WholeWordId)
ControlSetChecked(true, MatchCaseId)
ControlSetChecked(true, WrapAroundId)
ControlSetChecked(true, RegExId)

ClickButton(FindAllId)

 
