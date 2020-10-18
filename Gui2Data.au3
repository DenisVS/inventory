





;------------------------


	$columnsCounter = UBound($data, $UBOUND_COLUMNS)
	ReDim $data[2][$columnsCounter+10]



;-----------------------
	$data[0][$columnsCounter+0] = 'departament'
	$data[1][$columnsCounter+0] = GUICtrlRead($departament)

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

	$data[0][$columnsCounter+8] = 'upc'
	$data[1][$columnsCounter+8] = GUICtrlRead($upc)

	$data[0][$columnsCounter+9] = 'periphery'
	$data[1][$columnsCounter+9] = GUICtrlRead($periphery)
	$data[1][$columnsCounter+9] = StringReplace($data[1][$columnsCounter+9], ",", "|")

;~ 	MsgBox(0,'$parameters',$parameters[$i])
        ;If Not StringLen($parameters[$i+1][0])>0 Then ExitLoop

_ArrayDisplay($data)