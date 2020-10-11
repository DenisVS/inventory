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
		$columnName = $rowOptions[0]

		$cell = StringSplit ( $rowOptions[1], "" , 2 )
		ReDim $cell[UBound($cell)]
		Local $columnContent =''
		For $iii=0 To UBound($cell)-1
			$columnContent &= $currentLine[$cell[$iii]]
		Next
		MsgBox (0, 'column', $columnName &@CRLF& $columnContent)




;~ $columnContent =
		;$whichCellsToContent =
	Next

EndFunc
