#include <Constants.au3>
#include <MsgBoxConstants.au3>

#include "C:\Development\Projects\IT\Programming\!git-web\public\web-sites-parsing\web-browser-parsing.au3"
;#include "Y:\web-browser-parsing.au3"


Global Const $kParserName = "unity"
Global Const $kGoogleSearchText = "download " & $kParserName & " assets"

Global Const $kWindowStartPageTitle = $kGoogleSearchText & Localization("kGoogleSearchTextEnding")
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Google Search — Mozilla Firefox"
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Поиск в Google — Mozilla Firefox"
Global Const $kWindowTitleClass = "[TITLE:" & $kWindowStartPageTitle & "; CLASS:" & $kWindowClass & "]"

Global Const $kIniFileName = $kParserName & ".ini"
Global Const $kDefaultDownloadFolder = @ScriptDir & "\script-downloads\polyhaven\"

Global Const $kCCLicenseFilePath = @ScriptDir & "\" & "License - Unity Asset Store Terms of Service and EULA.txt"
Global Const $kCCLicenseFaqFilePath = @ScriptDir & "\" & "FAQ Asset Store Terms of Service and EULA.txt"

Global Const $kWebSiteLoadTime = 15000

Global Const $kPurchaseIndent = 428 - 345
Global Const $kPurchaseNFeedbackIndent = 445 - 341
Global Const $kViewsIndent = 540 - 472
Global Const $kHasAdvertisementBanner = False
Global Const $kFileNameOneStringLength = 34
Global Const $kOneLineAssetNameHeight = 455 - 429


DownloadModelsFromWebSite()
Exit


; If it is Already purchased assets, it will be message in asset page
Func IsPurchased()
    ;"You purchased this item on Aug 31, 2022."
    Local Const $copied_text = StringMid(CopyTextWithShiftEnd(364, 365), 1, 26)
    ;MsgBox($MB_OK, "Check", "$copied_text " & $copied_text)
    If $copied_text == "You purchased this item on" Then
        Return True
    Else
        Return False
    EndIF
EndFunc

Func CalcPurchaseIndent()
    Local Const $purchase_text = CopyTextRect(395, 362, 1332, 388)
    If StringInStr($purchase_text, "You purchased this item on") > 0 Then
        If StringInStr($purchase_text, "Please rate and review this asset.") > 0 Then
            Return $kPurchaseNFeedbackIndent
        Else
            Return $kPurchaseIndent
        EndIf
    Else
        Return 0
    EndIf
EndFunc

; Above of Download Button there maybe views count text
Func HasViewsText(Const $indent_purchase, Const $indent_name)
    Return StringInStr(GetFileNameShiftEnd(1521, 495 + $indent_purchase + $indent_name, "", 1, "{HOME}"), "views") > 0
EndFunc

; Сделать сдвиг, если в имени много строк
Func CountLinesInName()
    Local $original_file_name_length = StringLen(CopyTextRect(576, 299, 1513, 316))
    Local Const $quotient = Floor($original_file_name_length / $kFileNameOneStringLength)
    Local Const $remainder = Mod($original_file_name_length, $kFileNameOneStringLength)
    If $remainder <> 0 Then
        ;MsgBox($MB_OK, "Check", "$remainder <> 0. Lines = " & $quotient + 1)
        Return $quotient + 1
    Else
        ;MsgBox($MB_OK, "Check", "$remainder == 0. Lines = " & $quotient)
        Return $quotient
    EndIf
EndFunc

Func DownloadAsset(Const $indent)
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1345), BalanceY(494 + $indent), 1, $kMouseSpeed) ; Final Downloading of 3D Model
    SleepWithGlobalSpeed(5500)  ; Wait for downloading start
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1099), BalanceY(740), 1, $kMouseSpeed) ; Accept License terms
    SleepWithGlobalSpeed(9000)  ; Wait for downloading start
    MouseClick($MOUSE_CLICK_LEFT, BalanceX(1628), BalanceY(114), 1, $kMouseSpeed) ; Close help banner for going to assets or unity hub
    SleepWithGlobalSpeed(2000)  ; Wait for downloading start
    
    ;ChooseFileExplorerFolder($asset_folder)     ; Choose where to download 3D Model asset
    ;SleepWithGlobalSpeed(1500)
