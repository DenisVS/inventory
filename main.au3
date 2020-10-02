#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#RequireAdmin
RunWait(@ComSpec & " /c c:\PF\Aida6biz\aida64.exe /R c:\report.xml /CSV /SILENT /CUSTOM c:\PF\Aida6biz\aida64.rpf", "", @SW_HIDE) ;~ Runs command hidden
#RunWait(@ComSpec & " /c Aida6biz\aida64.exe /R c:\report.xml /CSV /SILENT", "", @SW_HIDE) ;~ Runs command hidden
# /R report.xml /CSV /SILENT