Func _HttpPost($data)
	;~ dddddddddddddddddddddddddddddddddddddddddddddddddddddddddd

	; The data to be sent
	$sPD = 'data=' & $data


	; Creating the object
	$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$oHTTP.Open("POST", "http://inventory.bvsz.ru/importPostData.php", False)
	$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")

	; Performing the Request
	$oHTTP.Send($sPD)

	; Download the body response if any, and get the server status response code.
	$oReceived = $oHTTP.ResponseText
	$oStatusCode = $oHTTP.Status

	If $oStatusCode <> 200 then
	 MsgBox(4096, "Response code", $oStatusCode)
	EndIf

	;~ 	_LogaDebug ($oReceived)
	; Saves the body response regardless of the Response code
	;~  $file = FileOpen("Received.log", 2) ; The value of 2 overwrites the file if it already exists
	ConsoleWrite($oReceived)

;~  FileWrite($file, $oReceived)
;~  FileClose($file)
;~ 	MsgBox (0, StringInStr($oReceived, 'DATA_RECIEVED', 1), StringInStr($oReceived, 'DATA_RECIEVED', 1))

	if StringInStr($oReceived, 'DATA_RECIEVED', 1) > 0 Then
		Return True
	EndIf
EndFunc