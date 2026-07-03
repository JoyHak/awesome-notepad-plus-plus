#Requires AutoHotkey v2.0

LookupErrorCode()

LookupErrorCode() {
    query := A_Clipboard
    if (!query || StrLen(query) < 4) {
        MsgBox("Clipboard empty or too short. Copy hex code like 0xC000000D", "Error", "OK Icon!")
        return
    }

    query := RegExReplace(query, "\\s+", "")
    query := StrUpper(query)
    
    if (!RegExMatch(query, "^0[Xx][0-9A-F]{6,16}$")) {
        MsgBox("Invalid hex format: " . query . "`nExpected: 0xC000000D", "Invalid Format", "OK Icon!")
        return
    }
    
    apiKey := "f344dc86-7796-499f-be38-ec39a5414289"
    apiUrl := "https://www.magnumdb.com/api.aspx?q=" . query . "&key=" . apiKey
    
    try {
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", apiUrl, false)
        whr.setTimeouts(5000, 15000, 30000, 30000)
        whr.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")
        whr.Send()
        
        if (whr.Status != 200) {
            MsgBox("API Error: HTTP " . whr.Status . "`nResponse:`n" . SubStr(whr.ResponseText, 1, 500), "API Error", "OK Icon!")
            return
        }
        
        jsonText := whr.ResponseText
        results := ParseMagnumJson(jsonText, query)
        
        if (results.TotalHits = 0) {
            MsgBox("No results found for:`n" . query, "No Results", "OK Icon!")
            return
        }
        
        title := "MagnumDB Results: " . query . " (" . results.TotalHits . " hits)"
        msg := title . "`n`n"
        msg .= "All matches:`n`n"
        
        Loop results.Items.Length {
            item := results.Items[A_Index]
            msg .= Format("{:2}. {:25} ({})`n", A_Index, item.Title, item.FileName)
            msg .= "   " . item.DisplaySource . "`n"
            msg .= "   " . item.DisplayFilePath . "`n`n"
        }
        
        ShowResultsGUI(title, msg, results)
        
    } catch as err {
        MsgBox("Network error:`n" . err.Message, "Network Error", "OK Icon!")
    }
}

ParseMagnumJson(jsonText, query) {
    result := {Items: [], TotalHits: 0, OriginalText: query}
    
    if RegExMatch(jsonText, '"TotalHits":\s*(\d+)', &match)
        result.TotalHits := Integer(match[1])
    
    pos := 1
    while true {
        itemStart := InStr(jsonText, '{"Index":', false, pos)
        if (!itemStart)
            break
            
        braceCount := 1
        itemEnd := itemStart + 8
        while (braceCount > 0 && itemEnd <= StrLen(jsonText)) {
            char := SubStr(jsonText, itemEnd, 1)
            if (char = "{")
                braceCount++
            else if (char = "}")
                braceCount--
            itemEnd++
        }
        
        if (braceCount = 0) {
            itemJson := SubStr(jsonText, itemStart, itemEnd - itemStart - 1)
            item := ParseItemJson(itemJson)
            if (item.Has("Title"))
                result.Items.Push(item)
        }
        
        pos := itemEnd
    }
    
    return result
}

ParseItemJson(itemJson) {
    item := Map()
    
    fields := Map(
        "Title", '"Title":"([^"]+)"',
        "FileName", '"FileName":"([^"]+)"',
        "DisplaySource", '"DisplaySource":"([^"]{0,200})"',
        "DisplayFilePath", '"DisplayFilePath":"([^"]+)"'
    )
    
    for fieldName, pattern in fields {
        if RegExMatch(itemJson, pattern, &match) {
            value := match[1]
            value := RegExReplace(value, '\\\\""', '"')
            value := RegExReplace(value, "\\\\", "\\")
            item[fieldName] := value
        }
    }
    
    return item
}

ShowResultsGUI(title, msg, results) {
    ui := Gui("+Resize -MaximizeBox", "MagnumDB Results")
    ui.MarginX := 15
    ui.MarginY := 15
    
    ui.Add("Text", "x0 y10 w-1 Center +0x200", title).SetFont("s12 cBlue w700")
    
    edit := ui.Add("Edit", "x0 y50 w600 h350 ReadOnly VScroll Multi", msg)
    edit.SetFont("s10")
    
    btnPanel := ui.Add("GroupBox", "x0 y410 w600 h60", "Actions")
    ui.Add("Button", "xp+15 yp+25 w120 h28 Default", "Copy").OnEvent("Click", (*) => CopyResults(msg))
    ui.Add("Button", "x+10 w120 h28", "New Search").OnEvent("Click", (*) => (
        ui.Destroy(), 
        LookupErrorCode()
    ))
    ui.Add("Button", "x+10 w120 h28", "Close").OnEvent("Click", (*) => ui.Destroy())
    
    ui.Add("Text", "x450 yp-5 w140 Right", Format("{} hits • {} items", results.TotalHits, results.Items.Length))
    
    ui.Show("w620 h485")
}

CopyResults(msg) {
    A_Clipboard := msg
    ToolTip("Copied to clipboard!")
    SetTimer(() => ToolTip(), -2000)
}