#include <Constants.au3>
#include <MsgBoxConstants.au3>

#include "C:\Development\Projects\IT\Programming\!git-web\public\web-sites-parsing\web-browser-parsing.au3"
;#include "Y:\web-browser-parsing.au3"


Global Const $kParserName = "3dtextures"
Global Const $kGoogleSearchText = "download " & $kParserName & " assets"

Global Const $kWindowStartPageTitle = $kGoogleSearchText & Localization("kGoogleSearchTextEnding")
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Google Search — Mozilla Firefox"
;Global Const $kWindowStartPageTitle = $kGoogleSearchText & " - Поиск в Google — Mozilla Firefox"
Global Const $kWindowTitleClass = "[TITLE:" & $kWindowStartPageTitle & "; CLASS:" & $kWindowClass & "]"

Global Const $kIniFileName = "download-models-from-" & $kParserName & ".ini"
Global Const $kDefaultDownloadFolder = @ScriptDir & "\script-downloads\3dtextures\"

Global Const $kCCLicenseFilePath = @ScriptDir & "\" & "License - CC0 1.0 Universal (CC0 1.0) Public Domain Dedication.txt"
; "https://3dtextures.me/tag/floor/page/2/"
;Global Const $kWebSiteBeforeParams = "https://3dtextures.me/tag"

Global Const $kCategoryIniKey = "category"
Global Const $kPageIniKey = "page"
Global Const $kRowIniKey = "row"
Global Const $kColumnIniKey = "column"

Global Const $kAssetsOnPage = 21
Global Const $kKeyDownsFromTop = 4
Global Const $kKeyDownsBetweenAssets = 9

Global Const $kAssetTableColumnsCount = 3
Global Const $kAssetTableRowsCount = 7
; Distance Between two rows
Global Const $kAssetTableRowHeight = 108
; Distance Between two column
Global Const $kAssetTableColumnWidth = 81

Global Const $kFirstAssetCenterX = 898
Global Const $kFirstAssetCenterY = 159
; Scale = 100
; 653, 284
; 926, 283
; 652, 642
; Scale = 30
; 863, 145
; 944, 144
; 863, 253

Global Const $kWebSiteLoadTime = 7000
Global Const $kWebScaleDownCount = 5
Global Const $kSwitchFlag = False
Global Const $kPrevArrowHeight = 21     ; 166 - 145 

Global Const $kCategoriesCount = 49
Global $kCategoryTags[$kCategoriesCount]
$kCategoryTags[0] = "abstract"
$kCategoryTags[1] = "alien"
$kCategoryTags[2] = "alpha-brushes"
$kCategoryTags[3] = "animal"
$kCategoryTags[4] = "asphalt"
$kCategoryTags[5] = "brick"
$kCategoryTags[6] = "ceiling"
$kCategoryTags[7] = "concrete"
$kCategoryTags[8] = "default"
$kCategoryTags[9] = "dirt"
$kCategoryTags[10] = "fabric"
$kCategoryTags[11] = "floor"
$kCategoryTags[12] = "foliage"
$kCategoryTags[13] = "food"
$kCategoryTags[14] = "gems"
$kCategoryTags[15] = "glass"
$kCategoryTags[16] = "granite"
$kCategoryTags[17] = "ground"
$kCategoryTags[18] = "hand-painted"
$kCategoryTags[19] = "ice"
$kCategoryTags[20] = "lava"
$kCategoryTags[21] = "leather"
$kCategoryTags[22] = "marble"
$kCategoryTags[23] = "metal"
$kCategoryTags[24] = "misc"
$kCategoryTags[25] = "organic"
$kCategoryTags[26] = "paper-and-cardboard"
$kCategoryTags[27] = "patreon-exclusive"
$kCategoryTags[28] = "plaster"
$kCategoryTags[29] = "plastic"
$kCategoryTags[30] = "quartz"
$kCategoryTags[31] = "rocks"
$kCategoryTags[32] = "roof"
$kCategoryTags[33] = "rubber"
$kCategoryTags[34] = "sand"
$kCategoryTags[35] = "sci-fi"
$kCategoryTags[36] = "snow"
$kCategoryTags[37] = "soil"
$kCategoryTags[38] = "stone"
$kCategoryTags[39] = "stone-floor"
$kCategoryTags[40] = "stylized-textures"
$kCategoryTags[41] = "substance-designer"
$kCategoryTags[42] = "surface-imperfections"
$kCategoryTags[43] = "texturing-examples"
$kCategoryTags[44] = "tiles"
$kCategoryTags[45] = "vegetable"
$kCategoryTags[46] = "wall"
$kCategoryTags[47] = "water"
$kCategoryTags[48] = "wood"


