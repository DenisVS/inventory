#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

;#RequireAdmin
;RunWait(@ComSpec & " /c c:\PF\Aida6biz\aida64.exe /R c:\report.xml /CSV /SILENT /CUSTOM c:\PF\Aida6biz\aida64.rpf", "", @SW_HIDE) ;~ Runs command hidden
; /R report.xml /CSV /SILENT
;Run("c:\report.7z a " & $7Zfile & "  " & " " & " " & c:\report.xml)





 $ArcFile = "c:\temp" & "\zip_002.zip"
$FileName = "c:"  & "\report.xml"

$retResult = _7ZipAdd(0, $ArcFile, $FileName, 0, 5, 1, $sInclude, $sExclude)



