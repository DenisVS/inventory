#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Data processing before sending to the server.

#ce ----------------------------------------------------------------------------

Func _DataProcessing ($data, $options)
	Local $currentLine[6]
	For $i=0 To UBound($data)-1
		For $ii=0 To 5
			$currentLine[$ii] = $data[$i][$ii]
			;If Not StringLen($parameters[$i+1][0])>0 Then ExitLoop
		Next
			_ArrayDisplay($currentLine, '$data')
	Next

EndFunc
