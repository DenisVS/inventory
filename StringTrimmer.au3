#include-Once

; #INDEX# =======================================================================================================================
; Title .........: StringTrimmer
; AutoIt Version : 3.2.10++
; Language ......: Russian
; Description ...: ������� ��������� �����
; Author(s) .....: LunatikReal
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; Trim
; TrimLeft
; TrimRight
; TrimStr
; TrimStrLeft
; TrimStrRight
; NormalCenter
; NormalText
; ChkChar
; Copy
; Delete
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: Trim
; Description ...: ������� ������� � ���������� ������� � ���� ������, ��� ���������� ��������� $ch �������� ������ ���
; Syntax.........: Trim($Str[, $ch])
; Parameters ....: $Str - ������ ��� ���������
;                  $ch - ������ ��� ���������(�������������� ����������)
; Return values .: String
; Example .......: Trim(@TAB&" test "&@CRLF) => test, Trim("..test.", '.') => test, Trim('"test"', '"') => test
; ===============================================================================================================================
Func Trim($Str, $ch='')
	$L = 1
	$SL = StringLen($Str)
	While $L <= $SL And ChkChar(Copy($Str,$L), $ch)
		$L += 1
	WEnd
	$Str = StringRight($Str,$SL-$L+1)
	$L = StringLen($Str)
	While $L > 0 And ChkChar(Copy($Str,$L), $ch)
		$L -= 1
	WEnd
	Return StringLeft($Str,$L)
EndFunc   ;==>Trim

; #FUNCTION# ====================================================================================================================
; Name...........: TrimLeft
; Description ...: ������� ������� � ���������� ������� �����, ��� ���������� ��������� $ch �������� ������ ���
; Syntax.........: TrimLeft($Str[, $ch])
; Parameters ....: $Str - ������ ��� ���������
;                  $ch - ������ ��� ���������(�������������� ����������)
; Return values .: String
; Example .......: TrimLeft(@CRLF&" test") => test, TrimLeft("..test", '.') => test, TrimLeft('"test', '"') => test
; ===============================================================================================================================
Func TrimLeft($Str, $ch='')
	$L = 1
	$SL = StringLen($Str)
	While $L <= $SL And ChkChar(Copy($Str,$L), $ch)
		$L += 1
	WEnd
	Return StringRight($Str,$SL-$L+1)
EndFunc   ;==>TrimLeft

; #FUNCTION# ====================================================================================================================
; Name...........: TrimRight
; Description ...: ������� ������� � ���������� ������� ������, ��� ���������� ��������� $ch �������� ������ ���
; Syntax.........: TrimRight($Str[, $ch])
; Parameters ....: $Str - ������ ��� ���������
;                  $ch - ������ ��� ���������(�������������� ����������)
; Return values .: String
; Example .......: TrimRight("test "&@TAB) => test, TrimRight("test,,", ',') => test, TrimRight("test'''", "'") => test
; ===============================================================================================================================
Func TrimRight($Str, $ch='')
	$L = StringLen($Str)
	While $L > 0 And ChkChar(Copy($Str,$L), $ch)
		$L -= 1
	WEnd
	Return StringLeft($Str,$L)
EndFunc   ;==>TrimRight

; #FUNCTION# ====================================================================================================================
; Name...........: TrimStr
; Description ...: ������� ������, ��������� ���������� $ch, � ���� ������
; Syntax.........: TrimStr($Str, $ch)
; Parameters ....: $Str - ������ ��� ���������
;                  $ch - ������ ��� ���������
; Return values .: String
; Example .......: TrimStr("abctestabc", 'abc') => test, TrimStr('.".test.".', '.".') => test
; ===============================================================================================================================
Func TrimStr($Str, $ch='')
	If $ch <> '' Then
		$LS = StringLen($ch)
		$SL = StringLen($Str)
		$L = 1
		While $L <= $SL - $LS + 1
			If Copy($Str, 1, $LS) = $ch Then
				$Str = StringRight($Str,$SL-$L+1)
				$L += $LS
			Else
				ExitLoop
			EndIf
		WEnd

		$L = StringLen($Str)
		While $L >= $LS
			If StringRight($Str,$LS) = $ch Then
				$L -= $LS
				$Str = StringLeft($Str,$L)
			Else
				ExitLoop
			EndIf
		WEnd
	EndIf
	Return $Str
EndFunc   ;==>TrimStr

; #FUNCTION# ====================================================================================================================
; Name...........: TrimStrLeft
; Description ...: ������� ������ �����, ��������� ���������� $ch
; Syntax.........: TrimStrLeft($Str, $ch)
; Parameters ....: $Str - ������ ��� ���������
;                  $ch - ������ ��� ���������
; Return values .: String
; Example .......: TrimStrLeft("abctest", 'abc') => test, TrimStrLeft('.".test', '.".') => test
;                  TrimStrLeft(".'.test", ".'.") => test
; ===============================================================================================================================
Func TrimStrLeft($Str, $ch='')
	If $ch <> '' Then
		$LS = StringLen($ch)
		$SL = StringLen($Str)
		$L = 1
		While $L <= $SL - $LS + 1
			If Copy($Str, 1, $LS) = $ch Then
				$Str = StringRight($Str,$SL-$L+1)
				$L += $LS
			Else
				ExitLoop
			EndIf
		WEnd
	EndIf
	Return $Str
EndFunc   ;==>TrimStrLeft

