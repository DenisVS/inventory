#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <file.au3>
#include "csvString2array.au3"
#include "fileRead.au3"
#include <HTTP.au3>


$inFileName = "C:" & "\report.csv"
;$inFileName = "C:\temp" & "\test.txt"

Local $parameters
_FileReadToArray('parameters.txt', $parameters, $FRTA_NOCOUNT)
MsgBox(0, "CurrentLineContent: ", $parameters[3] )
$inFile = _FileRead ($inFileName)
;_HTTP_Upload("http://inventory.bvsz.ru/importData.php", '1.txt', "file", "pwd=123&filename=" & URLEncode("test.txt") )



$hFile = FileOpen('1.csv', 0)

; Проверяет, является ли файл открытым, перед тем как использовать функции чтения/записи в файл
If $hFile = -1 Then
    MsgBox(4096, "Ошибка", "Невозможно открыть файл.")
    Exit
EndIf
$sChars = FileRead($hFile)
MsgBox(4096, "Ошибка", $sChars)
FileClose($hFile)

Local $submitData[1]
$submitData["data"] = $sChars;
;_HTTP_Post("http://inventory.bvsz.ru/importData.php", $sChars)
Local $sResp = _HTTP_Post("http://inventory.bvsz.ru/importPostData.php?name=" & URLEncode("importSubmit"),  "data=" & URLEncode($sChars))
ConsoleWrite($sResp)


$countOfLines = _FileCountLines ($inFileName)
Local $CurrentLineContent

Local $separator
Local $enclose
;$a = _CSVString2array('"s,s",454,"jh,guihk",5568' , $separator = ',', $enclose = '"' )
_ArrayDisplay (  $parameters , "ArrayDisplay" )
;_ArrayDisplay (  $a , "ArrayDisplay" )



;#cs
While 1
	$CurrentLineContent = FileReadLine ( $inFile )
	If @error = -1 Then ExitLoop
;	MsgBox(0, "CurrentLineContent: ", $CurrentLineContent )
	$aaa = _CSVString2array($CurrentLineContent , $separator = ',', $enclose = '"' )
_ArrayDisplay (  $aaa , "ArrayDisplay" )

WEnd
;#ce

