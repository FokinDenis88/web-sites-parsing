#include "C:\Development\Projects\IT\Programming\!git-web\public\web-sites-parsing\web-browser-parsing-constants.au3"
;#include "Y:\web-browser-parsing-constants.au3"

;;Func SleepWithGlobalSpeed(Const $sleep_p)
;;Func HotkeyExit()
;Func SetHotKeyToExit()
;Func WinWaitActiveFixedTimeout(Const $title_p)
;Func BalanceX(Const $current_value)
;Func BalanceY(Const $current_value)
;Func WriteTextToFile(Const $file_path, Const $text, Const $open_mode)
;Func ReWriteTextToFile(Const $file_path, Const $text)
;Func SendCtrlPushed(Const $buttons)
;Func SendEnter()
;Func PageDownNSleep(Const $count = 1)
;Func CopyOperation()
;Func CopyOperationWithSleep()
;Func PastOperation()
;Func PastOperationWithSleep()
;Func PastTextFromClipboard(Const $text)
;Func FileExplorerFolderPathMouseClick()
;Func ChooseFileExplorerFolder(Const $asset_folder_p)
;Func ChangeFireFoxDefaultDownloadDirectory(Const $asset_folder_p)
;Func GetCopyBufferText()
;Func PutTextToCopyBuffer(Const $text = "")
;Func CopyTextRect(Const $x1, Const $y1, Const $x2, Const $y2)
;Func CopyTextWithShiftEnd(Const $x1, Const $y1)
;Func GetWebAddress()
;Func GetWebAddressNCloseWebInput()
;Func SetWebAddress(Const $web_address)
;Func SaveWebAddress(Const $asset_folder)
;Func StrToBool(Const $text)
;Func IniReadBool(Const $filename, Const $section, Const $key, Const $default)
;Func IniReadInt(Const $filename, Const $section, Const $key, Const $default)
;Func WaitSaveFileWindow(Const $title_class)
;Func ClickMenuSaveImageAs(Const $x1, Const $y1)
;Func ClickNWaitMenuSaveImageAs(Const $x1, Const $y1, Const $title_class)
;Func ChooseFileForSavingImage(Const $asset_folder_p, Const $save_window_title_class)
;Func SwitchTab()
;Func CloseTab()
;Func ChangeWebSiteScale(Const $times, Const $plus_flag = False)
;Func UpdateTab(Const $sleep_time = $kWebSiteLoad)
;Func GoBackOnePage()
;Func GoBackOnePageNSleep(Const $sleep_time)
;Func GoForwardOnePage()
;Func GoForwardOnePageNSleep(Const $sleep_time)
;Func ResetWebSiteScale()
;Func PrepareTabDefault()
;Func CorrectNameForOS(ByRef $asset_name, Const $strange_characters = "")
;Func GetAssetNameRect(ByRef $asset_name, Const $x1, Const $y1, Const $x2, Const $y2, Const $strange_characters = "")
;Func GetAssetNameShiftEnd(ByRef $asset_name, Const $x1, Const $y1, Const $strange_characters = "")
;Func CreateAllAssetsDirFromIni(Const $ini_path, Const $ini_section, Const $download_folder_ini_key_name, Const $default_download_folder)
;Func CreateAssetFolder(Const $download_folder_path_p, Const $asset_name_p, ByRef $asset_folder_p, Const $duplicates)
;Func DownloadPreviewSnipSketch(Const $asset_folder_p, Const $x1, Const $y1, Const $x2, Const $y2)

Func Localization(Const $variable_name, Const $locale = $kCurrentLocale)
    If "kSaveLightShotImageAsTitleClass" == $variable_name Then
        If $kLocaleENG == $locale Then
            Return $kSaveLightShotImageAsTitleClassENG
        ElseIf $kLocaleRUS == $locale Then
            Return $kSaveLightShotImageAsTitleClassRUS
        EndIf
    EndIf

    If "kGoogleSearchTextEnding" == $variable_name Then
        If $kLocaleENG == $locale Then
            Return $kGoogleSearchTextEndingENG
        ElseIf $kLocaleRUS == $locale Then
            Return $kGoogleSearchTextEndingRUS
        EndIf
    EndIf
EndFunc

; Return correct mouse button, if buttons are switched
Func MouseClickSwitch(Const $button, Const $switch_flag = False)
    If False == $switch_flag Then
        Return $button
    Else
        If $MOUSE_CLICK_LEFT == $button Then
            Return $MOUSE_CLICK_RIGHT
        ElseIf $MOUSE_CLICK_RIGHT == $button Then
            Return $MOUSE_CLICK_LEFT
        EndIf
    EndIf
EndFunc

Func SleepWithGlobalSpeed(Const $sleep_p)
    Sleep($ScriptSpeedGlobal / 100 * $sleep_p)
EndFunc

Func HotkeyExit()
    Exit
EndFunc

Func SetHotKeyToExit()
    HotKeySet($kHotKeyToExit, "HotkeyExit")
EndFunc

