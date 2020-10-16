
Func _ParseData($parametersFileName, $aidaReportFileName)


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
		If $skipCsvRow  = False  And $skipCurrentString = False Then
			;By parameters
			For $i=0 To UBound($parameters)-1
				$currentParameter = _CSVString2array( $parameters[$i], ',', '"' )
				Local $parameterMatched = TRUE
				if UBound($currentParameter) < 6  Then ; if unconditional line
					$parameterMatched = FALSE
				EndIf
				;By parameter cells
				If $parameterMatched = TRUE Then	; if not unconditional line, parse it
					For $ii=0 To 5	;tentetive
						If StringLen($currentParameter[$ii]) >0 Then
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

				if $parameterMatched = TRUE Then
					For $iii=0 To 5
						$collectedData[$outRow][$iii] = $currentLineAsArray[$iii]
					Next
					if $iii < UBound($currentParameter) Then
						For $iii=$iii To UBound($currentParameter)-1
							$options[$outRow][$iii-6] = $currentParameter[$iii]
						Next
					EndIf
	;~ 				MsgBox (0, UBound($currentLineAsArray), UBound($currentLineAsArray))
					$outRow = $outRow + 1
	;~ 				_ArrayDisplay($currentParameter, '$currentParameter')

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
;~ 	_ArrayDisplay($collectedData, 'OUT')
	;~ _ArrayDisplay($options, 'OUT')

	; Run data processing
	$collectedData = _DataProcessing ($collectedData, $options)
;~ 	_ArrayDisplay($collectedData, 'collectedData')

	$collectedData = _ArrayToCSV($collectedData, Default);, @CRLF

;~ 	MsgBox (0, 'csv Outcome', $collectedData)
	Return $collectedData
EndFunc



