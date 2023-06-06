#include <Constants.au3>
#include <MsgBoxConstants.au3>

#include "C:\Development\Projects\IT\Programming\!git-web\public\web-sites-parsing\web-browser-parsing.au3"
;#include "Y:\web-browser-parsing.au3"


Global Const $kParserName = "3dsky"
Global Const $kGoogleSearchText = "download " & $kParserName & " asset names"
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Google Search — Mozilla Firefox"
Global Const $kWindowStartPageTitle = $kGoogleSearchText & Localization("kGoogleSearchTextEnding")
Global Const $kWindowTitleClass = "[TITLE:" & $kWindowStartPageTitle & "; CLASS:" & $kWindowClass & "]"

Global Const $kIniFileName = "download-models-from-" & $kParserName & ".ini"
Global Const $kDefaultDownloadFolder = @ScriptDir & "\script-downloads\3dsky\"



;DownloadModelsFromWebSite()
DownloadAssetNames()
Exit


Func CopyCredit()
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1074), BalanceY(561), 1, $kMouseSpeed)
    SleepWithGlobalSpeed(100)  ; Wait for copying credit
    Return GetCopyBufferText()
EndFunc

Func CheckDailyDownloadLimit()
    Local Const $download_limit_warning_text = "You have reached the daily download limit for your plan."
    ;You can either wait for the limit to reset or upgrade your plan.

    If $download_limit_warning_text == CopyTextRect(BalanceX(817), BalanceY(655), BalanceX(1104), BalanceY(673)) Then   ; Select warning
        MsgBox($MB_OK, "Warning", "Download limit reached. Script exit.")
        Exit
    EndIf
EndFunc

Func IsNotDisabledModel()
    SleepWithGlobalSpeed(350)
    MouseClickDrag($MOUSE_CLICK_LEFT, BalanceX(1094), BalanceY(379), BalanceX(829), BalanceY(379), $kMouseSpeed)    ; Reset rotation of 3D Model
    Return $kDisabledModelText <> CopyTextRect(BalanceX(829), BalanceY(379), BalanceX(1094), BalanceY(379))
EndFunc

; Check if model if free
Func IsNotPayable()
    SleepWithGlobalSpeed(200)
    Local $text = CopyTextRect(BalanceX(1372), BalanceY(206), BalanceX(1865), BalanceY(206))
    ;MsgBox($MB_OK, "Check", "$text " & $text)
    If StringRegExp($text, "^\$.*") Then
        ;MsgBox($MB_OK, "Check", "Asset is Payable " & $text & " Regex result " & StringRegExp($text, "^\$.*"))
        Return False
    Else
        ;MsgBox($MB_OK, "Check", "Free " & $text & " Regex result " & StringRegExp($text, "^\$.*"))
        Return True
    EndIf
EndFunc

Func DownloadAssetLicenseCredit(Const $download_folder_path, Const $asset_name, ByRef $asset_folder, Const $duplicates)
    If CreateAssetFolder($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(209), BalanceY(948), 1, $kMouseSpeed) ; Click to prepare to Download 3D Model
        SleepWithGlobalSpeed(350)  ; Wait while web site open download pop up
        ReWriteTextToFile($asset_folder & $kLicenseFileName, CopyTextRect(BalanceX(797), BalanceY(453), BalanceX(954), BalanceY(538)))
        ReWriteTextToFile($asset_folder & $kCreditFileName, CopyCredit())
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(1080), BalanceY(650), 1, $kMouseSpeed) ; Click to Download 3D Model
        SleepWithGlobalSpeed(4000)  ; Wait for downloading start
        CheckDailyDownloadLimit()
        ChooseFileExplorerFolder($asset_folder)     ; Choose where to download 3D Model asset
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(959), BalanceY(600), 1, $kMouseSpeed) ; close download menu down
        SleepWithGlobalSpeed(170)
        Send("{ESC}")
        SleepWithGlobalSpeed(600)
        Return True
    Else
        Return False
    EndIF
EndFunc

Func DownloadModelsFromWebSite()
    SetHotKeyToExit()
    WinActivate($kWindowTitleClass)
    Local $hWnd = WinWaitActiveFixedTimeout($kWindowTitleClass)
    If $hWnd <> 0 Then
        WinSetState($hWnd, "", @SW_MAXIMIZE)
        SwitchTab()

        Local Const $ini_path = $kCurrentFolder & $kIniFileName
        Local Const $duplicates = IniReadBool($ini_path, $kGeneralIniSection, $kDuplicatesIniKeyName, $kBoolTrue)
        Local Const $download_folder_path = CreateAllAssetsDirFromIni($ini_path, $kGeneralIniSection, $kDownloadFolderIniKeyName, $kDefaultDownloadFolder)
        Local $asset_name
        Local $asset_folder
        While WinGetTitle($hWnd) <> $kWindowStartPageTitle
            UpdateTab()
            PrepareTab()
            SleepWithGlobalSpeed(600)
            If IsNotDisabledModel() And IsNotPayable() Then
                $asset_name = GetFileNameRect(152, 850, 1291, 850, $kStrangeCharacters)
                Local $asset_folder
                If DownloadAssetLicenseCredit($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
                    SaveWebAddress($asset_folder)
                    ;DownloadPreviewSnipSketch($asset_folder, 152, 165, 1325, 823)
                    DownloadImageLightShot($asset_folder, 152, 165, 1325, 823)
                EndIf
            EndIf

            CloseTab()
            ;SwitchTab()
            ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        WEnd
        MsgBox($MB_OK, "Check", "WinGetTitle($hWnd) == $kWindowStartPageTitle. Downloads Ended.")
    EndIf
EndFunc

Func DownloadAssetNames()
    SwitchKeyboardLanguageTo()
    SetHotKeyToExit()
    WinActivate($kWindowTitleClass)
    Local $hWnd = WinWaitActiveFixedTimeout($kWindowTitleClass)
    If $hWnd <> 0 Then
        WinSetState($hWnd, "", @SW_MAXIMIZE)
        SwitchTab()

        Local Const $ini_path = $kCurrentFolder & $kIniFileName
        Local Const $duplicates = IniReadBool($ini_path, $kGeneralIniSection, $kDuplicatesIniKeyName, $kBoolTrue)
        Local Const $download_folder_path = CreateAllAssetsDirFromIni($ini_path, $kGeneralIniSection, $kDownloadFolderIniKeyName, $kDefaultDownloadFolder)
        Local $asset_name
        Local $asset_folder
        While WinGetTitle($hWnd) <> $kWindowStartPageTitle
            UpdateTab(3000)
            ;PrepareTabDefault()
            SleepWithGlobalSpeed(600)

            ;GetAssetNameRect($asset_name, 152, 850, 1291, 850, $kStrangeCharacters)
            $asset_name = GetFileNameShiftEnd(1088, 272)
            ;MsgBox($MB_OK, "Check", "$asset_name" & $asset_name)
            Local $asset_folder
            CreateAssetFolder($download_folder_path, $asset_name, $asset_folder, $duplicates)


            ;If DownloadAssetLicenseCredit($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
                ;SaveWebAddress($asset_folder)
                ;DownloadPreviewSnipSketch($asset_folder, 152, 165, 1325, 823)
            ;EndIf

            ;CloseTab()
            SwitchTab()
            ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        WEnd
        MsgBox($MB_OK, "Check", "WinGetTitle($hWnd) == $kWindowStartPageTitle. Downloads Ended.")
    EndIf
EndFunc