Func WinWaitActiveFixedTimeout(Const $title_p)
    Return WinWaitActive($title_p, "", $kWinWaitActiveTimeout)
EndFunc


; Scipt must work with different resolutions. But coordinates in script are for original resolution. 
; Calculate Balanced value for another resolution
Func BalanceX(Const $current_value)
    Return ($current_value * (@DesktopWidth / $kOriginalResolutionX))
EndFunc

Func BalanceY(Const $current_value)
    Return ($current_value * (@DesktopHeight / $kOriginalResolutionY))
EndFunc

Func CorrectPosition(Const $pos, Const $max)
    ;MsgBox($MB_OK, "Check", "$pos = " & $pos & " $max = " & $max)
    If $pos < 0 Then 
        Return 0
    Else
        If $pos > $max Then 
            Return $max
        EndIf
    EndIf
    Return $pos
EndFunc

Func CorrectX(Const $pos)
    Return CorrectPosition($pos, $kOriginalResolutionX)
EndFunc

Func CorrectY(Const $pos, Const $click_taskbar = false)
    If $click_taskbar Then 
        Return CorrectPosition($pos, $kOriginalResolutionY)
    Else
        Return CorrectPosition($pos, $kOriginalResolutionY - $kTaskBarHeight)
    EndIf
EndFunc

Func WriteTextToFile(Const $file_path, Const $text, Const $open_mode)
    Local $hFile = FileOpen($file_path, $open_mode)
    If $hFile = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "An error occurred while openning file.")
        Return False
    EndIf
    FileWrite($hFile, $text)
    FileClose($hFile)
EndFunc

Func ReWriteTextToFile(Const $file_path, Const $text)
    WriteTextToFile($file_path, $text, $FO_OVERWRITE)
EndFunc

Func SendCtrlPushed(Const $buttons)
    Send("{CTRLDOWN}" & $buttons & "{CTRLUP}")
EndFunc

Func SendAltPushed(Const $buttons)
    Send("{ALTDOWN}" & $buttons & "{ALTUP}")
EndFunc

Func SendEnter()
    Send("{ENTER}")
EndFunc

Func LoopSend(Const $loops_count, Const $send_text, Const $sleep_time = 500)
    For $i = 0 To $loops_count - 1
        ;MsgBox($MB_OK, "Check", "Sending Page Down ")
        Send($send_text)
        SleepWithGlobalSpeed($sleep_time)
    Next
EndFunc

Func PageUpNSleep(Const $count = 1)
    LoopSend($count, "{PGUP}")
    SleepWithGlobalSpeed(1000)
EndFunc

Func PageDownNSleep(Const $count = 1)
    LoopSend($count, "{PGDN}")
    SleepWithGlobalSpeed(1000)
EndFunc

Func CopyOperation()
    Send($kCopyOperationText)
EndFunc

Func CopyOperationWithSleep()
    CopyOperation()
    SleepWithGlobalSpeed(250)
EndFunc

Func PastOperation()
    Send($kPastOperationText)
EndFunc

Func PastOperationWithSleep()
    PastOperation()
    SleepWithGlobalSpeed(250)
EndFunc

Func PastTextFromClipboard(Const $text)
    ClipPut($text)
    PastOperation()
    SleepWithGlobalSpeed(200)
EndFunc

Func FileExplorerFolderPathMouseClick()
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1585), BalanceY(50), 1, $kMouseSpeed) ; Folder select
    SleepWithGlobalSpeed(300)
EndFunc

Func FileExplorerFileNameMouseClick()
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1144), BalanceY(976), 1, $kMouseSpeed)
EndFunc

Func FileSaveReplaceDuplicates(Const $replace_duplicates = False, Const $cancel_x = $kButtonCancelX, Const $cancel_y = $kButtonCancelY, Const $window_title_class = $kSaveAsFileConfirmationTitleClass)
    SleepWithGlobalSpeed(1500)
    WinWaitActiveFixedTimeout($window_title_class)
    If WinActive($window_title_class) Then
        If False == $replace_duplicates  Then
            SendAltPushed("n")
            SleepWithGlobalSpeed(1000)
            MouseClick($MOUSE_CLICK_LEFT, BalanceX($cancel_x), BalanceY($cancel_y), 1, $kMouseSpeed)    ; Cancel
            SleepWithGlobalSpeed(1000)
        Else
            SendAltPushed("y")
            SleepWithGlobalSpeed(1000)
        EndIf
    EndIf
EndFunc

Func ChooseFileExplorerFolder(Const $asset_folder_p, Const $replace_duplicates = False)
    SleepWithGlobalSpeed(150)  ; wait to open folder window
    WinWaitActiveFixedTimeout($kDownloadFileTitleClass)
    WinSetState("[ACTIVE]", "", @SW_MAXIMIZE)
    SleepWithGlobalSpeed(200)
    FileExplorerFolderPathMouseClick()
    SleepWithGlobalSpeed(100)
    SendCtrlPushed("a")
    SleepWithGlobalSpeed(600)
    PastTextFromClipboard($asset_folder_p)
    ;MsgBox($MB_OK, "Check", "New Asset folder was created 2 " & $asset_folder_p)
    SleepWithGlobalSpeed(450)
    Send("{ENTER}")
    SleepWithGlobalSpeed(450)
    MouseClick($MOUSE_CLICK_LEFT, BalanceX($kButtonSaveX), BalanceY($kButtonSaveY), 1, $kMouseSpeed)    ; Select Save Folder