Global $kMaterialsCount[49]
$kMaterialsCount[0] = 17
$kMaterialsCount[1] = 6
$kMaterialsCount[2] = 3
$kMaterialsCount[3] = 22
$kMaterialsCount[4] = 9
$kMaterialsCount[5] = 26
$kMaterialsCount[6] = 11
$kMaterialsCount[7] = 49
$kMaterialsCount[8] = 11
$kMaterialsCount[9] = 34
$kMaterialsCount[10] = 166
$kMaterialsCount[11] = 108
$kMaterialsCount[12] = 3
$kMaterialsCount[13] = 8
$kMaterialsCount[14] = 7
$kMaterialsCount[15] = 13
$kMaterialsCount[16] = 3
$kMaterialsCount[17] = 105
$kMaterialsCount[18] = 4
$kMaterialsCount[19] = 3
$kMaterialsCount[20] = 6
$kMaterialsCount[21] = 25
$kMaterialsCount[22] = 27
$kMaterialsCount[23] = 302
$kMaterialsCount[24] = 3
$kMaterialsCount[25] = 42
$kMaterialsCount[26] = 9
$kMaterialsCount[27] = 2
$kMaterialsCount[28] = 5
$kMaterialsCount[29] = 13
$kMaterialsCount[30] = 3
$kMaterialsCount[31] = 38
$kMaterialsCount[32] = 29
$kMaterialsCount[33] = 4
$kMaterialsCount[34] = 10
$kMaterialsCount[35] = 115
$kMaterialsCount[36] = 4
$kMaterialsCount[37] = 5
$kMaterialsCount[38] = 164
$kMaterialsCount[39] = 7
$kMaterialsCount[40] = 52
$kMaterialsCount[41] = 5
$kMaterialsCount[42] = 10
$kMaterialsCount[43] = 4
$kMaterialsCount[44] = 130
$kMaterialsCount[45] = 6
$kMaterialsCount[46] = 157
$kMaterialsCount[47] = 10
$kMaterialsCount[48] = 149


Global $kCategoryNames[$kCategoriesCount]
$kCategoryNames[0] = "Abstract"
$kCategoryNames[1] = "Alien"
$kCategoryNames[2] = "Alpha Brushes"
$kCategoryNames[3] = "Animal"
$kCategoryNames[4] = "Asphalt"
$kCategoryNames[5] = "Brick"
$kCategoryNames[6] = "Ceiling"
$kCategoryNames[7] = "Concrete"
$kCategoryNames[8] = "Default"
$kCategoryNames[9] = "Dirt"
$kCategoryNames[10] = "Fabric"
$kCategoryNames[11] = "Floor"
$kCategoryNames[12] = "Foliage"
$kCategoryNames[13] = "Food"
$kCategoryNames[14] = "Gems"
$kCategoryNames[15] = "Glass"
$kCategoryNames[16] = "Granite"
$kCategoryNames[17] = "Ground"
$kCategoryNames[18] = "Hand Painted"
$kCategoryNames[19] = "Ice"
$kCategoryNames[20] = "Lava"
$kCategoryNames[21] = "Leather"
$kCategoryNames[22] = "Marble"
$kCategoryNames[23] = "Metal"
$kCategoryNames[24] = "Misc"
$kCategoryNames[25] = "Organic"
$kCategoryNames[26] = "Paper and Cardboard"
$kCategoryNames[27] = "Patreon Exclusive"
$kCategoryNames[28] = "Plaster"
$kCategoryNames[29] = "Plastic"
$kCategoryNames[30] = "Quartz"
$kCategoryNames[31] = "Rocks"
$kCategoryNames[32] = "Roof"
$kCategoryNames[33] = "Rubber"
$kCategoryNames[34] = "Sand"
$kCategoryNames[35] = "Sci-Fi"
$kCategoryNames[36] = "Snow"
$kCategoryNames[37] = "Soil"
$kCategoryNames[38] = "Stone"
$kCategoryNames[39] = "Stone Floor"
$kCategoryNames[40] = "Stylized Textures"
$kCategoryNames[41] = "Substance Designer"
$kCategoryNames[42] = "Surface Imperfections"
$kCategoryNames[43] = "Texturing Examples"
$kCategoryNames[44] = "Tiles"
$kCategoryNames[45] = "Vegetable"
$kCategoryNames[46] = "Wall"
$kCategoryNames[47] = "Water"
$kCategoryNames[48] = "Wood"


