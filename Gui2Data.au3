



;~ ReDim $options[UBound($collectedData)][10]
$columnsCounter = UBound($data, $UBOUND_COLUMNS)
MsgBox($MB_SYSTEMMODAL, "$deparament", $deparament)
MsgBox($MB_SYSTEMMODAL, "$columnsCounter", $columnsCounter)
ReDim $data[2][$columnsCounter+10]

	$data[0][$columnsCounter+1] = 'deparament'
	$data[1][$columnsCounter+1] = GUICtrlRead($deparament)

	$data[0][$columnsCounter+2] = 'full_user_name'
	$data[1][$columnsCounter+2] = GUICtrlRead($fullUserName)

	$data[0][$columnsCounter+3] = 'phone'
	$data[1][$columnsCounter+3] = GUICtrlRead($phone)

	$data[0][$columnsCounter+4] = 'admin_login'
	$data[1][$columnsCounter+4] = GUICtrlRead($adminLogin)

	$data[0][$columnsCounter+5] = 'admin_password'
	$data[1][$columnsCounter+5] = GUICtrlRead($adminPassword)

	$data[0][$columnsCounter+6] = 'user_login'
	$data[1][$columnsCounter+6] = GUICtrlRead($userLogin)
;~ 	MsgBox(0,'$userLogin',$userLogin)



	$data[0][$columnsCounter+7] = 'user_password'
	$data[1][$columnsCounter+7] = GUICtrlRead($userPassword)

	$data[0][$columnsCounter+8] = 'connected_to'
	$data[1][$columnsCounter+8] = GUICtrlRead($connectedTo)

	$data[0][$columnsCounter+9] = 'remarks'
	$data[1][$columnsCounter+9] = GUICtrlRead($remarks)


;~ 	MsgBox(0,'$parameters',$parameters[$i])
        ;If Not StringLen($parameters[$i+1][0])>0 Then ExitLoop

_ArrayDisplay($data)