EndFunc

Func ChangeFireFoxDefaultDownloadDirectory(Const $asset_folder_p)
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1893), BalanceY(63), 1, $kMouseSpeed)  ; Menu down throw
    SleepWithGlobalSpeed(300)  ; Wait for menu down throw
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1678), BalanceY(568), 1, $kMouseSpeed)   ; Settings tab open
    SleepWithGlobalSpeed(600)  ; Wait for settings tab open
    PastTextFromClipboard($kDownloadsBrowserSettingName)
    SleepWithGlobalSpeed(150)
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(861), BalanceY(267), 1, $kMouseSpeed)    ; Downloads path setting text edit
    ChooseFileExplorerFolder($asset_folder_p)
    SendCtrlPushed("w")
    SleepWithGlobalSpeed(400)  ; wait old window tab return
EndFunc

; Safe extraction of text from clipboard
Func GetCopyBufferText()
    @error = 0
    Local $text = ClipGet()
    If @error == 0 Then 
        ;MsgBox($MB_OK, "Check", "@error == 0 $text: " & $text & " @error: " & @error)
        Return $text
    Else
        ;MsgBox($MB_OK, "Check", "@error <> 0 $text " & $text & " @error " & @error)
        Return ""
    EndIf
EndFunc

Func PutTextToCopyBuffer(Const $text = "")
    Local Const $result = ClipPut($text)
    If $result == 1 Then 
        ;MsgBox($MB_OK, "Check", "@error == 0 $text: " & $text & " @error: " & @error)
        Return True
    Else
        ;MsgBox($MB_OK, "Check", "@error <> 0 $text " & $text & " @error " & @error)
        Return False
    EndIf
EndFunc

;1 = if clipboard is empty
;2 = if contains a non-text entry.
;3 or 4 = if cannot access the clipboard.
Func CopyTextRect(Const $x1, Const $y1, Const $x2, Const $y2)
    MouseClickDrag($MOUSE_CLICK_LEFT, BalanceX($x1), BalanceY($y1), BalanceX($x2), BalanceY($y2), $kMouseSpeed)
    SleepWithGlobalSpeed(100)  ; Wait for copying in buffer
    ClipPut("") ; Clear buffer
    CopyOperationWithSleep()
    Return GetCopyBufferText()
EndFunc

Func CopyTextWithShiftEnd(Const $x1, Const $y1, Const $end_button = "{END}")
    MouseClick($MOUSE_CLICK_LEFT, BalanceX($x1), BalanceY($y1), 1, $kMouseSpeed)
    SleepWithGlobalSpeed(900)  ; Wait for cursor move
    Send("{SHIFTDOWN}" & $end_button & "{SHIFTUP}")
    SleepWithGlobalSpeed(1500)  ; Wait for copying in buffer
    CopyOperationWithSleep()
    Return ClipGet()
EndFunc

Func CopyTextWithShiftHome(Const $x1, Const $y1, Const $end_button = "{HOME}")
    Return CopyTextWithShiftEnd($x1, $y1, $end_button)
EndFunc


Func IsEqualTextRect(Const $text, Const $x1, Const $y1, Const $x2, Const $y2)
    Return $text == CopyTextRect($x1, $y1, $x2, $y2)
EndFunc

Func IsEqualTextWithShiftEnd(Const $text, Const $x1, Const $y1)
    Return $text == CopyTextWithShiftEnd($x1, $y1)
EndFunc

Func IsEqualTextWithShiftHome(Const $text, Const $x1, Const $y1)
    Return $text == CopyTextWithShiftHome($x1, $y1)
EndFunc

Func GetCurrentWindowHandle()
    Return WinGetHandle("[ACTIVE]")
EndFunc


Func SearchWithRectTextPosY(Const $text, Const $x1, Const $y1, Const $x2, Const $y2, $tries_count = 10, Const $step_long = 10)
    If $x1 > 0 And $y1 > 0 And $x1 < $kOriginalResolutionX And $y1 < $kOriginalResolutionY And $text <> "" Then
        Local $i = 0
        Local $delta = 0
        Local $new_value = 0
        Do
            $delta = $step_long * $i
            $new_value_y1 = CorrectY($y1 + $delta)
            $new_value_y2 = CorrectY($y2 + $delta)
            ;MsgBox($MB_OK, "Check", "$text = " & $text & " $x1 = " & $x1 & " $new_value_y1 = " & $new_value_y1 & " $new_value_y2 = " & $new_value_y2)
            If IsEqualTextRect($text, $x1, $new_value_y1, $x2, $new_value_y2) Then 
                ; Middle of Rectangle
                Return $new_value_y1 + Floor($new_value_y2 - $new_value_y1 / 2)
            EndIf
            $i = $i + 1
        Until $i >= $tries_count
    EndIf
    Return -1
