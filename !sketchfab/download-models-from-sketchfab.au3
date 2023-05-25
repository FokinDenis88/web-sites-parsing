#include <Constants.au3>
#include <MsgBoxConstants.au3>

#include "C:\Development\Projects\IT\Programming\!it-projects\!best-projects\web-sites-parsing\web-browser-parsing.au3"
;#include "Y:\web-browser-parsing.au3"
#include "C:\Development\Projects\IT\Programming\!it-projects\!best-projects\web-sites-parsing\file-operations.au3"

; TODO: Download section of scetch fab is scaling, because of different format of download files


Global Const $kGoogleSearchText = "download sketchfab assets"
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Google Search — Mozilla Firefox"
Global Const $kWindowStartPageTitle = $kGoogleSearchText & Localization("kGoogleSearchTextEnding")
Global Const $kWindowTitleClass = "[TITLE:" & $kWindowStartPageTitle & "; CLASS:" & $kWindowClass & "]"

Global Const $kIniFileName = "download-models-from-sketchfab.ini"
Global Const $kDefaultDownloadFolder = @ScriptDir & "\script-downloads\Sketchfab\"

Global Const $kDisabledModelText = "This Sketchfab 3D model has been disabled."
Global Const $kStrangeCharacters = '\/'

Global Const $kCreditStartText = "Credit the Creator "
Global Const $kLicenseAboveText = "Licensing information"
Global Const $kPreDownloadStartText = "Available downloads"
Global Const $kDownloadStartText = "Original format"
Global Const $kPublicDomainLicenseStartText = "CC0 Public Domain"

; 654 - 622 = 32
Global Const $kHeightDownloadTextNButton = 32
; 527 - 444 = 83
Global Const $kHeightLicense = 83
; 537 - 444 = 93
Global Const $kHeightCreditNButton = 93

Global Const $kRightDownloadTabFieldX = 1140
Global Const $kLicenseLeftFieldX = 795
Global Const $kLicenseRightFieldX = 950

Global Const $kCreditStartSearchPosY = 390
Global Const $kDownloadStartSearchPosY = 537


DownloadModelsFromWebSite()
Exit


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
    ;Local $text = CopyTextRect(BalanceX(1372), BalanceY(206), BalanceX(1865), BalanceY(206))
    Local $text = CopyTextWithShiftHome(BalanceX(1867), BalanceY(202))
    ;MsgBox($MB_OK, "Check", "$text " & $text)
    If StringRegExp($text, "^\$.*") Then
        ;MsgBox($MB_OK, "Check", "Asset is Payable " & $text & " Regex result " & StringRegExp($text, "^\$.*"))
        Return False
    Else
        ;MsgBox($MB_OK, "Check", "Free " & $text & " Regex result " & StringRegExp($text, "^\$.*"))
        Return True
    EndIf
EndFunc

; "CC Attribution" "CC Attribution-ShareAlike" "CC Attribution-NoDerivs" "CC Attribution-NonCommercial" 
; "CC Attribution-NonCommercial-ShareAlike" "CC Attribution-NonCommercial-NoDerivs" "CC0 Public Domain"

Func CopyFullLicenseTextFile(Const $asset_folder, Const $license_file_name)
    FileCopy($kCurrentFolder & $license_file_name, $asset_folder & $license_file_name)
EndFunc

; Copy lisence file to asset folder.
; @return true if the license is public domain
Func AddLicenseTextFile(Const $asset_folder, Const $license_text)
    If StringRegExp($license_text, "CC Attribution-ShareAlike") Then
        CopyFullLicenseTextFile($asset_folder, "License - CC Attribution-ShareAlike 4.0 International (CC BY-SA 4.0).txt")
        Return
    EndIf
    If StringRegExp($license_text, "CC Attribution-NoDerivs") Then
        CopyFullLicenseTextFile($asset_folder, "License - CC Attribution-NoDerivs.txt")
        Return
    EndIf
    If StringRegExp($license_text, "CC Attribution-NonCommercial") Then
        CopyFullLicenseTextFile($asset_folder, "License - CC Attribution-NonCommercial 4.0 International (CC BY-NC 4.0).txt")
        Return
    EndIf
    If StringRegExp($license_text, "CC Attribution-NonCommercial-ShareAlike") Then
        CopyFullLicenseTextFile($asset_folder, "License - CC Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0).txt")
        Return
    EndIf
    If StringRegExp($license_text, "CC Attribution-NonCommercial-NoDerivs") Then
        CopyFullLicenseTextFile($asset_folder, "License - CC Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0) .txt")
        Return
    EndIf
    If StringRegExp($license_text, "CC Attribution") Then
        CopyFullLicenseTextFile($asset_folder, "License - CC Attribution 3.0 Unported.txt")
        Return
    EndIf
    If StringRegExp($license_text, "CC0 Public Domain") Then
        CopyFullLicenseTextFile($asset_folder, "License - CC0 1.0 Universal (CC0 1.0) Public Domain Dedication.txt")
        Return
    EndIf
EndFunc

