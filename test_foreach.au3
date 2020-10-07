#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Testing of the array reccurence.

#ce ----------------------------------------------------------------------------

;#include <file.au3>
#include "csvString2array.au3"
#include <file.au3>
#include "fileRead.au3"

; predefined variables
$parametersFileName = "parameters.txt"
$aidaReportFileName = "C:" & "\report.csv"

; body of the script
Local $parameters
_FileReadToArray($parametersFileName, $parameters, $FRTA_NOCOUNT)
;MsgBox(0, "CurrentLineContent: ", $parameters[3] )




;declaration -------------------------------------
Local $CurrentLineContent
Local $separator
Local $enclose

$aidaReportFile = _FileRead ($aidaReportFileName) ; handle for aida file

;loop for file reading  --------------------------
While 1
	$CurrentLineContent = FileReadLine ( $aidaReportFile )
	If @error = -1 Then ExitLoop
	;MsgBox(0, "CurrentLineContent: ", $CurrentLineContent )
	$currentLineAsArray = _CSVString2array($CurrentLineContent , $separator = ',', $enclose = '"' )
	;_ArrayDisplay (  $currentLineAsArray , "ArrayDisplay" )

WEnd