Global Const $MeoFirstAssetDownloadX = 184
Global Const $MeoFirstAssetDownloadY = 479
Global Const $kMeoAssetsDownloadHorizontalIndent = 212
Global Const $kMeoAssetsDownloadVerticalIndent = 296
; 396, 479
; 185, 775


DownloadNameNPreviewFromWebSite()
Exit


Func SetMaterialSiteWebAddress(Const $category_index, Const $page_number)
    ; "https://3dtextures.me/tag/floor/page/2/"
    Local $web_address = "https://3dtextures.me/"
    If 2 == $category_index Or 8 == $category_index Or 13 == $category_index Or 15 == $category_index Or 18 == $category_index Or 26 == $category_index Or 27 == $category_index Or 33 == $category_index Or 40 == $category_index Or 42 == $category_index Or 43 == $category_index Then
        $web_address = $web_address & "category/"
    Else
        $web_address = $web_address & "tag/"
    EndIf
    $web_address = $web_address & $kCategoryTags[$category_index] & "/"
    $web_address = $web_address & "page/" & $page_number & "/"
    SetWebAddress($web_address)
    SleepWithGlobalSpeed($kWebSiteLoadTime)
    ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
EndFunc

Func DownloadAssetNamePreviewLicense(Const $download_folder_path, ByRef $asset_folder, Const $duplicates)
    SleepWithGlobalSpeed(1000)
    ResetWebSiteScale()
    SleepWithGlobalSpeed($kWebSiteLoadTime)

    Local $asset_name = GetFileNameShiftEnd(653, 198)
    If CreateAssetFolder($download_folder_path, $asset_name, $asset_folder, $duplicates) Then
        ;MsgBox($MB_OK, "Check", "Asset Folder has been created.")
        FileCopy($kCCLicenseFilePath, $asset_folder)
        ;ContextMenuSaveImageAs($asset_folder, 1052, 651)
        ;DownloadPreviewSnipSketch($asset_folder, 654, 268, 1435, 1066)
        DownloadImageLightShot($asset_folder, 654, 268, 1435, 1066)
        SaveWebAddress($asset_folder)
    EndIf
    ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
    GoBackOnePage($kWebSiteLoadTime)
    ChangeWebSiteScale($kWebScaleDownCount)
    SleepWithGlobalSpeed(500)
EndFunc

Func IsStartPage(Const $web_address_after_click)
    Return "https://www.google.com/search?q=download+3dtextures+assets" == $web_address_after_click
EndFunc

Func IsMeoCloud(Const $web_address_after_click)
    Return "https://meocloud" == StringMid($web_address_after_click, 1, 16)
EndFunc

Func IsGoogleDrive(Const $web_address_after_click)
    Return "https://drive.google.com" == StringMid($web_address_after_click, 1, 24)
EndFunc

Func IsYoutube(Const $web_address_after_click)
    Return "https://www.youtube.com" == StringMid($web_address_after_click, 1, 23)
EndFunc
Func IsTexturesPayStore(Const $web_address_after_click)
    Return "https://www.redbubble.com" == StringMid($web_address_after_click, 1, 25)
