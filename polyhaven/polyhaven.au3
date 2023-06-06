; Program Can work ONLY with VPN, because of technique problems

#include <Constants.au3>
#include <MsgBoxConstants.au3>

#include "C:\Development\Projects\IT\Programming\!git-web\public\web-sites-parsing\web-browser-parsing.au3"
;#include "Y:\web-browser-parsing.au3"


Global Const $kParserName = "polyhaven"
Global Const $kGoogleSearchText = "download " & $kParserName & " assets"

Global Const $kWindowStartPageTitle = $kGoogleSearchText & Localization("kGoogleSearchTextEnding")
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Google Search — Mozilla Firefox"
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Поиск в Google — Mozilla Firefox"
Global Const $kWindowTitleClass = "[TITLE:" & $kWindowStartPageTitle & "; CLASS:" & $kWindowClass & "]"

Global Const $kIniFileName = $kParserName & ".ini"
Global Const $kDefaultDownloadFolder = @ScriptDir & "\script-downloads\polyhaven\"

Global Const $kCCLicenseFilePath = @ScriptDir & "\" & "License - CC0 1.0 Universal (CC0 1.0) Public Domain Dedication.txt"

Global Const $kWebSiteLoadTime = 7000

Global Const $kAssetsResolutionCount = 3

DownloadPreviews()
;DownloadModelsFromWebSite()
Exit


Func DownloadAsset(Const $download_folder_path, Const $asset_name, ByRef $asset_folder, Const $duplicates)
    If CreateAssetFolder($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
        Local Const $resolution_indent = 41
        For $i = 0 To $kAssetsResolutionCount - 1
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(1608), BalanceY(180), 1, $kMouseSpeed) ; Choose Resolution
            SleepWithGlobalSpeed(1500)
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(1608), BalanceY(220 + $i * $resolution_indent), 1, $kMouseSpeed) ; Choose Resolution
            SleepWithGlobalSpeed(1500)

            MouseClick($MOUSE_CLICK_LEFT, BalanceX(1758), BalanceY(179), 1, $kMouseSpeed) ; Final Downloading of 3D Model
            SleepWithGlobalSpeed(5000)  ; Wait for downloading start
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(989), BalanceY(624), 1, $kMouseSpeed) ; Click button leave page
            SleepWithGlobalSpeed(2000)  ; Wait for downloading start
            ChooseFileExplorerFolder($asset_folder)     ; Choose where to download 3D Model asset
            SleepWithGlobalSpeed(1500)
        Next
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
        Local Const $download_category = IniRead($ini_path, $kGeneralIniSection, "download_category", "")
        Local Const $download_folder_path = CreateAllAssetsDirFromIni($ini_path, $kGeneralIniSection, $kDownloadFolderIniKeyName, $kDefaultDownloadFolder)
        Local $asset_name
        Local $asset_folder
        While WinGetTitle($hWnd) <> $kWindowStartPageTitle
            PrepareTab(0)
            UpdateTab()
            SleepWithGlobalSpeed(600)

            ;"Textures / Pebble Ground 01" = 12
            $asset_name = GetFileNameShiftEnd(428, 108, "", StringLen($download_category) + 3 + 1)
            Local $asset_folder
            If DownloadAsset($download_folder_path & $download_category & "\", $asset_name, $asset_folder, $duplicates) Then
                FileCopy($kCCLicenseFilePath, $asset_folder)
                SleepWithGlobalSpeed(150)
                SaveWebAddress($asset_folder)
                SleepWithGlobalSpeed(750)
                DownloadImageLightShot($asset_folder, 3, 135, 1563, 916)
            EndIf

            CloseTab()
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(989), BalanceY(624), 1, $kMouseSpeed) ; Click button leave page
            
            ;SwitchTab()
            ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        WEnd
        MsgBox($MB_OK, "Check", "WinGetTitle($hWnd) == $kWindowStartPageTitle. Downloads Ended.")
    EndIf
EndFunc

Func DownloadPreviews()
    SwitchKeyboardLanguageTo()
    SetHotKeyToExit()
    WinActivate($kWindowTitleClass)
    Local $hWnd = WinWaitActive($kWindowTitleClass)
    If $hWnd <> 0 Then
        WinSetState($hWnd, "", @SW_MAXIMIZE)
        SwitchTab()

        Local Const $ini_path = $kCurrentFolder & $kIniFileName
        Local Const $duplicates = IniReadBool($ini_path, $kGeneralIniSection, $kDuplicatesIniKeyName, $kBoolTrue)
        Local Const $download_category = IniRead($ini_path, $kGeneralIniSection, "download_category", "")
        Local Const $download_folder_path = CreateAllAssetsDirFromIni($ini_path, $kGeneralIniSection, $kDownloadFolderIniKeyName, $kDefaultDownloadFolder)
        Local $asset_name
        Local $asset_folder
        While WinGetTitle($hWnd) <> $kWindowStartPageTitle
            PrepareTab(0)
            UpdateTab()
            SleepWithGlobalSpeed(600)

            ;"Textures / Pebble Ground 01" = 12
            $asset_name = GetFileNameShiftEnd(428, 108, "", StringLen($download_category) + 3 + 1)
            Local $asset_folder = $download_folder_path & $download_category & "\" & $asset_name & "___polyhaven" & "\"
            ;MsgBox($MB_OK, "Check", "$asset_folder " & $asset_folder)
            If FileExists($asset_folder) Then
                DownloadImageLightShot($asset_folder, 3, 135, 1563, 916, True)
            EndIf

            CloseTab()
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(989), BalanceY(624), 1, $kMouseSpeed) ; Click button leave page
            
            ;SwitchTab()
            ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        WEnd
        MsgBox($MB_OK, "Check", "WinGetTitle($hWnd) == $kWindowStartPageTitle. Downloads Ended.")
    EndIf
EndFunc