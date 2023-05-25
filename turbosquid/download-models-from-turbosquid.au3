#include <Constants.au3>
#include <MsgBoxConstants.au3>

#include "C:\Development\Projects\IT\Programming\!it-projects\!best-projects\web-sites-parsing\web-browser-parsing.au3"
;#include "Y:\web-browser-parsing.au3"


Global Const $kParserName = "turbosquid"
Global Const $kGoogleSearchText = "download " & $kParserName & " assets"
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Google Search — Mozilla Firefox"
Global Const $kWindowStartPageTitle = $kGoogleSearchText & Localization("kGoogleSearchTextEnding")
Global Const $kWindowTitleClass = "[TITLE:" & $kWindowStartPageTitle & "; CLASS:" & $kWindowClass & "]"

Global Const $kIniFileName = "download-models-from-" & $kParserName & ".ini"
Global Const $kDefaultDownloadFolder = @ScriptDir & "\script-downloads\TurboSquid\"

Global Const $kCCLicenseFileName = "License - TurboSquid - Standard for Games.txt"
Global Const $kCCLicenseFilePath = @ScriptDir & "\" & $kCCLicenseFileName

DownloadModelsFromWebSite()
Exit

Func DownloadPreview(Const $asset_folder_p)
    ClickNWaitMenuSaveImageAs(BalanceX(960), BalanceY(240), $kSaveImageAsTitleClass)
    If Not WinActive($kSaveImageAsTitleClass) Then
        ClickNWaitMenuSaveImageAs(BalanceX(960), BalanceY(450), $kSaveImageAsTitleClass)
    EndIf

    ChooseFileForSavingImage($asset_folder_p, $kSaveImageAsTitleClass)
    SleepWithGlobalSpeed(500)
    ;MsgBox($MB_OK, "Check", "Window activation try.")
    ;MouseClick($MOUSE_CLICK_LEFT, BalanceX(895), BalanceY(108), 1, $kMouseSpeed)    ; For Activation of Window
    WinWaitActiveFixedTimeout($kInternetBrowserClass)
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
            UpdateTab()
            PrepareTab()
            SleepWithGlobalSpeed(600)
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(885), BalanceY(110), 1, $kMouseSpeed)

            SendCtrlPushed("{END}") ;   Scroll down to see Name Title in the Top
            SleepWithGlobalSpeed(1000)

            Local $asset_name
            $asset_name = GetFileNameShiftEnd(388, 104)
            SendCtrlPushed("{HOME}") ;   Scroll up to see Page Top
            SleepWithGlobalSpeed(1000)
            
            Local $asset_folder
            If CreateAssetFolder($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
                FileCopy($kCCLicenseFilePath, $asset_folder)
                SleepWithGlobalSpeed(150)
                SaveWebAddress($asset_folder)
                SleepWithGlobalSpeed(500)
                Send("{ESC}")   ; To exit from web site address pop up
                SleepWithGlobalSpeed(750)
                DownloadPreview($asset_folder)
                SleepWithGlobalSpeed(300)

                SendCtrlPushed("{END}") ;   Scroll down to see Name Title in the Top
                SleepWithGlobalSpeed(1000)
                MouseClick($MOUSE_CLICK_LEFT, BalanceX(1469), BalanceY(104), 1, $kMouseSpeed) ; Click to prepare to Download 3D Model
                SleepWithGlobalSpeed(9000)  ; Wait while downloading list of 3D Models web page will open

                Local $flag = False ; Difficult to choose proper 3d file model format
                If $flag Then
                    MouseClick($MOUSE_CLICK_LEFT, BalanceX(885), BalanceY(400), 1, $kMouseSpeed) ; Final Downloading of 3D Model
                    SleepWithGlobalSpeed(5400)  ; Wait for downloading start
                    ChooseFileExplorerFolder($asset_folder)     ; Choose where to download 3D Model asset
                    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1142), BalanceY(154), 1, $kMouseSpeed) ; Click to save file
                    ;Send("{ENTER}")
                    SleepWithGlobalSpeed(500)   ; Wait while download pop up will be closed
                EndIf
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