EndFunc

Func GetUnityAssetNameByPath(ByRef $indent_name)
    ;$asset_name = GetFileNameShiftEnd(1171, 351 + $indent_purchase)
    ; "Minimalist Scalable Grid Prototype "
    
    $indent_name = (CountLinesInName() - 1) * $kOneLineAssetNameHeight
    Return GetFileNameRect(576, 299, 1513, 316)
EndFunc

Func GetUnityAssetName(Const $indent_purchase, ByRef $indent_name)
    ;GetFileNameShiftEnd(1171, 351 + $indent_purchase)
    Local $text = CopyTextWithShiftEnd(BalanceX(1171), BalanceY(351 + $indent_purchase))
    $indent_name = 0
    While StringMid($text, StringLen($text)) == " "
        $indent_name = $indent_name + $kOneLineAssetNameHeight
        $text = $text & CopyTextWithShiftEnd(BalanceX(1171), BalanceY(351 + $indent_purchase + $indent_name))
    WEnd
    ;MsgBox($MB_OK, "Check", "$text " & $text & " $indent_name " & $indent_name & " $kOneLineAssetNameHeight " & $kOneLineAssetNameHeight)
    CorrectNameForOS($text)
    ;MsgBox($MB_OK, "Check", "Asset Folder Name " & $text)
    Return $text
EndFunc

; TODO: У новых ассетов может не быть количества просмотров над кнопкой добавить ассет в библиотеку
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
        Local $asset_name = ""
        Local $asset_folder = ""
        While WinGetTitle($hWnd) <> $kWindowStartPageTitle
            PrepareTab(0)
            UpdateTab($kWebSiteLoadTime)
            SleepWithGlobalSpeed(500)
            If $kHasAdvertisementBanner Then
                MouseClick($MOUSE_CLICK_LEFT, BalanceX(1890), BalanceY(102), 1, $kMouseSpeed) ; close advertisements banner
                SleepWithGlobalSpeed(1000)
                MouseClick($MOUSE_CLICK_LEFT, BalanceX(96), BalanceY(151), 1, $kMouseSpeed) ; click for page move up
                SleepWithGlobalSpeed(2500)
            EndIf

            Local $indent_purchase = CalcPurchaseIndent()
            Local $indent_name = 0
            Local $indent_views = 0
            Local $is_purchased = False
            If $indent_purchase > 0 Then
                $is_purchased = True
            EndIf

            $asset_name = GetUnityAssetName($indent_purchase, $indent_name)
            If HasViewsText($indent_purchase, $indent_name) Then
                $indent_views = $kViewsIndent
            EndIf
            If CreateAssetFolder($download_folder_path & $download_category & "\", $asset_name, $asset_folder, $duplicates) Then
                DownloadImageLightShot($asset_folder, 345, 341 + $indent_purchase, 1160, 956 + $indent_purchase)
                ;MsgBox($MB_OK, "Check", "Preview downloaded")
                SleepWithGlobalSpeed(500)
                If Not $is_purchased Then
                    DownloadAsset($indent_purchase + $indent_name + $indent_views)
                EndIf
                FileCopy($kCCLicenseFilePath, $asset_folder)
                FileCopy($kCCLicenseFaqFilePath, $asset_folder)
                SleepWithGlobalSpeed(1300)      ; Wait while Download banner will be closed
                ;Local license_info_y = 1066 + $indent_purchase
                ReWriteTextToFile($asset_folder & "Asset Info.txt", CopyTextRect(1172, 540 + $indent_purchase + $indent_name + $indent_views, 1595, 1052))
                SleepWithGlobalSpeed(500)
                SaveWebAddress($asset_folder)
                SleepWithGlobalSpeed(150)
            EndIf

            CloseTab()
            ;SwitchTab()
            ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        WEnd
        MsgBox($MB_OK, "Check", "WinGetTitle($hWnd) == $kWindowStartPageTitle. Downloads Ended.")
    EndIf
EndFunc