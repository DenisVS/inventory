; #AutoIt3Wrapper_AU3Check_Parameters=-d -w 3 -w 4 -w 5 -w 6
#include-once

;===============================================================================

;===============================================================================
Func _CSVString2array($rawString, $separator = ',', $enclose = '"' )


$sContent = 'New York,test,"The best place to be, if you have the money",other test,"quoted",Larry'

$aresult = StringRegExp($rawString,'(?:".*?")+|(?<=,|^)[^,]*(?=,|$)', 3)
;_ArrayDisplay($aresult)


Return $aresult

#cs

        For $i = 0 To UBound($csv) - 1
            If MsgBox(0x40001, 'CSV Data', $csv[$i]) = $IDCANCEL Then
                ExitLoop 2
            EndIf
        Next


	Local $pattern = '(?m)'                      ; multi-line search mode
	$pattern &= '\G(?:^|[' & $separator & '])'   ; start of line or start of field
	$pattern &= '(?:'                            ; one of two options:
	$pattern &= $enclose                         ;   a field starting with at double quote
	$pattern &= StringFormat('([^%s]*+(?:%s%s[^%s]*+)*+)', $enclose, $enclose, $enclose, $enclose)
	;                                            ;   (quote-pairs and any non-quote chars)
	$pattern &= $enclose                         ;   a double quote ending the field
	$pattern &= '(\r?\n?)'                       ;   (any sort of line ending here?)
	$pattern &= '|'                              ; or:
	$pattern &= '([^"' & $separator & '\r\n]*+)' ;   (a simple CSV field, no quotes or commas)
	$pattern &= '(\r?\n?)'                       ;   (any sort of line ending here?)
	$pattern &= ')'                              ; note that we should have 4 captures per CSV element

	Local $aRawData = StringRegExp( $sRawData, $pattern, 4 )
	If @error <> 0 Then
		SetError( 3 )
		Return 0
	EndIf

$sRawData = ''  ; we're done with this, and it might be large
	Local $i, $aMatch
	Local $colCount = 0, $maxCols = 0
	Local $rowCount = 0

	For $i=0 To UBound($aRawData)-1
		$aMatch = $aRawData[$i]

		If $colCount == 0 Then
			$rowCount += 1			; we're looking at the first field on the current row
		EndIf

		$colCount += 1

		If $colCount > $maxCols Then
			$maxCols = $colCount	; longest row so far...
		EndIf

		If $aMatch[2] <> '' OR (UBound($aMatch) > 3 AND $aMatch[4] <> '') Then
			$colCount = 0			; row complete, we might start a new one
		EndIf
	Next

	;; we now know how large to make our 2D output array

	Local $aCsvData[$rowCount][$maxCols]
 _ArrayDisplay (  $aCsvData , "ArrayDisplay" )

 #ce
 ;MsgBox(0, "Lines of ", " ddd "& $aCsvData[$rowCount][$maxCols] )

	;Return $csv
	;Return $aCsvData
EndFunc

