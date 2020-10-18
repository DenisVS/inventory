



;~ ReDim $options[UBound($collectedData)][10]
$columnsCounter = UBound($data, $UBOUND_COLUMNS)
;~ MsgBox($MB_SYSTEMMODAL, "$deparament", $deparament)
;~ MsgBox($MB_SYSTEMMODAL, "$columnsCounter", $columnsCounter)
ReDim $data[2][$columnsCounter+9]

	$data[0][$columnsCounter+0] = 'deparament'
	$data[1][$columnsCounter+0] = GUICtrlRead($deparament)

	$data[0][$columnsCounter+1] = 'full_user_name'
	$data[1][$columnsCounter+1] = GUICtrlRead($fullUserName)

	$data[0][$columnsCounter+2] = 'phone'
	$data[1][$columnsCounter+2] = GUICtrlRead($phone)

	$data[0][$columnsCounter+3] = 'admin_login'
	$data[1][$columnsCounter+3] = GUICtrlRead($adminLogin)

	$data[0][$columnsCounter+4] = 'admin_password'
	$data[1][$columnsCounter+4] = GUICtrlRead($adminPassword)

	$data[0][$columnsCounter+5] = 'user_login'
	$data[1][$columnsCounter+5] = GUICtrlRead($userLogin)

	$data[0][$columnsCounter+6] = 'user_password'
	$data[1][$columnsCounter+6] = GUICtrlRead($userPassword)

	$data[0][$columnsCounter+7] = 'connected_to'
	$data[1][$columnsCounter+7] = GUICtrlRead($connectedTo)

	$data[0][$columnsCounter+8] = 'remarks'
	$data[1][$columnsCounter+8] = GUICtrlRead($remarks)


;~ 	MsgBox(0,'$parameters',$parameters[$i])
        ;If Not StringLen($parameters[$i+1][0])>0 Then ExitLoop

_ArrayDisplay($data)