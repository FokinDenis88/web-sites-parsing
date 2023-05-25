Global Const $kCopyOperationText = "{CTRLDOWN}c{CTRLUP}"
Global Const $kPastOperationText = "{CTRLDOWN}v{CTRLUP}"
Global Const $kHotKeyToExit = "{LWINDOWN}{CTRLDOWN}z{CTRLUP}{LWINUP}"

Global Const $kWindowClass = "MozillaWindowClass"

Global Const $kCurrentFolder = @ScriptDir & "\"
Global Const $kGeneralIniSection = "General"
Global Const $kDownloadFolderIniKeyName = "downloads_folder"
Global Const $kDuplicatesIniKeyName = "duplicates"
Global Const $kDownloadsBrowserSettingName = "Downloads"
Global Const $kBoolTrue = "true"
Global Const $kBoolFalse = "false"

Global Const $kLicenseFileName = "license.txt"
Global Const $kCreditFileName = "credit.txt"
Global Const $kWebLinkFileName = "web.txt"
Global Const $kPreviewFileName = "preview.png"
Global Const $kAssetFileName = "asset_name.txt"

; Resolution in which coordinates were calculated
Global Const $kOriginalResolutionX = 1920
Global Const $kOriginalResolutionY = 1080
Global Const $kTaskBarHeight = 30
Global Const $kTaskBarStartY = $kOriginalResolutionY - $kTaskBarHeight


Global Const $ScriptSpeedGlobal = 145   ; Percents of speed. For Original Windows 130. For VirtualBox 140.
Global Const $kMouseSpeed = 7  ; Default = 10
Global Const $kWebSiteLoad = 23000
Global Const $kStandardDelay = 500
Global Const $kWinWaitActiveTimeout = 25000

Global Const $kWindowsRestrictedCharactersInFileName = '\/:*?"<>|.'       ; \/:*?"<>|

Global Const $kSnipSketchBannerIsEnabled = False

Global Const $kLocaleENG = "ENG"
Global Const $kLocaleRUS = "RUS"
;Global Const $kCurrentLocale = $kLocaleRUS
Global Const $kCurrentLocale = $kLocaleENG

; Localization on Fire Fox Depends on language in settings. Not by language of OS.
Global Const $kDownloadFileTitleClass = "[TITLE:Enter name of file to save to…; CLASS:#32770]"
Global Const $kSaveAsFileConfirmationTitleClass = "[TITLE:Confirm Save As; CLASS:#32770]"
Global Const $kSaveImageAsTitleClass = "[TITLE:Save Image; CLASS:#32770]"
Global Const $kInternetBrowserClass = "[CLASS:MozillaWindowClass]"
; ============================================================================

Global Const $kGoogleSearchTextEndingENG = " - Google Search — Mozilla Firefox"
Global Const $kGoogleSearchTextEndingRUS = " - Поиск в Google — Mozilla Firefox"


Global Const $kSnipSketchFileTitleClass = "[TITLE:Snip & Sketch; CLASS:ApplicationFrameWindow]"
Global Const $kSaveSnipSketchImageAsTitleClass = "[TITLE:Save As; CLASS:#32770]"

Global Const $kSaveLightShotImageAsTitleClassENG = "[TITLE:Save As; CLASS:#32770]"
Global Const $kSaveLightShotImageAsTitleClassRUS = "[TITLE:Сохранение; CLASS:#32770]"


Global Const $kButtonSaveX = 1738
Global Const $kButtonSaveY = 1045
Global Const $kButtonCancelX = 1851
Global Const $kButtonCancelY = 1045


Global Const $LangKB_Russian = "Russian - Russia"
Global Const $LangKB_German = "German - Germany"
Global Const $LangKB_English_USA = "English - United States"
Global Const $LangKB_Spain = "Spanish - Spain"
Global Const $LangKB_Finnish = "Finnish - Finland"
Global Const $LangKB_French = "French - France"
Global Const $LangKB_Italian = "Italian - Italy"
Global Const $LangKB_Dutch = "Dutch - Netherlands"
Global Const $LangKB_Norwegian = "Norwegian (Bokmal) - Norway"
Global Const $LangKB_Polish = "Polish - Poland"
Global Const $LangKB_Portuguese = "Portuguese - Brazil"
Global Const $LangKB_Swedish = "Swedish - Sweden"