Func SaveLicense(Const $asset_folder, Const $y_credit_text)
    Local Const $license_text = CopyTextRect(BalanceX($kLicenseLeftFieldX), BalanceY($y_credit_text), BalanceX($kLicenseRightFieldX), BalanceY($y_credit_text + $kHeightLicense))
    ReWriteTextToFile($asset_folder & $kLicenseFileName, $license_text)
    AddLicenseTextFile($asset_folder, $license_text)
    ;MsgBox($MB_OK, "Check", "SaveLicense() ends.")
EndFunc

Func SaveCredit(Const $asset_folder, Const $y_credit_text)
    ;MouseClick($MOUSE_CLICK_LEFT, BalanceX(1074), BalanceY($y_credit_text + $kHeightCreditNButton), 1, $kMouseSpeed)
    Local Const $current_web_address = GetWebAddress()
    ClickMultiTryLine(BalanceX(1074), BalanceY($y_credit_text + $kHeightCreditNButton), 4, 10, False)  ; Click to Download 3D Model
    Local Const $copy_buffer = GetCopyBufferText()
    SleepWithGlobalSpeed(1500)
    If Not IsWebAdressEqual($current_web_address) Then  ; Check miss click
        CloseTab()
    EndIf
    SleepWithGlobalSpeed(100)  ; Wait for copying credit
    ReWriteTextToFile($asset_folder & $kCreditFileName, $copy_buffer)
    ;MsgBox($MB_OK, "Check", "SaveCredit() ends.")
EndFunc

Func SaveAsset(Const $asset_folder, Const $y_download_button_text)
    Local Const $min_download_y = 588
    Local Const $max_download_y = 632
    Local Const $try_height = 10
    ClickMultiTryLine(BalanceX(1087), BalanceY( $y_download_button_text + Floor($kHeightDownloadTextNButton / 2) ), Floor($max_download_y - $min_download_y / $try_height) + 2, $try_height)  ; Click to Download 3D Model

    SleepWithGlobalSpeed(4000)  ; Wait for downloading start
    CheckDailyDownloadLimit()
    ChooseFileExplorerFolder($asset_folder)     ; Choose where to download 3D Model asset
    
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(959), BalanceY(600), 1, $kMouseSpeed) ; close download menu down
    SleepWithGlobalSpeed(170)
    Send("{ESC}")
    SleepWithGlobalSpeed(600)
EndFunc

Func DownloadAssetLicenseCredit(Const $download_folder_path, Const $asset_name, ByRef $asset_folder, Const $duplicates)
    If CreateAssetFolder($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
        ReWriteTextToFile($asset_folder & $kAssetFileName, $asset_name)
        MouseClick($MOUSE_CLICK_LEFT, BalanceX(209), BalanceY(948), 1, $kMouseSpeed) ; Click to prepare to Download 3D Model
        SleepWithGlobalSpeed(350)  ; Wait while web site open download pop up

        ;MsgBox($MB_OK, "Check", "Everything is ok? DownloadAssetLicenseCredit_0 ")
        Local $y_license_credit_text = SearchWithShiftHomeTextPosY($kCreditStartText, $kRightDownloadTabFieldX, $kCreditStartSearchPosY, 20, 10)
        If $y_license_credit_text == -1 Then 
            $y_license_credit_text = SearchWithShiftHomeTextPosY($kCreditStartText, $kRightDownloadTabFieldX, 320, 20, 10)
        EndIf

        ; Check if asset license is public domain
        Local $is_public_domain = False
        If $y_license_credit_text == -1 Then 
            $y_license_credit_text = SearchWithShiftHomeTextPosY($kPublicDomainLicenseStartText, $kRightDownloadTabFieldX, 340, 40, 10)
            If $y_license_credit_text <> -1 Then 
                $is_public_domain = True
            EndIf
        EndIf

        Local $y_download_button_text = SearchWithShiftHomeTextPosY($kDownloadStartText, $kRightDownloadTabFieldX, $kDownloadStartSearchPosY, 20, 10)
        ;MsgBox($MB_OK, "Check", "$y_license_credit_text = " & $y_license_credit_text & " $y_download_button_text = " & $y_download_button_text)
        If $y_license_credit_text <> -1 And $y_download_button_text <> -1 Then
            SaveLicense($asset_folder, $y_license_credit_text)
            If Not $is_public_domain Then
                SaveCredit($asset_folder, $y_license_credit_text)
            EndIf
            SaveAsset($asset_folder, $y_download_button_text)
        Else 
            ;MsgBox($MB_OK, "Check", "Didn't find credit text or download button.")
            LogFileAppendLnToDir($asset_name & " Didn't find credit text or download button.", $download_folder_path)
        EndIf
        Return True
    Else
        Return False
    EndIF
EndFunc

Func DownloadModelsFromWebSite()
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
            UpdateTab()
            ClosePopUpWindow()
            PrepareTab()
            SleepWithGlobalSpeed(600)
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(1894), BalanceY(144), 1, $kMouseSpeed)    ; Close share opinion
            SleepWithGlobalSpeed(600)
            If IsNotDisabledModel() And IsNotPayable() Then
                $asset_name = GetFileNameRect(152, 850, 1291, 850, $kStrangeCharacters)
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