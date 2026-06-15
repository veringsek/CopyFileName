#Requires AutoHotkey v2.0

; 只在檔案總管（Explorer）內生效
#HotIf WinActive("ahk_class CabinetWClass")

^+c:: {
    ; 備份目前的剪貼簿內容
    OldClipboard := ClipboardAll()
    A_Clipboard := "" ; 清空剪貼簿以進行偵測

    ; 觸發 Ctrl+C 來複製檔案路徑
    Send("^c")
    
    ; 等待剪貼簿接收到資料（最多等待 0.5 秒）
    if !ClipWait(0.5) {
        A_Clipboard := OldClipboard ; 失敗則還原舊剪貼簿
        return
    }

    ; 取得複製的檔案路徑
    SelectedPath := A_Clipboard
    
    ; 拆解路徑，只取檔名（不含副檔名）
    SplitPath(SelectedPath, &FullName, &Dir, &Ext, &FileName)

    ; 將純檔名放回剪貼簿
    A_Clipboard := FileName

    ; 選擇性彈出提示（若不需要可以把下面這行刪除）
    ToolTip("已複製檔名: " . FileName)
    SetTimer(() => ToolTip(), -1000) ; 1 秒後自動消失
}

^!+c:: {
    ; 備份目前的剪貼簿內容
    OldClipboard := ClipboardAll()
    A_Clipboard := "" ; 清空剪貼簿以進行偵測

    ; 觸發 Ctrl+C 來複製檔案路徑
    Send("^c")
    
    ; 等待剪貼簿接收到資料（最多等待 0.5 秒）
    if !ClipWait(0.5) {
        A_Clipboard := OldClipboard ; 失敗則還原舊剪貼簿
        return
    }

    ; 取得複製的檔案路徑
    SelectedPath := A_Clipboard
    
    ; 拆解路徑，只取檔名（不含副檔名）
    SplitPath(SelectedPath, &FullName, &Dir, &Ext, &FileName)

    ; 將純檔名放回剪貼簿
    A_Clipboard := FullName

    ; 選擇性彈出提示（若不需要可以把下面這行刪除）
    ToolTip("已複製檔名: " . FullName)
    SetTimer(() => ToolTip(), -1000) ; 1 秒後自動消失
}

#HotIf