EndFunc

Func SearchWithShiftEndTextPosY(Const $text, Const $x1, Const $y1, $tries_count = 10, Const $step_long = 10)
    If $x1 > 0 And $y1 > 0 And $x1 < $kOriginalResolutionX And $y1 < $kOriginalResolutionY And $text <> "" Then
        Local $i = 0
        Local $delta = 0
        Local $new_value_y1 = 0
        Do
            $delta = $step_long * $i
            $new_value_y1 = CorrectY($y1 + $delta)
            ;MsgBox($MB_OK, "Check", "$text = " & $text & " $x1 = " & $x1 & " $new_value_y1 = " & $new_value_y1)
            If IsEqualTextWithShiftEnd($text, $x1, $new_value_y1) Then 
                Return $new_value_y1
            EndIf
            $i = $i + 1
        Until $i >= $tries_count
    EndIf
    Return -1
EndFunc

Func SearchWithShiftHomeTextPosY(Const $text, Const $x1, Const $y1, $tries_count = 10, Const $step_long = 10)
    If $x1 > 0 And $y1 > 0 And $x1 < $kOriginalResolutionX And $y1 < $kOriginalResolutionY And $text <> "" Then
        Local $i = 0
        Local $delta = 0
        Local $new_value_y1 = 0
        Do
            $delta = $step_long * $i
            $new_value_y1 = CorrectY($y1 + $delta)
            ;MsgBox($MB_OK, "Check", "$text = " & $text & " $x1 = " & $x1 & " $new_value_y1 = " & $new_value_y1)
            If IsEqualTextWithShiftHome($text, $x1, $new_value_y1) Then 
                Return $new_value_y1
            EndIf
            $i = $i + 1
        Until $i >= $tries_count
    EndIf
    Return -1
EndFunc

Func GetWebAddress()
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(716), BalanceY(66), 1, $kMouseSpeed)
    SleepWithGlobalSpeed(500)
    SendCtrlPushed("a")
    SleepWithGlobalSpeed(1000)
    CopyOperation()
    SleepWithGlobalSpeed(750)

    Local Const $web_address = GetCopyBufferText()
    SleepWithGlobalSpeed(500)
    Send("{ESC}")   ; To exit from input web site address pop up
    SleepWithGlobalSpeed(500)
    Send("{TAB}")   ; unfocuse web address string
    SleepWithGlobalSpeed(1500)
    ;MsgBox($MB_OK, "Check", "Everything is ok? Is web address input closed? ")
    Return $web_address
EndFunc

Func SetWebAddress(Const $web_address)
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(716), BalanceY(66), 1, $kMouseSpeed)
    SleepWithGlobalSpeed(1300)
    SendCtrlPushed("a")
    SleepWithGlobalSpeed(1300)
    If PutTextToCopyBuffer($web_address) Then
        PastOperation()
        ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        SleepWithGlobalSpeed(1200)
        SendEnter()
        SleepWithGlobalSpeed(2300)
    EndIf
EndFunc

Func SaveWebAddress(Const $asset_folder)
    ReWriteTextToFile($asset_folder & $kWebLinkFileName, GetWebAddress())
EndFunc

Func StrToBool(Const $text)
    If "true" == $text Or "True" == $text Then
        Return True
    Else
        If "false" == $text Or "False" == $text Then
            Return False
        Else
            ;MsgBox($MB_OK, "Warning", "Wrong value of string ")
            Return False
        EndIf
    EndIf
EndFunc

Func IniReadBool(Const $filename, Const $section, Const $key, Const $default)
    Return StrToBool(IniRead($filename, $section, $key, $default))
EndFunc

Func IniReadInt(Const $filename, Const $section, Const $key, Const $default)
    Local $text = IniRead($filename, $section, $key, $default)
    If StringIsInt($text) Then
        Return Number($text)
    Else
        Return 0
    EndIf
EndFunc

Func WaitSaveFileWindow(Const $title_class)
    SleepWithGlobalSpeed(1500)  ; Wait for save file window
    WinWaitActiveFixedTimeout($title_class)
EndFunc

; When there is the picture. And you click right mouse button to download
Func ClickMenuSaveImageAs(Const $x1, Const $y1)
    MouseClick($MOUSE_CLICK_RIGHT, $x1, $y1, 1, $kMouseSpeed)   ; Open context menu
    SleepWithGlobalSpeed(1200)  ; Wait for context menu
    Send("v")
    WaitSaveFileWindow($kSaveImageAsTitleClass)
EndFunc

Func ClickNWaitMenuSaveImageAs(Const $x1, Const $y1, Const $title_class = $kSaveImageAsTitleClass)
    ClickMenuSaveImageAs($x1, $y1)
    WaitSaveFileWindow($title_class)
EndFunc

Func IsWebAdressEqual(Const $web_address)
    Return GetWebAddress() == $web_address
EndFunc

