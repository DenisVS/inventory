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
				ExitLoop 1
			EndIf
		Next

		; What should we do if the current row equals to a previous somewhere
		if	$duplicate = False Then

			; What should we do with duplicates according to option 3
			Local $iIndex = -1
			if $rowOptions[3] = 4 Then
				; In which column the same header cell?
				$iIndex = _ArraySearch($table, $rowOptions[0], 0, 0, 0, 0, 0, Default, True)

			EndIf





			; define columns from which we get the parameters
			$cell = StringSplit ( $rowOptions[1], "" , 2 )
			ReDim $cell[UBound($cell)]
			Local $crParamVl = ''
			Local $paramVal = ''
			For $crCllOpt=0 To UBound($cell)-1
				if $rowOptions[2] = "" Then
					$paramVal = ""	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] = $crLn[$cell[$crCllOpt]]	; Without header
;~ 					$crParamVl = $crLn[$cell[$crCllOpt]]
				EndIf
				if $rowOptions[2] = 0 Then
					$paramVal &= $crLn[$cell[$crCllOpt]]	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] &= $crLn[$cell[$crCllOpt]]	; Without header
					$crParamVl &= $crLn[$cell[$crCllOpt]]
				EndIf
				if $rowOptions[2] = 1 Then
					$paramVal &= " " & $crLn[$cell[$crCllOpt]]	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] &= " " & $crLn[$cell[$crCllOpt]]	; Without header
					$crParamVl &= " " & $crLn[$cell[$crCllOpt]]
				EndIf
				if $rowOptions[2] = 2 Then
					$paramVal &= "|" & $crLn[$cell[$crCllOpt]]	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] &= "|" & $crLn[$cell[$crCllOpt]]	; Without header
					$crParamVl &= "|" & $crLn[$cell[$crCllOpt]]
				EndIf
				if $rowOptions[2] = 3 Then
					$paramVal &= "\n" & $crLn[$cell[$crCllOpt]]	; With header
		;~ 			$table[0][$crRwExstdTablN - $paramPlus] &= "\n" & $crLn[$cell[$crCllOpt]]	; Without header
					$crParamVl &= "\n" & $crLn[$cell[$crCllOpt]]
				EndIf
$paramVal = Trim($paramVal)

			Next

			; Probably here we are concatinate values of the specific cell from different rows
			if $iIndex >= 0	Then
				$table[1][$iIndex] = $table[1][$iIndex] & "|" & $paramVal
				$paramPlus = $paramPlus + 1
;~ 				_ArrayDisplay (  $table , '$table' )
			Else
				; define columns name by option 0
				$table[0][$crRwExstdTablN - $paramPlus] = $rowOptions[0]	;columnName	; With header
				$table[1][$crRwExstdTablN - $paramPlus] = $paramVal
			EndIf
			$prevParamVl = $crParamVl
			$prevLn = $crLn
		EndIf
	Next
	ReDim $table[UBound($table)][UBound($data)-$paramPlus]
;~ 	_ArrayDisplay (  $testTable , 'test Table' )
;~ 	_ArrayDisplay (  $table , '$table' )
	Return $table
EndFunc