EndFunc
Func IsBuyCoffee(Const $web_address_after_click)
    Return "https://ko-fi.com" == StringMid($web_address_after_click, 1, 17)
EndFunc
Func IsBecomePatron(Const $web_address_after_click)
    Return "https://www.patreon.com" == StringMid($web_address_after_click, 1, 23)
EndFunc

Func CloseTabUpdateAddress()
    CloseTab()
    Return GetWebAddress()
EndFunc

Func CorrectMisclick(ByRef $web_address_after_click)
    Local Const $indent = 5
    If IsYoutube($web_address_after_click) Then
        $web_address_after_click = CloseTabUpdateAddress()
        ;MsgBox($MB_OK, "Check", "IsYoutube $web_address_after_click " & $web_address_after_click & (587 - 445))
        Return $indent + 591 - 457 ; = 134
    EndIf

    ; 3D Textures
    If IsTexturesPayStore($web_address_after_click) Then
        $web_address_after_click = CloseTabUpdateAddress()
        ;MsgBox($MB_OK, "Check", "IsTextures $web_address_after_click " & $web_address_after_click)
        Return $indent + 735 - 662 - 10 ; 
    EndIf

    If IsBuyCoffee($web_address_after_click) Then
        GoBackOnePage(8000)
        $web_address_after_click = GetWebAddress()
        ;MsgBox($MB_OK, "Check", "IsBuyCoffee $web_address_after_click " & $web_address_after_click)
        Return $indent + 822 - 796
    EndIf

    If IsBecomePatron($web_address_after_click) Then
        $web_address_after_click = CloseTabUpdateAddress()
        ;MsgBox($MB_OK, "Check", "IsBecomePatron $web_address_after_click " & $web_address_after_click)
        Return $indent + 882 - 849
    EndIf

    Return 0
EndFunc

Func DownloadAsset(Const $asset_folder, Const $duplicates)
    SleepWithGlobalSpeed(1000)
    PrepareTab($kWebScaleDownCount)
    SleepWithGlobalSpeed($kWebSiteLoadTime)

    Local Const $asset_origin_web_address = GetWebAddress()
    Local $web_address_after_click = GetWebAddress()
    Local Const $vertical_indent = 10
    Local $i = 1
    Local $i_max = 100
    Local $correction_y = 0
    Local $y = 0
    Local $start_y = 140    ; 300 = default 140 = for pages without image
    While $asset_origin_web_address == $web_address_after_click And $i <= $i_max
        For $j = 0 To 9
            $y = CutTaskBarY(CheckCoordinateY($start_y + $vertical_indent * $i + $j + $correction_y))
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(906), BalanceY($y), 1, 1) ; Second Try Click to start downloading
        Next
        SleepWithGlobalSpeed(4500)
        $web_address_after_click = GetWebAddress()
        $correction_y = $correction_y + CorrectMisclick($web_address_after_click)
        $i = $i + 1
        
        ;If $web_address_after_click <> $asset_origin_web_address And Not (IsGoogleDrive($web_address_after_click) Or IsMeoCloud($web_address_after_click)) Then ; If many garbage tabs opened, close them
            ;MsgBox($MB_OK, "Check", "IF: Deleting extra tabs")
            ;While $web_address_after_click <> $asset_origin_web_address
                ;MsgBox($MB_OK, "Check", "Deleting extra tabs start")
                ;$web_address_after_click = CloseTabUpdateAddress()
            ;WEnd
        ;EndIf
    WEnd

    ;MsgBox($MB_OK, "Check", "Ending of downloading asset start")
    ResetWebSiteScale()
    SleepWithGlobalSpeed(600)
    If $asset_origin_web_address <> $web_address_after_click Then
        If IsStartPage($web_address_after_click) Then
            SendCtrlPushed("t")
            SleepWithGlobalSpeed(1500)
        ElseIf IsGoogleDrive($web_address_after_click) Then
            SleepWithGlobalSpeed(3500)
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(348), BalanceY(226), 1, $kMouseSpeed)    ; Disable focus on web address
            SleepWithGlobalSpeed(1000)
            SendCtrlPushed("a")
            SleepWithGlobalSpeed(3000)
            MouseClick($MOUSE_CLICK_RIGHT, BalanceX(378), BalanceY(383), 1, $kMouseSpeed)
            SleepWithGlobalSpeed(4000)
            MouseClick($MOUSE_CLICK_LEFT, BalanceX(476), BalanceY(668), 1, $kMouseSpeed)
            SleepWithGlobalSpeed(8000)
            ChooseFileExplorerFolder($asset_folder)
            CloseTab()
        ElseIf IsMeoCloud($web_address_after_click) Then
            MouseMove(BalanceX($MeoFirstAssetDownloadX), BalanceY($MeoFirstAssetDownloadY), $kMouseSpeed)
            SleepWithGlobalSpeed(1700)
            Local $continue_loop = True
            Local $row = 0
            Local $column = 0
            Local Const $columns_count = 9
            Local Const $rows_count = 5
            While $continue_loop And $row < $rows_count And $column < $columns_count
                MouseClick($MOUSE_CLICK_LEFT, BalanceX($MeoFirstAssetDownloadX + $column * $kMeoAssetsDownloadHorizontalIndent), BalanceY($MeoFirstAssetDownloadY + $row * $kMeoAssetsDownloadVerticalIndent), 1, $kMouseSpeed)
                SleepWithGlobalSpeed(6000)
                If WinExists($kDownloadFileTitleClass) Then
                    ChooseFileExplorerFolder($asset_folder)
                    If $columns_count - 1 == $column Then
                        $row = $row + 1
                        $column = 0
                    Else
                        $column = $column + 1
                    EndIf
                Else
                    $continue_loop = False
                EndIF
            WEnd
            CloseTab()
        Else
            SleepWithGlobalSpeed(5000)
            $web_address_after_click = GetWebAddress()
            If $asset_origin_web_address <> $web_address_after_click Then
                CloseTab()
            EndIf
        EndIf
    EndIf
