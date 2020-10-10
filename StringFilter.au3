#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
Func _StringFilter ($ourString)
	$stop = False
	if StringInStr($ourString, "DLL Files") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "System Drivers") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Processes,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Services,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Certificates,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Video Modes,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Fonts,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Windows Devices,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Device Resources,") > 0 Then
		$stop = True
	EndIf
		if StringInStr($ourString, "File Types,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Windows Update,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "Event Logs,") > 0 Then
		$stop = True
	EndIf
	if StringInStr($ourString, "OneNote") > 0 Then
		$stop = True
	EndIf
;~ #cs
	if StringInStr($ourString, "Installed Programs") > 0 Then
		if StringInStr($ourString, "Redistributable") > 0 Then
			$stop = True
		EndIf
		if StringInStr($ourString, "Microsoft Visual") > 0 Then
			if StringInStr($ourString, "Runtime") > 0 Then
				$stop = True
			EndIf
		EndIf
		if StringInStr($ourString, "Language") > 0 Then
			$stop = True
		EndIf
		if StringInStr($ourString, "NVIDIA") > 0 Then
			$stop = True
		EndIf
		if StringInStr($ourString, "AMD") > 0 Then
			$stop = True
		EndIf
		if StringInStr($ourString, "INTEL") > 0 Then
			$stop = True
		EndIf
		if StringInStr($ourString, "Driver") > 0 Then
			$stop = True
		EndIf
		if StringInStr($ourString, "Update") > 0 Then
			$stop = True
		EndIf
		if StringInStr($ourString, "Plugin") > 0 Then
			$stop = True
		EndIf
	EndIf
;#ce
	if StringInStr($ourString, "Temperatures") > 0 Then
		if StringInStr($ourString, "Core") > 0 Then
			$stop = True
		EndIf
		if StringInStr($ourString, "Diode") > 0 Then
			$stop = True
		EndIf
	EndIf
	Return $stop
EndFunc
