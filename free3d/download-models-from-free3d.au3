#include <Constants.au3>
#include <MsgBoxConstants.au3>

#include "C:\Development\Projects\IT\Programming\!git-web\public\web-sites-parsing\web-browser-parsing.au3"
;#include "Y:\web-browser-parsing.au3"


Global Const $kParserName = "free3d"
Global Const $kGoogleSearchText = "download " & $kParserName & " assets"
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Google Search — Mozilla Firefox"
Global Const $kWindowStartPageTitle = $kGoogleSearchText & Localization("kGoogleSearchTextEnding")
Global Const $kWindowTitleClass = "[TITLE:" & $kWindowStartPageTitle & "; CLASS:" & $kWindowClass & "]"

Global Const $kIniFileName = "download-models-from-" & $kParserName & ".ini"
Global Const $kDefaultDownloadFolder = @ScriptDir & "\script-downloads\Free3D\"

Global Const $kCCLicenseFileName = "License - CC Attribution 3.0 Unported.txt"
Global Const $kCCLicenseFilePath = @ScriptDir & "\" & $kCCLicenseFileName

DownloadModelsFromWebSite()
Exit


Func UpdateTabFree3D()
    SendCtrlPushed("r")
    SleepWithGlobalSpeed(600)
    SendCtrlPushed("{ENTER}")
    SleepWithGlobalSpeed($kWebSiteLoad)
EndFunc

Func DownloadAsset(Const $download_folder_path, Const $asset_name, ByRef $asset_folder, Const $duplicates)
    If CreateAssetFolder($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(1420), BalanceY(387), 1, $kMouseSpeed) ; Click to prepare to Download 3D Model
        SleepWithGlobalSpeed(650)
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(850), BalanceY(251), 1, $kMouseSpeed) ; Final Downloading of 3D Model
        SleepWithGlobalSpeed(5400)  ; Wait for downloading start
        ChooseFileExplorerFolder($asset_folder)     ; Choose where to download 3D Model asset
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(1142), BalanceY(154), 1, $kMouseSpeed) ; Click to prepare to Download 3D Model
        SleepWithGlobalSpeed(500)   ; Wait while download pop up will be closed
        Return True
    Else
        Return False
    EndIf
EndFunc

Func DownloadModelsFromWebSite()
    SwitchKeyboardLanguageTo()
    SetHotKeyToExit()
    WinActivate($kWindowTitleClass)
    Local $hWnd = WinWaitActive($kWindowTitleClass)
    If $hWnd <> 0 Then
        WinSetState($hWnd, "", @SW_MAXIMIZE)
        SwitchTab()

        Local Const $ini_path = $kCurrentFolder & $kIniFileName
        Local Const $duplicates = IniReadBool($ini_path, $kGeneralIniSection, $kDuplicatesIniKeyName, $kBoolTrue)
        Local Const $download_folder_path = CreateAllAssetsDirFromIni($ini_path, $kGeneralIniSection, $kDownloadFolderIniKeyName, $kDefaultDownloadFolder)
        Local $asset_name
        Local $asset_folder
        While WinGetTitle($hWnd) <> $kWindowStartPageTitle
            UpdateTabFree3D()
            PrepareTab()
            SleepWithGlobalSpeed(600)

            $asset_name = GetFileNameRect(590, 283, 1427, 283)
            Local $asset_folder
            If DownloadAsset($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
                FileCopy($kCCLicenseFilePath, $asset_folder)
                SleepWithGlobalSpeed(150)
                SaveWebAddress($asset_folder)
                SleepWithGlobalSpeed(500)
                Send("{ESC}")   ; To exit from web site address pop up
                SleepWithGlobalSpeed(750)
                ContextMenuSaveImageAs($asset_folder, 873, 486)
            EndIf

            CloseTab()
            ;SwitchTab()
            ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        WEnd
        MsgBox($MB_OK, "Check", "WinGetTitle($hWnd) == $kWindowStartPageTitle. Downloads Ended.")
    EndIf
EndFunc


; ReWriteTextToFile($asset_folder & $kLicenseFileName, CopyTextRect(BalanceX(797), BalanceY(453), BalanceX(954), BalanceY(538)))

;CheckForAntiDDOS
;Checking your browser before accessing
;647, 519
;1123, 522



;Daily downloads limit exceeded
;77, 100
;286, 97