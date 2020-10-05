;Процедура открытия файла на чтение
;Открывем входной файл $inFileName


Func _FileRead ($inFileName)
	$inFile = FileOpen($inFileName, 0)
	; Проверить, есть ли входной файл
	If $inFile = -1 Then
		MsgBox(0, "Ошибка", "Файл не найден.")
		Exit
	EndIf
	Return $inFile
EndFunc