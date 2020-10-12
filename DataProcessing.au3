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
	Local $table[2][UBound($data)]	; With header
;~ 	Local $table[1][UBound($data)]	; Without header
	Local $previousParameterValue = ''
	Local $previousLine
	Local $paramPlus = 0


	;$i1	- counter of the rows in existed table
	;$ii - counter of the cells in the line of the existed table
	For $i1=0 To UBound($data)-1
		For $ii=0 To 5
			$currentLine[$ii] = $data[$i1][$ii]
		Next
		For $ii=0 To 9
			$rowOptions[$ii] = $options[$i1][$ii]
		Next
;~ 		_ArrayDisplay($currentLine, '$data')
;~ 		_ArrayDisplay($rowOptions, '$rowOptions')


		; What should we do if the current row equals to a previous
		if	_ArrayCompare($previousLine, $currentLine) = True And $i1 > 0	Then
;~ 			_ArrayDisplay($currentLine, '$currentLine')
;~ 			_ArrayDisplay($previousLine, '$previousLine')
;~ 			$paramPlus = $paramPlus + 1

		Else
	;~ 		MsgBox (0, '$paramPlus ', $paramPlus)



			; define columns name by option 0
			$table[0][$i1] = $rowOptions[0]	;columnName	; With header



			; define columns from which we get the parameters
			$cell = StringSplit ( $rowOptions[1], "" , 2 )
			ReDim $cell[UBound($cell)]
			Local $currentParameterValue = ''
			For $iii=0 To UBound($cell)-1
				if $rowOptions[2] = 0 Then
					$table[1][$i1 - $paramPlus] &= $currentLine[$cell[$iii]]	; With header
		;~ 			$table[0][$i1 - $paramPlus] &= $currentLine[$cell[$iii]]	; Without header
					$currentParameterValue &= $currentLine[$cell[$iii]]
				EndIf
				if $rowOptions[2] = 1 Then
					$table[1][$i1 - $paramPlus] &= " " & $currentLine[$cell[$iii]]	; With header
		;~ 			$table[0][$i1 - $paramPlus] &= " " & $currentLine[$cell[$iii]]	; Without header
					$currentParameterValue &= " " & $currentLine[$cell[$iii]]
				EndIf
				if $rowOptions[2] = 2 Then
					$table[1][$i1 - $paramPlus] &= "|" & $currentLine[$cell[$iii]]	; With header
		;~ 			$table[0][$i1 - $paramPlus] &= "|" & $currentLine[$cell[$iii]]	; Without header
					$currentParameterValue &= " | " & $currentLine[$cell[$iii]]
				EndIf
				if $rowOptions[2] = 3 Then
					$table[1][$i1 - $paramPlus] &= "\n" & $currentLine[$cell[$iii]]	; With header
		;~ 			$table[0][$i1 - $paramPlus] &= "\n" & $currentLine[$cell[$iii]]	; Without header
					$currentParameterValue &= "\n" & $currentLine[$cell[$iii]]
				EndIf
			Next

	;~ 		MsgBox (0, 'column', $columnName &@CRLF& $table[$i1][1])




	; What should we do with duplicates according to option 3
	;~ 		if	$table[1][$i1 - $paramPlus] = $previousParameterValue	Then	; With header
	;~ 	 	if	$table[0][$i1 - $paramPlus] = $previousParameterValue	Then	; Without header
	;~ 			$paramPlus = $paramPlus + 1
	;~ 		EndIf
			$previousParameterValue = $currentParameterValue
			$previousLine = $currentLine
		EndIf
	Next
	_ArrayDisplay (  $table , 'Result' )
	Return $table
EndFunc
