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


	;$curRowExistedTable	- counter of the rows in existed table
	;$curCellExistedTable - counter of the cells in the line of the existed table
	For $curRowExistedTable=0 To UBound($data)-1
		For $curCellExistedTable=0 To 5
			$currentLine[$curCellExistedTable] = $data[$curRowExistedTable][$curCellExistedTable]
		Next
		For $curCellExistedTable=0 To 9
			$rowOptions[$curCellExistedTable] = $options[$curRowExistedTable][$curCellExistedTable]
		Next
;~ 		_ArrayDisplay($currentLine, '$data')
;~ 		_ArrayDisplay($rowOptions, '$rowOptions')


		; What should we do if the current row equals to a previous
		if	_ArrayCompare($previousLine, $currentLine) = True And $curRowExistedTable > 0	Then
;~ 			_ArrayDisplay($currentLine, '$currentLine')
;~ 			_ArrayDisplay($previousLine, '$previousLine')
;~ 			$paramPlus = $paramPlus + 1

		Else
	;~ 		MsgBox (0, '$paramPlus ', $paramPlus)



			; define columns name by option 0
			$table[0][$curRowExistedTable] = $rowOptions[0]	;columnName	; With header



			; define columns from which we get the parameters
			$cell = StringSplit ( $rowOptions[1], "" , 2 )
			ReDim $cell[UBound($cell)]
			Local $currentParameterValue = ''
			For $curCellOptions=0 To UBound($cell)-1
				if $rowOptions[2] = 0 Then
					$table[1][$curRowExistedTable - $paramPlus] &= $currentLine[$cell[$curCellOptions]]	; With header
		;~ 			$table[0][$curRowExistedTable - $paramPlus] &= $currentLine[$cell[$curCellOptions]]	; Without header
					$currentParameterValue &= $currentLine[$cell[$curCellOptions]]
				EndIf
				if $rowOptions[2] = 1 Then
					$table[1][$curRowExistedTable - $paramPlus] &= " " & $currentLine[$cell[$curCellOptions]]	; With header
		;~ 			$table[0][$curRowExistedTable - $paramPlus] &= " " & $currentLine[$cell[$curCellOptions]]	; Without header
					$currentParameterValue &= " " & $currentLine[$cell[$curCellOptions]]
				EndIf
				if $rowOptions[2] = 2 Then
					$table[1][$curRowExistedTable - $paramPlus] &= "|" & $currentLine[$cell[$curCellOptions]]	; With header
		;~ 			$table[0][$curRowExistedTable - $paramPlus] &= "|" & $currentLine[$cell[$curCellOptions]]	; Without header
					$currentParameterValue &= " | " & $currentLine[$cell[$curCellOptions]]
				EndIf
				if $rowOptions[2] = 3 Then
					$table[1][$curRowExistedTable - $paramPlus] &= "\n" & $currentLine[$cell[$curCellOptions]]	; With header
		;~ 			$table[0][$curRowExistedTable - $paramPlus] &= "\n" & $currentLine[$cell[$curCellOptions]]	; Without header
					$currentParameterValue &= "\n" & $currentLine[$cell[$curCellOptions]]
				EndIf
			Next

	;~ 		MsgBox (0, 'column', $columnName &@CRLF& $table[$curRowExistedTable][1])




	; What should we do with duplicates according to option 3
	;~ 		if	$table[1][$curRowExistedTable - $paramPlus] = $previousParameterValue	Then	; With header
	;~ 	 	if	$table[0][$curRowExistedTable - $paramPlus] = $previousParameterValue	Then	; Without header
	;~ 			$paramPlus = $paramPlus + 1
	;~ 		EndIf
			$previousParameterValue = $currentParameterValue
			$previousLine = $currentLine
		EndIf
	Next
	_ArrayDisplay (  $table , 'Result' )
	Return $table
EndFunc
