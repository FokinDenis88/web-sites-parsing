#include <Constants.au3>
#include <MsgBoxConstants.au3>

;#include "C:\Development\Projects\IT\Programming\!it-projects\!best-projects\web-sites-parsing\web-browser-parsing.au3"
#include "Y:\web-browser-parsing.au3"


Global Const $kParserName = "material maker"
Global Const $kGoogleSearchText = "download " & $kParserName & " assets"
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Google Search — Mozilla Firefox"
Global Const $kWindowStartPageTitle = $kGoogleSearchText & Localization("kGoogleSearchTextEnding")
Global Const $kWindowTitleClass = "[TITLE:" & $kWindowStartPageTitle & "; CLASS:" & $kWindowClass & "]"

Global Const $kIniFileName = "material-maker.ini"
Global Const $kDefaultDownloadFolder = @ScriptDir & "\script-downloads\MaterialMaker\"

Global Const $kContinueFlagIniKeyName = "continue_flag"
Global Const $kPageDownIniKeyName = "page_down"
Global Const $kRowIniKeyName = "row"
Global Const $kColumnIniKeyName = "column"


; https://www.materialmaker.org/materials?count=1000&type=material&license_mask=4
Global Const $kWebSiteBeforeParams = "https://www.materialmaker.org/materials?"
Global Const $kCountParamName = "count"
Global Const $kCountParamValue = "1000"

Global Const $kTypeParamName = "type"
Global Const $kTypeParamValue = "material"

Global Const $kTypeLicenseMaskParamName = "license_mask"
Global Const $CC_BY_LicenseMask = "1"
Global Const $CC0_LicenseMask = "2"
Global Const $CC_BY_SA_LicenseMask = "4"

Global $kLicenseMasks[3]
$kLicenseMasks[0] = $CC_BY_LicenseMask
$kLicenseMasks[1] = $CC0_LicenseMask
$kLicenseMasks[2] = $CC_BY_SA_LicenseMask

Global Const $kCCBYLicenseFilePath = @ScriptDir & "\" & "License - Attribution 4.0 International (CC BY 4.0).txt"
Global Const $kCCZeroLicenseFilePath = @ScriptDir & "\" & "License - CC0 1.0 Universal (CC0 1.0) Public Domain Dedication.txt"

Global Const $kColumnsCountOnPage = 5
Global Const $kRowsCountOnPage = 3
; Distance Between two rows
Global Const $kRowHeight = 280
; Distance Between two column
Global Const $kColumnWidth = 276

; Coordinate X of First Download icon on top of page with CC-BY filter
Global Const $kAssetDownloadX = 530

Global Const $kAssetNameShiftX = 186
Global Const $kAssetNameShiftY = 15
;Global Const $kAssetCenterShiftX = 90
;Global Const $kAssetCenterShiftY = 100

; Indent from Top of Page while scrolling down
Global Const $kPageDonwsCount_CC_BY = 11
Global $kDonwloadHeighIndent_CC_BY[$kPageDonwsCount_CC_BY]
$kDonwloadHeighIndent_CC_BY[0] = 450
$kDonwloadHeighIndent_CC_BY[1] = 392
$kDonwloadHeighIndent_CC_BY[2] = 333
$kDonwloadHeighIndent_CC_BY[3] = 276
$kDonwloadHeighIndent_CC_BY[4] = 217
$kDonwloadHeighIndent_CC_BY[5] = 160 ;- здесь 4 строки
$kDonwloadHeighIndent_CC_BY[6] = 382
$kDonwloadHeighIndent_CC_BY[7] = 324
$kDonwloadHeighIndent_CC_BY[8] = 265
$kDonwloadHeighIndent_CC_BY[9] = 208
$kDonwloadHeighIndent_CC_BY[10] = 315

;FirstAssetName 344, 435
;FirstAssetCenter 440, 350
;FirstDownload 530, 450
;SecondDownload 806, 450

Global Const $kPageDonwsCount_CCZero = 16
Global $kDonwloadHeighIndent_CCZero[$kPageDonwsCount_CCZero]
$kDonwloadHeighIndent_CCZero[0] = 450
$kDonwloadHeighIndent_CCZero[1] = 391
$kDonwloadHeighIndent_CCZero[2] = 334
$kDonwloadHeighIndent_CCZero[3] = 276
$kDonwloadHeighIndent_CCZero[4] = 218
$kDonwloadHeighIndent_CCZero[5] = 160 ;- здесь 4 строки
$kDonwloadHeighIndent_CCZero[6] = 382
$kDonwloadHeighIndent_CCZero[7] = 324
$kDonwloadHeighIndent_CCZero[8] = 266
$kDonwloadHeighIndent_CCZero[9] = 207
$kDonwloadHeighIndent_CCZero[10] = 149 ;- здесь 4 строки
$kDonwloadHeighIndent_CCZero[11] = 372
$kDonwloadHeighIndent_CCZero[12] = 314
$kDonwloadHeighIndent_CCZero[13] = 256
$kDonwloadHeighIndent_CCZero[14] = 197
$kDonwloadHeighIndent_CCZero[15] = 315


