#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
Func _WideRedim ($array, $currentRow, $horizontalDimension)
			$Bound = UBound($array)
 			if $currentRow+1 =  $Bound Then
				;MsgBox (0, "Redim", $currentRow )
				$Bound = $Bound * 1.3
				ReDim $array[$Bound][$horizontalDimension]
				;MsgBox (0, "How about?",  UBound($array) )
				;_ArrayDisplay($array, 'OUT')
			EndIf
	Return $array
EndFunc