; Clicking multiple times and checking, if click has activated some web link. Like blind search
; @param $step_long     is the distance between click tries
; @param $increase_value    new iteration will increase actual value. F.e move down or right
Func ClickMultiTryLine(Const $x1, Const $y1, Const $tries_count = 10, Const $step_long = 10, Const $has_checks = True, Const $is_vertical = True, Const $increase_value = True, $web_address = "", Const $click_task_bar = False)
    If $x1 > 0 And $y1 > 0 And $x1 < $kOriginalResolutionX And $y1 < $kOriginalResolutionY Then
        If "" == $web_address And $has_checks Then 
            $web_address = GetWebAddress()
        EndIf

        Local $i = 0
        Local $delta = 0
        Local $direction = 0
        Local Const $start_handle = GetCurrentWindowHandle()
        Local $stop_flag = false
        If $increase_value Then 
            $direction = 1
        Else
            $direction = -1
        EndIf
        Local $new_value = 0
        Do
            $delta = $direction * $step_long * $i
            If $is_vertical Then 
                $new_value = $y1 + $delta
                MouseClick($MOUSE_CLICK_LEFT, BalanceX($x1), BalanceY(CorrectY($new_value)), 1, $kMouseSpeed)
            Else 
                $new_value = $x1 + $delta
                MouseClick($MOUSE_CLICK_LEFT, BalanceX(CorrectX($new_value)), BalanceY($y1), 1, $kMouseSpeed)
            EndIf
            $i = $i + 1
            If $has_checks Then 
                ;MsgBox($MB_OK, "ClickMultiTryLine", "Checks of web address and handle are turned on.")
                SleepWithGlobalSpeed(5000)
                $stop_flag = $start_handle <> GetCurrentWindowHandle() Or (Not IsWebAdressEqual($web_address))
            EndIf
        Until $stop_flag Or $i >= $tries_count
    EndIf
EndFunc

Func ChooseFileForSavingImage(Const $asset_folder_p, Const $save_window_title_class, Const $replace_duplicates = False, Const $name_extension = $kPreviewFileName)
    Local Const $file_path = $asset_folder_p & $name_extension
    SleepWithGlobalSpeed(1500)  ; Wait for save file window
    WinWaitActiveFixedTimeout($save_window_title_class) ; Can be from image software or from browser saving

    WinSetState("[ACTIVE]", "", @SW_MAXIMIZE)
    SleepWithGlobalSpeed(150)
    FileExplorerFolderPathMouseClick()
    SleepWithGlobalSpeed(150)
    SendCtrlPushed("a")
    SleepWithGlobalSpeed(300)
    PastTextFromClipboard($asset_folder_p)
    SleepWithGlobalSpeed(400)
    Send("{ENTER}")
    SleepWithGlobalSpeed(400)
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1144), BalanceY(976), 1, $kMouseSpeed) ; select image name
    SleepWithGlobalSpeed(750)
    SendCtrlPushed("a")
    SleepWithGlobalSpeed(600)
    PastTextFromClipboard($name_extension)    ; Enter preview name
    SleepWithGlobalSpeed(1000)

    MouseClick($MOUSE_CLICK_LEFT, BalanceX(903), BalanceY(535), 1, $kMouseSpeed)   ; Click to screen center to deselect text
    SleepWithGlobalSpeed(1000)
    Local Const $is_duplicate = FileExists($file_path)
    Local Const $imax = 30
    Local $i = 0
    Local $method_index = 0
    While WinActive($save_window_title_class) And $i < $imax
        Switch $method_index
        Case 0
            Send("{ALTDOWN}s{ALTUP}") ; Push button save
            $method_index = $method_index + 1
        Case 1
            Send("{ENTER}")
            $method_index = $method_index + 1
        Case 2
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(1747), BalanceY(1047), 1, $kMouseSpeed)   ; Click save button
            $method_index = 0
        EndSwitch
        SleepWithGlobalSpeed(550)
        ;MsgBox($MB_OK, "Try to save file", "Loop: " & $i)
        $i = $i + 1
    WEnd
    SleepWithGlobalSpeed(250)
    If $is_duplicate Then
        FileSaveReplaceDuplicates($replace_duplicates)
    EndIf
    ;MsgBox($MB_OK, "Check", "Save has been ended.")
EndFunc

Func SwitchTab()
    SendCtrlPushed("{TAB}")
    SleepWithGlobalSpeed(700)
EndFunc

Func CloseTab()
    SendCtrlPushed("w")
    SleepWithGlobalSpeed(1500)
EndFunc

Func ClosePopUpWindow()
    Send("{ESC}")
    SleepWithGlobalSpeed(600)
EndFunc

Func ChangeWebSiteScale(Const $times, Const $plus_flag = False)
    Local $scale_char
    If $plus_flag == True Then
        $scale_char = "+"
    Else
        $scale_char = "-"
    EndIf
    For $i = 1 To $times
        SendCtrlPushed($scale_char)
        SleepWithGlobalSpeed(150)
    Next
EndFunc

