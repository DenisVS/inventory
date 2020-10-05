#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <file.au3>
#include "csvString2array.au3"
#include "fileRead.au3"

$inFileName = "C:" & "\report.csv"
;$inFileName = "C:\temp" & "\test.txt"

Local $parameters
_FileReadToArray('parameters.txt', $parameters, $FRTA_NOCOUNT)
;MsgBox(0, "CurrentLineContent: ", $parameters[3] )
$inFile = _FileRead ($inFileName)

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

