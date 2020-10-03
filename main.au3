#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#RequireAdmin
;RunWait(@ComSpec & " /c c:\PF\Aida6biz\aida64.exe /R c:\report.xml /CSV /SILENT /CUSTOM c:\PF\Aida6biz\aida64.rpf", "", @SW_HIDE) ;~ Runs command hidden
; /R report.xml /CSV /SILENT
;Run("c:\report.7z a " & $7Zfile & "  " & " " & " " & c:\report.xml)

#include "Zip.au3"
Dim $Zip, $myfile
$myfile = "c:\report.xml"

$Zip = _Zip_Create("c:\zip_002.zip") ;Create The Zip File. Returns a Handle to the zip File
_Zip_AddFile($Zip,$myfile) ;add $myfile to the zip archive
;_Zip_AddFolder($Zip,@desktopdir & "\Folder_001",4) ;Add a folder to the zip file (files/subfolders will be added)
;_Zip_AddFolderContents($Zip, @DesktopDir & "\MyFolder") ;Add a folder's content in the zip file
MsgBox(0,"Items in Zip","there are " & _Zip_Count($Zip) & " items in " & $Zip) ;Msgbox Counting Items in $Zip
MsgBox(0,"Items in Zip","there are " & _Zip_CountAll($Zip) & " Elements in " & $Zip) ;Msgbox Counting Elements in $Zip