EndFunc

; First Realization Divide Downloading Asset preview & web address. Divide with Asset download
Func DownloadAssetIsolated(Const $download_folder_path, ByRef $asset_folder, Const $duplicates)
    SwitchKeyboardLanguageTo()
    SleepWithGlobalSpeed(1000)
    ResetWebSiteScale()
    SleepWithGlobalSpeed($kWebSiteLoadTime)

    Local $asset_name = GetFileNameShiftEnd(653, 198)
    ;MsgBox($MB_OK, "Check", "$$asset_name " & $asset_name)
    $asset_folder = GetAssetFolderPath($download_folder_path, $asset_name)
    ;MsgBox($MB_OK, "Check", "$asset_folder " & $asset_folder)
    
    If FileExists($asset_folder) Then
        DownloadAsset($asset_folder, $duplicates)
    EndIf
    ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
    GoBackOnePage($kWebSiteLoadTime)
    ChangeWebSiteScale($kWebScaleDownCount)
    SleepWithGlobalSpeed(500)
EndFunc

Func DownloadNameNPreviewFromWebSite()
    SetHotKeyToExit()
    WinActivate($kWindowTitleClass)
    SwitchKeyboardLanguageTo()
    Local $hWnd = WinWaitActiveFixedTimeout($kWindowTitleClass)
    If $hWnd <> 0 Then
        WinSetState($hWnd, "", @SW_MAXIMIZE)
        SwitchTab()

        Local Const $ini_path = $kCurrentFolder & $kIniFileName
        Local Const $duplicates = IniReadBool($ini_path, $kGeneralIniSection, $kDuplicatesIniKeyName, $kBoolTrue)
        Local Const $download_folder_path = CreateAllAssetsDirFromIni($ini_path, $kGeneralIniSection, $kDownloadFolderIniKeyName, $kDefaultDownloadFolder)

        Local $category = IniReadInt($ini_path, $kGeneralIniSection, $kCategoryIniKey, 0)
        Local $page = IniReadInt($ini_path, $kGeneralIniSection, $kPageIniKey, 0)
        Local $row = IniReadInt($ini_path, $kGeneralIniSection, $kRowIniKey, 0)
        Local $column = IniReadInt($ini_path, $kGeneralIniSection, $kColumnIniKey, 0)
        ;MsgBox($MB_OK, "Check", "$category = " & $category)

        Local $asset_folder = ""
        While WinGetTitle($hWnd) <> $kWindowStartPageTitle
            UpdateTab($kWebSiteLoadTime)
            SleepWithGlobalSpeed(600)
            
            Local $pages_count = 0
            Local $category_folder_path = ""
            Local $row_max = 0
            Local $column_max = 0
            Local $assets_on_last_page = 0
            Local $quotient = 0
            Local $remainder = 0
            Local $asset_x = 0
            Local $asset_y = 0
            For $category = $category To $kCategoriesCount - 1
                $pages_count = Ceiling($kMaterialsCount[$category] / $kAssetsOnPage)
                ;MsgBox($MB_OK, "Check", "$page = " & $page & " $pages_count = " & $pages_count)
                For $page = $page To $pages_count - 1
                    ;MsgBox($MB_OK, "Check", "$page = " & $page & " $pages_count = " & $pages_count)
                    If $page <> $pages_count - 1 Then
                        $row_max = $kAssetTableRowsCount - 1
                        $column_max = $kAssetTableColumnsCount - 1
                    Else
                        $assets_on_last_page = $kMaterialsCount[$category] - $kAssetsOnPage * $page
                        $quotient = Floor($assets_on_last_page / $kAssetTableColumnsCount)
                        $remainder = Mod($assets_on_last_page, $kAssetTableColumnsCount)
                        $row_max = $quotient - 1
                        If 0 <> $remainder Then
                            $row_max = $row_max + 1
                        EndIf
                    EndIf

                    SetMaterialSiteWebAddress($category, $page + 1)
                    PrepareTab($kWebScaleDownCount)
                    SleepWithGlobalSpeed(600)
                    $category_folder_path = $download_folder_path & $kCategoryNames[$category] & "\"
                    CreateAllAssetsDir($download_folder_path)

                    ;MsgBox($MB_OK, "Check", "$row = " & $row & " $row_max = " & $row_max)
                    For $row = $row To $row_max
                        If $page == $pages_count - 1 And $row == $row_max Then      ; Last Page and Last Row
                            If 0 == $remainder Then     ; Mod = 0 => All columns in row
                                $column_max = $kAssetTableColumnsCount
                            Else    ; Not full row of assets
                                $column_max = $remainder - 1
                            EndIf
                        ElseIf $page == $pages_count - 1 And $row < $row_max Then      ; Last Page, but not last row
                            $column_max = $kAssetTableColumnsCount - 1
                        EndIf
                        ;MsgBox($MB_OK, "Check", "$column = " & $column & " $column_max = " & $column_max)
                        For $column = $column To $column_max
                            $asset_x = $kFirstAssetCenterX + $column * $kAssetTableColumnWidth
                            $asset_y = $kFirstAssetCenterY + $row * $kAssetTableRowHeight
                            If 0 <> $page Then
                                $asset_y = $asset_y + $kPrevArrowHeight
                            EndIf
                            ;MsgBox($MB_OK, "Check", "$row" & $row & "$column " & $column)
                            MouseClick($MOUSE_CLICK_LEFT, BalanceX($asset_x), BalanceY($asset_y), 1, $kMouseSpeed) ; Click to Open Asset
                            ;DownloadAssetNamePreviewLicense($category_folder_path, $asset_folder, $duplicates)
                            DownloadAssetIsolated($category_folder_path, $asset_folder, $duplicates)
                        Next
                        $column = 0
                    Next
                    $row = 0
                Next
                ;MsgBox($MB_OK, "Check", "$page = 0")
                $page = 0
            Next
            $category = 0

            ;CloseTab()
            SwitchTab()
            ;MsgBox($MB_OK, "Check", "Everything is ok? Has asset been downloaded? ")
        WEnd
        MsgBox($MB_OK, "Check", "WinGetTitle($hWnd) == $kWindowStartPageTitle. Downloads Ended.")
    EndIf
EndFunc