Func UpdateTab(Const $sleep_time = $kWebSiteLoad)
    SendCtrlPushed("r")
    SleepWithGlobalSpeed($sleep_time)
EndFunc

; GoBackOnePageNSleep
Func GoBackOnePage(Const $sleep_time = $kWebSiteLoad)
    ;Send("{ALTDOWN}{LEFT}{ALTUP}")
    Send("{BROWSER_BACK}")
    SleepWithGlobalSpeed($sleep_time)
EndFunc

Func GoForwardOnePage()
    ;Send("{ALTDOWN}{RIGHT}{ALTUP}")
    Send("{BROWSER_FORWARD}")
EndFunc
Func GoForwardOnePageNSleep(Const $sleep_time)
    GoForwardOnePage()
    SleepWithGlobalSpeed($sleep_time)
EndFunc

Func ScrollUpByKey(Const $scroll_count = 1, Const $sleep_time = 200)
    For $i = 0 To $scroll_count - 1
        Send("{UP}")
        SleepWithGlobalSpeed($sleep_time)
    Next
EndFunc

Func ScrollDownByKey(Const $scroll_count = 1, Const $sleep_time = 200)
    For $i = 0 To $scroll_count - 1
        Send("{DOWN}")
        SleepWithGlobalSpeed($sleep_time)
    Next
EndFunc


; Reset Scale to 80%
Func ResetWebSiteScale()
    SendCtrlPushed("0")
    SleepWithGlobalSpeed(150)
EndFunc

Func PrepareTab(Const $changes_count = 2)
    SendCtrlPushed("{HOME}")
    SleepWithGlobalSpeed(700)
    ResetWebSiteScale()
    SleepWithGlobalSpeed(300)
    ChangeWebSiteScale($changes_count)
    SleepWithGlobalSpeed(200)
EndFunc

Func CorrectNameForOS(ByRef $asset_name, Const $strange_characters = "")
    $asset_name = StringRegExpReplace($asset_name, "[" & $strange_characters & $kWindowsRestrictedCharactersInFileName & @CRLF & "]", "")
    ;MsgBox($MB_OK, "Check", $asset_name & "_||||| " & "[" & $kWindowsRestrictedCharactersInFileName & @CRLF & "]")
    $asset_name = StringRegExpReplace($asset_name, '\s+\z', "") ; Delete white space in the end of directory
    ;MsgBox($MB_OK, "Check", $asset_name & "_|||||")
EndFunc

Func GetFileNameRect(Const $x1, Const $y1, Const $x2, Const $y2, Const $strange_characters = "")
    Local $asset_name = CopyTextRect(BalanceX($x1), BalanceY($y1), BalanceX($x2), BalanceY($y2))
    ;MsgBox($MB_OK, "Check", $asset_name & "_|||||")
    CorrectNameForOS($asset_name, $strange_characters)
    Return $asset_name
EndFunc

;GetFileNameShiftEnd
Func GetFileNameShiftEnd(Const $x1, Const $y1, Const $strange_characters = "", Const $str_start = 1, Const $end_button = "{END}")
    Local $asset_name = StringMid(CopyTextWithShiftEnd(BalanceX($x1), BalanceY($y1), $end_button), $str_start)
    ;MsgBox($MB_OK, "Check", $asset_name & "_|||||")
    CorrectNameForOS($asset_name, $strange_characters)
    Return $asset_name
EndFunc

Func CreateAllAssetsDir(Const $download_folder_path)
    If Not FileExists($download_folder_path) Then   ; Create all assets Downloads folder
        DirCreate($download_folder_path)
    EndIf
EndFunc

Func CreateAllAssetsDirFromIni(Const $ini_path, Const $ini_section, Const $download_folder_ini_key_name, Const $default_download_folder)
    Local Const $download_folder_path = IniRead($ini_path, $ini_section, $download_folder_ini_key_name, $default_download_folder) & "\"
    ;MsgBox($MB_OK, "Check", "download_folder_path " & $download_folder_path)

    If Not FileExists($download_folder_path) Then   ; Create all assets Downloads folder
        DirCreate($download_folder_path)
    EndIf

    Return $download_folder_path
EndFunc

Func GetAssetFolderPath(Const $download_folder_path_p, Const $asset_name_p)
    Return $download_folder_path_p & $asset_name_p & "\"
EndFunc

; There can be assets with same name. If we dont need duplicates in folder names return False
Func CreateAssetFolder(Const $download_folder_path_p, Const $asset_name_p, ByRef $asset_folder_p, Const $duplicates)
    $asset_folder_p = GetAssetFolderPath($download_folder_path_p, $asset_name_p)
    If Not FileExists($asset_folder_p) Then   ; Create all asset Downloads folder
        DirCreate($asset_folder_p)
        ;MsgBox($MB_OK, "Check", "New Asset folder was created " & $asset_folder_p)
        Return True
    Else
        If $duplicates Then
            Local $folder_index = 1
            $asset_folder_p = $download_folder_path_p & $asset_name_p & " (" & $folder_index & ")\"
            While FileExists($asset_folder_p)
                $folder_index = $folder_index + 1
                $asset_folder_p = $download_folder_path_p & $asset_name_p & " (" & $folder_index & ")\"
            WEnd
            DirCreate($asset_folder_p)
            ;MsgBox($MB_OK, "Check", "Asset folder was created with index " & $asset_folder_p)
            Return True
        Else
            Return False
        EndIf
    EndIf
    ;MsgBox($MB_OK, "Check", "$asset_folder_p " & $asset_folder_p)
