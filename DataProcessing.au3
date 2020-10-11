#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Data processing before sending to the server.

#ce ----------------------------------------------------------------------------

Func _DataProcessing ($data, $options)
	Local $whichCellsToContent[6]
	Local $currentLine[6]
	Local $rowOptions[10]
	For $i=0 To UBound($data)-1
		For $ii=0 To 5
			$currentLine[$ii] = $data[$i][$ii]
		Next
		For $ii=0 To 9
			$rowOptions[$ii] = $options[$i][$ii]
		Next
;~ 		_ArrayDisplay($currentLine, '$data')
;~ 		_ArrayDisplay($rowOptions, '$rowOptions')

		; define columns
		$columnName = $rowOptions[1]

		$rowOptions[2] = 'jop'
		$cell = StringSplit ( $rowOptions[2], "" , 2 )
		ReDim $cell[UBound($cell)]
		_ArrayDisplay($cell, 'jopanoviy')

;~ $columnContent =
		;$whichCellsToContent =
	Next

EndFunc
