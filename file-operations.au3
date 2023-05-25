;================================== Work with files

Global Const $kLogFileFullName = "web-parsing.log"

Func TextFileWrite(Const $file_path, Const $text, Const $open_mode = $FO_APPEND)
    Local $hFileOpen = FileOpen($file_path, $open_mode)
    If $hFileOpen = -1 Then
            MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
            Return False
    EndIf

    ; Write data to the file using the handle returned by FileOpen.
    FileWrite($hFileOpen, $text)

    ; Close the handle returned by FileOpen.
    FileClose($hFileOpen)
    Return True
EndFunc

Func TextFileRead(Const $file_path)
    Local $hFileOpen = FileOpen($file_path, $FO_READ)
    If $hFileOpen = -1 Then
            MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
            Return False
    EndIf

    ; Read the contents of the file using the handle returned by FileOpen.
    Local $text_of_file = FileRead($hFileOpen)

    ; Close the handle returned by FileOpen.
    FileClose($hFileOpen)
    Return $text_of_file
EndFunc

Func TextFileRewrite(Const $file_path, Const $text)
    TextFileWrite($file_path, $text, $FO_OVERWRITE)
EndFunc

Func TextFileAppend(Const $file_path, Const $text)
    TextFileWrite($file_path, $text, $FO_APPEND)
EndFunc

Func TextFileAppendLn(Const $file_path, Const $text)
    TextFileAppend($file_path, $text & @CRLF)
EndFunc

Func LogFileWriteToDir(Const $text, Const $dir_path = @WorkingDir, Const $open_mode = $FO_APPEND)
    Local $ch = "\"
    ; Check last char
    If StringInStr($dir_path, $ch, 0, 1, StringLen($dir_path), 1) Then 
        $ch = ""
    EndIf
    TextFileWrite($dir_path & $ch & $kLogFileFullName, $text, $open_mode)
EndFunc

Func LogFileRewriteToDir(Const $text, Const $dir_path = @WorkingDir)
    LogFileWriteToDir($text, $dir_path, $FO_OVERWRITE)
EndFunc

Func LogFileAppendToDir(Const $text, Const $dir_path = @WorkingDir)
    LogFileWriteToDir($text, $dir_path, $FO_APPEND)
EndFunc

Func LogFileAppendLnToDir(Const $text, Const $dir_path = @WorkingDir, Const $open_mode = $FO_APPEND)
    LogFileAppendToDir($text & @CRLF, $dir_path)
EndFunc

;==================================================================