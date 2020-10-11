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
;~ 	Local $table[2][UBound($data)]	; With header
	Local $table[1][UBound($data)]	; Without header

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
;~ 		$table[0][$i] = $rowOptions[0]	;columnName	; With header

		$cell = StringSplit ( $rowOptions[1], "" , 2 )
		ReDim $cell[UBound($cell)]
;~ 		Local $table[$i][1] =''
		For $iii=0 To UBound($cell)-1
;~ 			$table[1][$i] &= $currentLine[$cell[$iii]]	; With header
			$table[0][$i] &= $currentLine[$cell[$iii]]	; Without header
		Next
;~ 		MsgBox (0, 'column', $columnName &@CRLF& $table[$i][1])




;~ $table[$i][1] =
		;$whichCellsToContent =
	Next
;~ 	_ArrayDisplay (  $table , 'Result' )
	Return $table
EndFunc