DownloadModelsFromWebSite()
Exit


Func DownloadAsset(Const $download_folder_path, ByRef $asset_name, ByRef $asset_folder, Const $duplicates, Const $page_down, Const $row, Const $column, Const $heigh_indent)
    Local Const $x1 = BalanceX($kAssetDownloadX + $column * $kColumnWidth)
    Local Const $y1 = BalanceY($heigh_indent + $row * $kRowHeight)
    MouseClick($MOUSE_CLICK_LEFT, $x1, $y1, 1, $kMouseSpeed) ; Click download icon
    ;MsgBox($MB_OK, "Check", "$x1 " & $x1 & " $y1 " & $y1)
    SleepWithGlobalSpeed(4600)  ; Wait for downloading start
    For $i = 0 To 4
        Send("{SHIFTDOWN}{LEFT}{SHIFTUP}")
        SleepWithGlobalSpeed(350)
    Next
    CopyOperationWithSleep()
    $asset_name = GetCopyBufferText()
    CorrectNameForOS($asset_name)
    If CreateAssetFolder($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
        ChooseFileExplorerFolder($asset_folder)     ; Choose where to download 3D Model asset
        Return True
    Else
        Return False
    EndIF
EndFunc

Func PrepareTabMaterialMaker()
    SendCtrlPushed("{HOME}")
    ResetWebSiteScale()
EndFunc

Func SetMaterialMakerWebAddress(Const $count_p, Const $type_p, Const $license)
    ; https://www.materialmaker.org/materials?count=1000&type=material&license_mask=4
    Local $web_address = $kWebSiteBeforeParams
    $web_address = $web_address & $kCountParamName & "=" & $count_p & "&"
    $web_address = $web_address & $kTypeParamName & "=" & $type_p & "&"
    $web_address = $web_address & $kTypeLicenseMaskParamName & "=" & $license
    SetWebAddress($web_address)
EndFunc

Func OpenAsset(Const $page_down_index, Const $row, Const $column, Const $heigh_indent)
    Local Const $x1 = BalanceX($kAssetDownloadX - $kAssetNameShiftX + $column * $kColumnWidth)
    Local Const $y1 = BalanceY($heigh_indent - $kAssetNameShiftY + $row * $kRowHeight)
    MouseClick($MOUSE_CLICK_LEFT, $x1, $y1, 1, $kMouseSpeed) 
    SleepWithGlobalSpeed(5500)  ; Wait for openning new tab with asset, asset name & preview
EndFunc

Func ResetAssetPage(Const $page_down)
    Send("{HOME}")
    SleepWithGlobalSpeed(750)
    PageDownNSleep($page_down)
EndFunc

Func CC_BY(Const $ini_path, Const $duplicates, Const $download_folder_path, $continue_flag, ByRef $asset_name, ByRef $asset_folder)
    SetMaterialMakerWebAddress($kCountParamValue, $kTypeParamValue, $kLicenseMasks[0])
    UpdateTab()
    PrepareTabMaterialMaker()
    SleepWithGlobalSpeed(600)

    Local $page_down
    Local $row
    Local $column
    Local $rows_max
    
    If $continue_flag == True Then
        $page_down = IniReadInt($ini_path, $kGeneralIniSection, $kPageDownIniKeyName, 0)
    Else
        $page_down = 0
    EndIf
    For $page_down = $page_down To $kPageDonwsCount_CC_BY - 1
        ;MsgBox($MB_OK, "Check", "$page_down = " & $page_down)
        If $page_down <> 5 Then
            $rows_max = $kRowsCountOnPage - 1
        Else    ; $kDonwloadHeighIndent[5] - здесь 4 строки
            $rows_max = $kRowsCountOnPage
        EndIf

        If $continue_flag == True Then  ; First Initialization of indexes
            $row = IniReadInt($ini_path, $kGeneralIniSection, $kRowIniKeyName, 0)
            PageDownNSleep($page_down)
        Else 
            $row = 0
        EndIf

        For $row = $row To $rows_max
            ;MsgBox($MB_OK, "Check", "$row = " & $row & " $rows_max = " & $rows_max)
            If $continue_flag == True Then
                $continue_flag = False
                $column = IniReadInt($ini_path, $kGeneralIniSection, $kColumnIniKeyName, 0)
            Else 
                $column = 0
            EndIf
            For $column = $column To $kColumnsCountOnPage - 1
                ;MsgBox($MB_OK, "Check", "$column = " & $column)
                If DownloadAsset($download_folder_path, $asset_name, $asset_folder, $duplicates, $page_down, $row, $column, $kDonwloadHeighIndent_CC_BY[$page_down]) Then
                    OpenAsset($page_down, $row, $column, $kDonwloadHeighIndent_CC_BY[$page_down])
                    SaveWebAddress($asset_folder)
                    FileCopy($kCCBYLicenseFilePath, $asset_folder)
                    ;DownloadPreviewSnipSketch($asset_folder, 934, 225, 1500, 770)
                    DownloadImageLightShot($asset_folder, 934, 225, 1500, 770)
                    MouseClick($MOUSE_CLICK_LEFT, 928, 115, 1, $kMouseSpeed)  ; To prevent web address input
                    SleepWithGlobalSpeed(800)
                    GoBackOnePage(8000)  ;GoBackOnePageNSleep($kWebSiteLoad)
                    ResetAssetPage($page_down)
                EndIf
            Next
        Next
        PageDownNSleep()
    Next
EndFunc

Func CC_Zero(Const $ini_path, Const $duplicates, Const $download_folder_path, $continue_flag, ByRef $asset_name, ByRef $asset_folder)
    SetMaterialMakerWebAddress($kCountParamValue, $kTypeParamValue, $kLicenseMasks[1])
    UpdateTab()
    PrepareTabMaterialMaker()
    SleepWithGlobalSpeed(600)

    Local $page_down
    Local $row
    Local $column
    Local $rows_max
    
    If $continue_flag == True Then
        $page_down = IniReadInt($ini_path, $kGeneralIniSection, $kPageDownIniKeyName, 0)
    Else
        $page_down = 0
    EndIf
    For $page_down = $page_down To $kPageDonwsCount_CCZero - 1
        ;MsgBox($MB_OK, "Check", "$page_down = " & $page_down)
        If $page_down <> 5 And $page_down <> 10 Then
            $rows_max = $kRowsCountOnPage - 1
        Else    ; $kDonwloadHeighIndent[5] - здесь 4 строки || $kDonwloadHeighIndent[10] - здесь 4 строки
            $rows_max = $kRowsCountOnPage
        EndIf

        If $continue_flag == True Then  ; First Initialization of indexes
            $row = IniReadInt($ini_path, $kGeneralIniSection, $kRowIniKeyName, 0)
            PageDownNSleep($page_down)
        Else 
            $row = 0
        EndIf
        
        ;MsgBox($MB_OK, "Check", "Before For Loop $row = " & $row & " $rows_max = " & $rows_max)
        For $row = $row To $rows_max
            ;MsgBox($MB_OK, "Check", "$row = " & $row & " $rows_max = " & $rows_max)
            If $continue_flag == True Then
                $continue_flag = False
                $column = IniReadInt($ini_path, $kGeneralIniSection, $kColumnIniKeyName, 0)
            Else 
                $column = 0
            EndIf
            For $column = $column To $kColumnsCountOnPage - 1
                ;MsgBox($MB_OK, "Check", "$column = " & $column)
                If DownloadAsset($download_folder_path, $asset_name, $asset_folder, $duplicates, $page_down, $row, $column, $kDonwloadHeighIndent_CCZero[$page_down]) Then
                    OpenAsset($page_down, $row, $column, $kDonwloadHeighIndent_CCZero[$page_down])
                    SaveWebAddress($asset_folder)
                    FileCopy($kCCZeroLicenseFilePath, $asset_folder)
                    ;DownloadPreviewSnipSketch($asset_folder, 934, 225, 1500, 770)
                    DownloadImageLightShot($asset_folder, 934, 225, 1500, 770)
                    MouseClick($MOUSE_CLICK_LEFT, 928, 115, 1, $kMouseSpeed)  ; To prevent web address input
                    SleepWithGlobalSpeed(800)
                    GoBackOnePage(8000)  ;GoBackOnePageNSleep($kWebSiteLoad)
                    ResetAssetPage($page_down)
                EndIf
            Next
        Next
        PageDownNSleep()
    Next
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
        Local $continue_flag = IniReadBool($ini_path, $kGeneralIniSection, $kContinueFlagIniKeyName, $kBoolFalse)

        Local $asset_name
        Local $asset_folder
        While WinGetTitle($hWnd) <> $kWindowStartPageTitle
            ; Download One Big Page of Assets at a time. Comment other Big Page
            ;CC_BY($ini_path, $duplicates, $download_folder_path, $continue_flag, $asset_name, $asset_folder)
            CC_Zero($ini_path, $duplicates, $download_folder_path, $continue_flag, $asset_name, $asset_folder)

            ;CloseTab()
            SwitchTab()
            ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        WEnd
        MsgBox($MB_OK, "Check", "WinGetTitle($hWnd) == $kWindowStartPageTitle. Downloads Ended.")
    EndIf
EndFunc