#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	main software
#ce ----------------------------------------------------------------------------

#include "csvString2array.au3"
#include <file.au3>
#include "fileRead.au3"
#include "Loga.au3"
#include "StringFilter.au3"

; Predefined variables ---------------------
;~ AutoItSetOption ("TrayIconDebug", 1);0-off
;~ #AutoIt3Wrapper_Run_Debug_Mode=Y
$parametersFileName = "parameters.csv"
$aidaReportFileName = "Report.csv"
;$aidaReportFileName = "C:" & "\report.csv"

;declaration -------------------------------------
Local $CurrentLineContent
Local $separator
Local $enclose
Local $parameters

;-------------------- body of the script

_FileReadToArray($parametersFileName, $parameters, $FRTA_NOCOUNT)
;~ _ArrayDisplay (  $parameters , "ArrayDisplay" )
$aidaReportFile = _FileRead ($aidaReportFileName) ; handle for aida file

;loop for file reading  --------------------------
While 1
;~ 	$skipLine = False
 	$skipCsvRow = False
	$CurrentLineContent = FileReadLine ( $aidaReportFile )
	If @error = -1 Then ExitLoop
;~ 	If StringLen($CurrentLineContent) < 10 Then $skipLine = True
	If StringLen($CurrentLineContent) < 10 Then $skipCsvRow = True
	$currentLineAsArray = _CSVString2array($CurrentLineContent , $separator = ',', $enclose = '"' )
;~ 	if UBound($currentLineAsArray) < 6 Then $skipLine = True
	if UBound($currentLineAsArray) < 6 Then $skipCsvRow = True
$skipCurrentString = _StringFilter($CurrentLineContent)

;~ 	_LogaDebug ('$CurrentLineContent: ' & $CurrentLineContent)
;	_ArrayDisplay (  $currentLineAsArray , "current Line As Array" )

	If $skipCsvRow  = False  And $skipCurrentString = False Then
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
	;~ 				_LogaDebug( '$currentParameter[$ii] ' & $currentParameter[$ii])
	;~ 				_LogaDebug( '$currentLineAsArray[$ii] ' & $currentLineAsArray[$ii])
					if Not($currentParameter[$ii] = $currentLineAsArray[$ii]) Then
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
	EndIf
WEnd
Exit
