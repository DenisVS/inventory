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
#include "ArrayDeleteEmptyRows.au3"
#include "WideRedim.au3"
#include "DataProcessing.au3"
#include "CSVSplit.au3"
;~ #include <HTTP.au3>
;~ #include <MAC.au3>
;~ #include "JSON.au3"


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


$dimensionOfData = UBound($parameters)
Local $collectedData[$dimensionOfData][6]
Local $options[$dimensionOfData][10]


;loop for file reading  --------------------------




$outRow = 0	;counter
While 1
 	$skipCsvRow = False
	$CurrentLineContent = FileReadLine ( $aidaReportFile )
	If @error = -1 Then ExitLoop
	If StringLen($CurrentLineContent) < 10 Then $skipCsvRow = True
	$currentLineAsArray = _CSVString2array($CurrentLineContent , $separator = ',', $enclose = '"' )
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

			if UBound($currentParameter) < 6  Then ; if unconditional line
				$parameterMatched = FALSE
			EndIf
			;By parameter cells
			If $parameterMatched = TRUE Then	; if not unconditional line, parse it
				For $ii=0 To 5	;tentetive
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
				If $parameterMatched = TRUE Then	; if conditional line, parse options
					For $ii = $ii To UBound($currentParameter)-1
						If StringLen($currentParameter[$ii]) >0 Then

						EndIf
					Next
				EndIf
			EndIf
;~ 			if $ii < 6  Then ; Probably if unconditional line (now upper)
;~ 				$parameterMatched = FALSE
;~ 			EndIf
			if $parameterMatched = TRUE Then
;~ 	 			_ArrayDisplay (  $currentLineAsArray , 'Matched string' )
;~ 	 			_ArrayDisplay (  $currentParameter , 'With Parameter' )

;~ 				For $iii=0 To UBound($currentParameter)-1
				For $iii=0 To 5
					$collectedData[$outRow][$iii] = $currentLineAsArray[$iii]
				Next
;~ 				MsgBox (0, UBound('D'), UBound($currentParameter)&' '& $iii)

				if $iii < UBound($currentParameter) Then
					For $iii=$iii To UBound($currentParameter)-1
						$options[$outRow][$iii-6] = $currentParameter[$iii]
					Next
				EndIf
;~ 				MsgBox (0, UBound($currentLineAsArray), UBound($currentLineAsArray))
				$outRow = $outRow + 1
			EndIf

			$collectedData = _WideRedim ($collectedData, $outRow, 6)
			$options = _WideRedim ($options, $outRow, 10)
		;If Not StringLen($parameters[$i+1][0])>0 Then ExitLoop
		Next
		;--/foreach analog for array of parameters
;~ #ce --


	EndIf


WEnd
$collectedData = _DeleteEmptyRows($collectedData)
ReDim $options[UBound($collectedData)][10]
;~ _ArrayDisplay($collectedData, 'OUT')
;~ _ArrayDisplay($options, 'OUT')
$result = _DataProcessing ($collectedData, $options)
;~ _ArrayDisplay($result, 'result')


$csvOutcome = _ArrayToCSV($result)
;~ FileWrite ( "test.csv", $csvOutcome )
MsgBox (0, '$csvOutcome', $csvOutcome)


;~ dddddddddddddddddddddddddddddddddddddddddddddddddddddddddd

; The data to be sent
$sPD = 'data=' & $csvOutcome


; Creating the object
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("POST", "http://inventory.bvsz.ru/importPostData.php", False)
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")

; Performing the Request
$oHTTP.Send($sPD)

; Download the body response if any, and get the server status response code.
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status

If $oStatusCode <> 200 then
 MsgBox(4096, "Response code", $oStatusCode)
EndIf

	_LogaDebug ($oReceived)
; Saves the body response regardless of the Response code
;~  $file = FileOpen("Received.log", 2) ; The value of 2 overwrites the file if it already exists
;~  FileWrite($file, $oReceived)
;~  FileClose($file)
;~ dddddddddddddddddddddddddddddddddddddddddddddddddddddddddd




Exit