; #FUNCTION# ====================================================================================================================
; Name...........: TrimStrRight
; Description ...: ������� ������ ������, ��������� ���������� $ch
; Syntax.........: TrimStrRight($Str, $ch)
; Parameters ....: $Str - ������ ��� ���������
;                  $ch - ������ ��� ���������
; Return values .: String
; Example .......: TrimStrRight("testabc", 'abc') => test, TrimStrRight('test.".', '.".') => test
;                  TrimStrRight("test.'.", ".'.") => test
; ===============================================================================================================================
Func TrimStrRight($Str, $ch='')
	If $ch <> '' Then
		$LS = StringLen($ch)
		$L = StringLen($Str)
		While $L >= $LS
			If StringRight($Str,$LS) = $ch Then
				$L -= $LS
				$Str = StringLeft($Str,$L)
			Else
				ExitLoop
			EndIf
		WEnd
	EndIf
	Return $Str
EndFunc   ;==>TrimStrRight

; #FUNCTION# ====================================================================================================================
; Name...........: NormalCenter
; Description ...: ����������� ������� � ���������� ������� � �������� �� ������, ��� ���������� ��������� $ch ����������� ������ ���
; Syntax.........: NormalCenter($Str[, $ch])
; Parameters ....: $Str - ������ ��� ���������
;                  $ch - ������ ��� ��������(�������������� ����������)
; Return values .: String
; Example .......: NormalCenter("a   b    c") => a b c, NormalCenter("a...b", '.') => a.b
;                  NormalCenter('a"""b', '"') => a"b
; ===============================================================================================================================
Func NormalCenter($Str, $ch='')
	$L = StringLen($Str)
	$K = 0
	For $i = $L To 1 Step -1
		If ChkChar(Copy($Str,$i), $ch) Then
			$K += 1
		Else
			If $K > 0 Then
				$Str = Delete($Str, $i + 1, $K - 1)
				$K = 0
			EndIf
		EndIf
	Next
	Return $Str
EndFunc   ;==>NormalCenter

; #FUNCTION# ====================================================================================================================
; Name...........: NormalText
; Description ...: ������� ������� � ���������� ������� � ���� ������, ����������� ������� � ���������� ������� � �������� �� ������
;                  ��� ���������� ��������� $ch ������� � ���� ������ � ����������� ������ ���
; Syntax.........: NormalText($Str[, $ch])
; Parameters ....: $Str - ������ ��� ���������
;                  $ch - ������ ��� ��������(�������������� ����������)
; Return values .: String
; Example .......: NormalText(@TAB&"a   b  "&@CRLF) => a b, NormalText("...a...b...", '.') => a.b
;                  NormalText('""a"""b""', '"') => a"b
; ===============================================================================================================================
Func NormalText($Str, $ch='')
	$Str = Trim($Str, $ch)
	$L = StringLen($Str)
	$K = 0
	For $i = $L To 1 Step -1
		If ChkChar(Copy($Str,$i), $ch) Then
			$K += 1
		Else
			If $K > 0 Then
				$Str = Delete($Str, $i + 1, $K - 1)
				$K = 0
			EndIf
		EndIf
	Next
	Return $Str
EndFunc   ;==>NormalText

; #FUNCTION# ====================================================================================================================
; Name...........: ChkChar
; Description ...: ������ �������� (������������ ��������� ���������)
; Syntax.........: ChkChar($char[, $ch])
; Parameters ....: $char - ������ ������� ���������
;                  $ch - ������ � ������� ���������
; Return values .: Boolean
; Example .......: ChkChar(@CRLF) => True, ChkChar('a', 'a') => True, ChkChar('b', 'c') => False
; ===============================================================================================================================
Func ChkChar($char, $ch='')
	If $ch='' Then
		Local $chr[6] = [Chr(0),Chr(9),Chr(10),Chr(11),Chr(13),Chr(32)]
		If $char <> '' Then
			For $c In $chr
				If $char = $c Then
					Return True
				EndIf
			Next
		EndIf
	ElseIf $char = $ch Then
		Return True
	EndIf
	Return False
EndFunc   ;==>ChkChar

; #FUNCTION# ====================================================================================================================
; Name...........: Copy
; Description ...: �������� ����� ������ (������������ ��������� ���������)
; Syntax.........: Copy($Str[,$From[,$Count]])
; Parameters ....: $Str - ������ ��� ���������
;                  $From - ������� ������ �����������
;                  $Count - ���������� �������� ��� �����������
; Return values .: String
; Example .......: Copy("test",3) => s, Copy("test",3,2) => st, Copy("test") => t
; ===============================================================================================================================
Func Copy($Str,$From=1,$Count=1)
	$L = StringLen($Str)
	If $From > 0 And $Count > 0 Then
		$F = $From + $Count - 1
		If $L < $F Then
			$Count = $Count - ($F - $L)
		EndIf
		Return StringMid($Str,$From,$Count)
	EndIf
	Return $Str
EndFunc   ;==>Copy

; #FUNCTION# ====================================================================================================================
; Name...........: Delete
; Description ...: ������� ����� ������ (������������ ��������� ���������)
; Syntax.........: Delete($Str,$From,$Count)
; Parameters ....: $Str - ������ ��� ���������
;                  $From - ������� ������ ��������
;                  $Count - ���������� �������� ��� ��������
; Return values .: String
; Example .......: Delete("test",2,2) => tt, Delete("test") => test, Delete("test", 3) => test
; ===============================================================================================================================
Func Delete($Str,$From=1,$Count=0)
	$L = StringLen($Str)
	If $From > 0 And $Count > 0 Then
		$F = $From + $Count - 1
		If $L < $F Then
			$Count = $Count - ($F - $L)
		EndIf
		If $From = 1 Then
			Return StringRight($Str,$L-$Count)
		ElseIf $From = $L - $Count + 1 Then
			Return StringLeft($Str,$L-$Count)
		Else
			$s1 = StringLeft($Str,$From-1)
			$s2 = StringRight($Str,$L-$From-$Count+1)
			Return $s1&$s2
		EndIf
	EndIf
	Return $Str
EndFunc   ;==>Delete