EndFunc

; When you have installed LightShot, banner notifications of Snip & Sketch wont be showed
Func DownloadPreviewSnipSketch(Const $asset_folder_p, Const $x1, Const $y1, Const $x2, Const $y2, Const $banner_flag = $kSnipSketchBannerIsEnabled)
    SleepWithGlobalSpeed(500)
    Send("{LWINDOWN}{SHIFTDOWN}s{SHIFTUP}{LWINUP}")
    SleepWithGlobalSpeed(5000)  ; Wait for image zone selection starting
    MouseClickDrag($MOUSE_CLICK_LEFT, BalanceX($x1), BalanceY($y1), BalanceX($x2), BalanceY($y2), $kMouseSpeed)    ; Select image zone
    SleepWithGlobalSpeed(4500)  ; Wait for openning print screen pop up
    If $banner_flag Then
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(1709), BalanceY(842), 1, $kMouseSpeed)   ; Open snip sketch banner in bottom right corner
    Else    ; Snip Sketch banner is disabled
        Send("{LWINDOWN}a{LWINUP}")   ; Open Notification Center
        SleepWithGlobalSpeed(3000)
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(1708), BalanceY(176), 1, $kMouseSpeed)   ; Open snip sketch banner in bottom right corner
    EndIf
    SleepWithGlobalSpeed(2500)  ; Wait for openning Snip & Sketch window
    WinWaitActiveFixedTimeout($kSnipSketchFileTitleClass)
    SendCtrlPushed("s")

    ChooseFileForSavingImage($asset_folder_p, $kSaveSnipSketchImageAsTitleClass)
    SleepWithGlobalSpeed(700)
    WinWaitActiveFixedTimeout($kSnipSketchFileTitleClass)
    WinClose("[ACTIVE]")    ; Close window of Snip & Sketch

    SleepWithGlobalSpeed(300)
    WinWaitActiveFixedTimeout($kInternetBrowserClass)
EndFunc

Func ContextMenuSaveImageAs(Const $asset_folder_p, Const $x1, Const $y1, Const $sleep_time = 300)
    ClickNWaitMenuSaveImageAs(BalanceX($x1), BalanceX($y1), $kSaveImageAsTitleClass)
    ChooseFileForSavingImage($asset_folder_p, $kSaveImageAsTitleClass)
    SleepWithGlobalSpeed($sleep_time)
    WinWaitActiveFixedTimeout($kInternetBrowserClass)
EndFunc


; 1062, 603
; 1017, 629
Global Const $kLightShotSaveWidthIndent = 45
Global Const $kLightShotSaveHeightIndent = 26

Func ChooseFileForSavingImageLightShot(Const $asset_folder_p, Const $replace_duplicates = False, Const $name_extension = $kPreviewFileName)
    Local Const $file_path = $asset_folder_p & $name_extension
    SleepWithGlobalSpeed(1500)  ; Wait for save file window
    ;MsgBox($MB_OK, "Check", "Localization(kSaveLightShotImageAsTitleClass) " & Localization("kSaveLightShotImageAsTitleClass"))
    WinWaitActiveFixedTimeout(Localization("kSaveLightShotImageAsTitleClass")) ; Can be from image software or from browser saving

    WinSetState("[ACTIVE]", "", @SW_MAXIMIZE)
    ;MsgBox($MB_OK, "Check", "Window for saving image Maximized.")
    SleepWithGlobalSpeed(1000)
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1094), BalanceY(1028), 1, $kMouseSpeed)   ; Click to File name
    SleepWithGlobalSpeed(1000)
    SendCtrlPushed("a")
    SleepWithGlobalSpeed(1000)
    PastTextFromClipboard($file_path)
    SleepWithGlobalSpeed(1000)
    Local Const $is_duplicate = FileExists($file_path)
    Send("{ENTER}")
    ;MsgBox($MB_OK, "Check", "File name has been entered. $file_path " & $file_path)
    If $is_duplicate Then
        FileSaveReplaceDuplicates($replace_duplicates, 1870, 1053)
        If False == $replace_duplicates Then ; Close selection if duplicate finded and cancel not replace duplicate option choosed
            SleepWithGlobalSpeed(200)
            Send("{ESC}")
            SleepWithGlobalSpeed(300)
        EndIf
    EndIf
    ;MsgBox($MB_OK, "Check", "Image File has been saved.")
EndFunc

Func LightShotSaveIconX(Const $x1, Const $x2)
EndFunc

