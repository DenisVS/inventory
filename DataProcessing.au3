#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Data processing before sending to the server.

#ce ----------------------------------------------------------------------------

Func _DataProcessing ($data, $options)
	Local $whichCellsToContent[6]
	Local $crLn[6]
	Local $rowOptions[10]
	Local $table[2][UBound($data)]	; With header
;~ 	Local $table[1][UBound($data)]	; Without header
	Local $prevParamVl = ''
	Local $prevLn
	Local $paramPlus = 0
	Local $testTable[UBound($data)][6]

	;$crRwExstdTablN	- counter of the rows in existed table
	;$crCllExstdTblN - counter of the cells in the line of the existed table
	For $crRwExstdTablN=0 To UBound($data)-1
		For $crCllExstdTblN=0 To 5
			$crLn[$crCllExstdTblN] = $data[$crRwExstdTablN][$crCllExstdTblN]
			$testTable[$crRwExstdTablN][$crCllExstdTblN] = $data[$crRwExstdTablN][$crCllExstdTblN]	; We are saving current line from existed table to array sake of furter compare
		Next
		For $crCllExstdTblN=0 To 9
			$rowOptions[$crCllExstdTblN] = $options[$crRwExstdTablN][$crCllExstdTblN]
		Next
;~ 		_ArrayDisplay($crLn, '$data')
;~ 		_ArrayDisplay($rowOptions, '$rowOptions')

;~ _ArrayDisplay($testTable, '$testTable')
;~ 				MsgBox (0, 'UBound($testTable)', UBound($testTable))

		;Check if in testTable exists current line of existing data
		Local $duplicate = False
		Local $crCllTestTblN
		Local $crTestLn[6]
		For $crRwTestTablN=0 To $crRwExstdTablN-1
			For $crCllTestTblN=0 To 5
				$crTestLn[$crCllTestTblN] = $testTable[$crRwTestTablN][$crCllTestTblN]
			Next
			if  _ArrayCompare($crTestLn, $crLn) = True Then
;~ 				MsgBox (0, '$crRwTestTablN', $crRwTestTablN)

				$duplicate = True
				$paramPlus = $paramPlus + 1
;~ 				_ArrayDisplay($crLn, '$crLn')
;~ 				_ArrayDisplay($crTestLn, '$crTestLn')
;~ 				ExitLoop 2
			EndIf
		Next

;~ _ArrayDisplay($crLn, '$crLn')



		; What should we do if the current row equals to a previous
;~ 		if	_ArrayCompare($prevLn, $crLn) = True And $crRwExstdTablN > 0	Then
		if	$duplicate = False Then
;~ 			_ArrayDisplay($crLn, '$crLn')
;~ 			_ArrayDisplay($prevLn, '$prevLn')
;~ 			$paramPlus = $paramPlus + 1

;~ 		Else
	;~ 		MsgBox (0, '$paramPlus ', $paramPlus)



			; define columns name by option 0
			$table[0][$crRwExstdTablN - $paramPlus] = $rowOptions[0]	;columnName	; With header



			; define columns from which we get the parameters
			$cell = StringSplit ( $rowOptions[1], "" , 2 )
			ReDim $cell[UBound($cell)]
			Local $crParamVl = ''
			For $crCllOpt=0 To UBound($cell)-1
				if $rowOptions[2] = 0 Then
					$table[1][$crRwExstdTablN - $paramPlus] &= $crLn[$cell[$crCllOpt]]	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] &= $crLn[$cell[$crCllOpt]]	; Without header
					$crParamVl &= $crLn[$cell[$crCllOpt]]
				EndIf
				if $rowOptions[2] = 1 Then
					$table[1][$crRwExstdTablN - $paramPlus] &= " " & $crLn[$cell[$crCllOpt]]	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] &= " " & $crLn[$cell[$crCllOpt]]	; Without header
					$crParamVl &= " " & $crLn[$cell[$crCllOpt]]
				EndIf
				if $rowOptions[2] = 2 Then
					$table[1][$crRwExstdTablN - $paramPlus] &= "|" & $crLn[$cell[$crCllOpt]]	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] &= "|" & $crLn[$cell[$crCllOpt]]	; Without header
					$crParamVl &= " | " & $crLn[$cell[$crCllOpt]]
				EndIf
				if $rowOptions[2] = 3 Then
					$table[1][$crRwExstdTablN - $paramPlus] &= "\n" & $crLn[$cell[$crCllOpt]]	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] &= "\n" & $crLn[$cell[$crCllOpt]]	; Without header
					$crParamVl &= "\n" & $crLn[$cell[$crCllOpt]]
				EndIf
			Next

	;~ 		MsgBox (0, 'column', $columnName &@CRLF& $table[$crRwExstdTablN][1])




	; What should we do with duplicates according to option 3
	;~ 		if	$table[1][$crRwExstdTablN - $paramPlus] = $prevParamVl	Then	; With header
	;~ 	 	if	$table[0][$crRwExstdTablN - $paramPlus] = $prevParamVl	Then	; Without header
	;~ 			$paramPlus = $paramPlus + 1
	;~ 		EndIf
			$prevParamVl = $crParamVl
			$prevLn = $crLn
		EndIf
	Next
	_ArrayDisplay (  $testTable , 'test Table' )
	_ArrayDisplay (  $table , '$table' )
	Return $table
EndFunc
