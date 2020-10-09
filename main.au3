#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	main software
#ce ----------------------------------------------------------------------------

#include "csvString2array.au3"
#include <file.au3>
#include "fileRead.au3"

; predefined variables
$parametersFileName = "parameters.csv"
$aidaReportFileName = "C:" & "\report.csv"


; body of the script
Local $parameters
_FileReadToArray($parametersFileName, $parameters, $FRTA_NOCOUNT)
;_ArrayDisplay (  $parameters , "ArrayDisplay" )



Local $actualParameterCells


;Exit

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
	;_ArrayDisplay (  $currentLineAsArray , "current Line As Array" )

;#cs ----
	;By parameters
	For $i=0 To UBound($parameters)-1
		;MsgBox(0,'$parameters[n]',$parameters[$i])
		$currentParameter = _CSVString2array( $parameters[$i], ',', '"' )
		;_ArrayDisplay (  $currentParameter , "Array $currentParameter" )
		Local $parameterMatched = TRUE
		;By parameter cells
		For $ii=0 To UBound($currentParameter)-1
			;MsgBox(0,'$currentParameter',$currentParameter[$ii])
			;MsgBox(0,'StringLen',StringLen($currentParameter[$ii]))
			If StringLen($currentParameter[$ii]) >0 Then

				;MsgBox(0,' >0 ', '> 0')
				if $currentParameter[$ii] = $currentLineAsArray[$ii] Then
					;MsgBox(0,'currentParameter',$currentParameter[$ii])
					;MsgBox(0,'currentLine',$currentLineAsArray[$ii])
					;$parameterMatched = TRUE
				Else
					$parameterMatched = FALSE
				EndIf
			EndIf
		Next
		if $ii < 6  Then
			$parameterMatched = FALSE
		EndIf


		if $parameterMatched = TRUE Then
			_ArrayDisplay (  $currentLineAsArray , 'Matched string' )
			_ArrayDisplay (  $currentParameter , 'With Parameter' )
		EndIf
;If Not StringLen($parameters[$i+1][0])>0 Then ExitLoop
	Next
	;--/foreach analog for array of parameters
;#ce --





WEnd
Exit