Func LightShotSaveIconY(Const $y1, Const $y2)
    Local $save_icon_y = $y2 + $kLightShotSaveHeightIndent
    If $save_icon_y <= $kOriginalResolutionY Then
        Return $save_icon_y
    Else
        Return $y1 - $kLightShotSaveHeightIndent
    EndIf
EndFunc

; Not Working, because Save file window file path is unflexable
; TODO: Можно в названии файла целиком прописать путь. Тогда он будет сохранять туда, куда нужно
Func DownloadImageLightShot(Const $asset_folder_p, Const $x1, Const $y1, Const $x2, Const $y2, Const $replace_duplicates = False, Const $name_extension = $kPreviewFileName)
    Local $current_window_title = WinGetTitle("[ACTIVE]")
    SleepWithGlobalSpeed(2500)
    Local Const $tries_count = 15
    Local $try_index = 0
    Do
        Send("{ESC}")
        SleepWithGlobalSpeed(500)
        Send("{ESC}")
        SleepWithGlobalSpeed(500)
        Send("{PRINTSCREEN}")
        SleepWithGlobalSpeed(4700)  ; Wait for image zone selection starting

        ; Sometimes it doesn't work
        MouseClickDrag($MOUSE_CLICK_LEFT, BalanceX($x1), BalanceY($y1), BalanceX($x2), BalanceY($y2), 45)    ; Select image zone
        SleepWithGlobalSpeed(4700)  ; Wait for openning LightShot support menu
        MouseClick($MOUSE_CLICK_LEFT, BalanceX($x2 - $kLightShotSaveWidthIndent), BalanceY(LightShotSaveIconY($y1, $y2)), 1, $kMouseSpeed)   ; Save file Icon
        SleepWithGlobalSpeed(4200)  ; Wait for openning Save file window

        $try_index = $try_index + 1
        ; Wait Window Title:"" Class:"#32770"
    Until $try_index > $tries_count Or WinExists(Localization("kSaveLightShotImageAsTitleClass"))
    WinWaitActiveFixedTimeout(Localization("kSaveLightShotImageAsTitleClass"))

    ChooseFileForSavingImageLightShot($asset_folder_p, $replace_duplicates)
    SleepWithGlobalSpeed(500)
    WinActivate($current_window_title)      ; reason: sometimes there is error, and LightShot not activate current window automatically
    ;MsgBox($MB_OK, "Check", "$current_window_title " & $current_window_title)
    SleepWithGlobalSpeed(500)
    WinWaitActiveFixedTimeout($kInternetBrowserClass)
EndFunc

Func CheckCoordinate(Const $coordinate_value, Const $max)
    If $coordinate_value > $max Then
        Return $max
    ElseIF $coordinate_value < 0 Then
        Return 0
    Else 
        Return $coordinate_value
    EndIF
EndFunc
Func CheckCoordinateX(Const $coordinate_value)
    Return CheckCoordinate($coordinate_value, $kOriginalResolutionX)
EndFunc
Func CheckCoordinateY(Const $coordinate_value)
    Return CheckCoordinate($coordinate_value, $kOriginalResolutionY)
EndFunc

; Decrease Height on Length of Task Bar. To not touch Task Bar
Func CutTaskBarY(Const $coordinate_value)
    Local Const $task_bar_start = $kOriginalResolutionY - $kTaskBarHeight
    If $coordinate_value >= $task_bar_start Then
        Return $task_bar_start - 1
    Else
        Return $coordinate_value
    EndIf
    Return 
EndFunc

Func SwitchKeyboardLanguage()
    Send("{ALTDOWN}{LSHIFT}{ALTUP}")
    SleepWithGlobalSpeed(300)
EndFunc

Func GetKeyboardLanguageName()
    Switch @KBLayout
        Case "00000419"
                Return $LangKB_Russian
        Case "00000407"
                Return $LangKB_German
        Case "00000409"
                Return $LangKB_English_USA
        Case "0000040A"
                Return $LangKB_Spain
        Case "0000040B"
                Return $LangKB_Finnish
        Case "0000040C"
                Return $LangKB_French
        Case "00000410"
                Return $LangKB_Italian
        Case "00000413"
                Return $LangKB_Dutch
        Case "00000414"
                Return $LangKB_Norwegian
        Case "00000415"
                Return $LangKB_Polish
        Case "00000416"
                Return $LangKB_Portuguese
        Case "0000041D"
                Return $LangKB_Swedish
        Case Else
                Return "Other (can't determine with @KBLayout directly)"
    EndSwitch
EndFunc

Func GetKeyboardLanguageCode()
    Return @KBLayout
EndFunc

Func SwitchKeyboardLanguageTo(Const $language = $LangKB_English_USA)
    Local Const $current_lang = GetKeyboardLanguageName()
    ;MsgBox($MB_OK, "Check", "@KBLayout " & @KBLayout & " $current_lang " & $current_lang & " $language " & $language)
    If $current_lang  <> $language Then
        SwitchKeyboardLanguage()
        ;MsgBox($MB_OK, "Check", "Has switched keyboard lang.")
    EndIf
    ;MsgBox($MB_OK, "Check", GetKeyboardLanguageName())
EndFunc