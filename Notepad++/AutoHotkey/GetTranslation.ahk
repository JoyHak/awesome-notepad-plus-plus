/* 
  Translates input text according to passed parameters. Parameters order doesn't matter.
  
  "text to translate" (can be anywhere, e.g. before / after the following parameters).
  Separate strings will be concatenated:
  .\GetTranslation.ahk "text to translate" "in" "the script" -> "text to translate in the script"
    
  from / source: source langugage (e.g. -from "en", /from "fr", -source 'auto'). Defaults to the "auto" 
  to / language: target langugage (e.g. -to "en", -language "fr" /language "fr"). Defaults to the "en"
  translate: return translated text (multiline if source is multiline). Enabled by default.
  variants:  show the menu with translation variants. Returns selected item.
  
  Examples:
  .\GetTranslation.ahk "今日の天気はとても良いです"
  .\GetTranslation.ahk "今日の天気はとても良いです" -to "en"
  
  .\GetTranslation.ahk -from "de" "schöne Blume" -to "fr" -variants
  .\GetTranslation.ahk /variants "test" /to "fr"
  .\GetTranslation.ahk "test" /translate /variants 
  
  NppExec:
  $(NPP_DIRECTORY)\AutoHotkey\GetTranslation.exe -translate -from "auto" -to "en" "$(SELECTED_TEXT)"
*/

#Requires AutoHotkey v2
#ErrorStdOut
#Warn All, StdOut
#Include "%A_ScriptDir%\Translate.ahk"

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

; Parse args ──────────────────────────────────────────────────────────────────────

A_Args.from      := "auto"
A_Args.to        := "en"
A_Args.variants  := false
A_Args.translate := false
A_Args.text      := ""

while A_Args.length {
    NextArgValue() {
        if !A_Args.Length {
            output("Parameter error: Missing value for `"" arg "`".")
            ExitApp 1
        }
        return A_Args.RemoveAt(1)
    }
        
    arg := NextArgValue()
    if !(SubStr(arg,1,2) ~= '[\/-]\w') {
        A_Args.text .= arg " "
        continue
    }

    arg := Trim(arg, "/-`t`"`' ")
    switch arg, false { ; case-insensitive comparison            
        case "from", "source":
            A_Args.from := NextArgValue()
        case "to", "language":
            A_Args.to := NextArgValue()
        case "variants":
            A_Args.variants := true
        case "translate":    
            A_Args.translate := true                
        default:
            if A_Args.text {
                A_Args.translate := true 
                continue
            }
            
            output("Parameter error: Unknown parameter `"" arg "`".")
    }
    
} else {
    output("Parameter error: " A_ScriptName " requires at least one parameter")
    ExitApp 1
}

; Translate ──────────────────────────────────────────────────────────────────────

if !(A_Args.text)
    ExitApp 0
    
translated := GoogleTranslate(Trim(A_Args.text, "`r`n`t "), A_Args.from, A_Args.to, &variants := "")
if (A_Args.translate || !A_Args.variants)
    output(translated)

if A_Args.variants {
    m := Menu()

    loop parse, variants, "`n" {    
        ; Add digit 1-9 and underscore it. 
        ; If greater than 9, underscore first item letter
        prefix := "&"
        if (A_Index < 10)
            prefix .= A_Index " "
            
        m.Add(prefix . A_LoopField, output.bind(A_LoopField))
    }

    m.Show()
}