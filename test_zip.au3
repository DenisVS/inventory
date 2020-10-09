#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Testing of the array reccurence.

#ce ----------------------------------------------------------------------------

#include "csvString2array.au3"
#include <file.au3>
#include "fileRead.au3"

; predefined variables
$parametersFileName = "1.csv"
$parametersFileName = "parameters.txt"
$aidaReportFileName = "C:" & "\report.csv"

; body of the script
Local $parameters
_FileReadToArray($parametersFileName, $parameters, $FRTA_NOCOUNT)
;_ArrayDisplay (  $parameters , "ArrayDisplay" )


;MsgBox(0,'$parameters',UBound($parameters))

Local $actualParameterCells
;foreach analog for array of parameters
For $i=0 To UBound($parameters)-1
	MsgBox(0,'$parameters[n]',$parameters[$i])
	$currentParameter = _CSVString2array( $parameters[$i], ',', '"' )
	_ArrayDisplay (  $currentParameter , "ArrayDisplay this string" )
	For $ii=0 To UBound($currentParameter)-1
		MsgBox(0,'$currentParameter',$currentParameter[$ii])
		MsgBox(0,'StringLen',StringLen($currentParameter[$ii]))
		If StringLen($currentParameter[$ii]) >0 Then
			MsgBox(0,' >0 ', '> 0')
			if $currentParameter[$ii] = $currentParameter[$ii] Then
				MsgBox(0,'Actual',$currentParameter[$ii])




			EndIf
		EndIf
	Next
	;If Not StringLen($parameters[$i+1][0])>0 Then ExitLoop
Next

Exit

;declaration -------------------------------------
Local $CurrentLineContent
Local $separator
Local $enclose

$aidaReportFile = _FileRead ($aidaReportFileName) ; handle for aida file

;loop for file reading  --------------------------
While 1
	$CurrentLineContent = FileReadLine ( $aidaReportFile )
	If @error = -1 Then ExitLoop
	$currentLineAsArray = _CSVString2array($CurrentLineContent , $separator = ',', $enclose = '"' )
WEnd

