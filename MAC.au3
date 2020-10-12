; MAC.au3
; conversions between Map, Array, Csv

; unsorted notes:
; these functions convert:
;       AutoIt arrays to/from a CSV-style string
;       AutoIt maps to/from a CSV-style string
;       AutoIt arrays to/from AutoIt maps
; it is caller responsability to supply:
;       a variable (0 to 2 dimensions) to _ArrayToCsv and _ArrayToMap,
;       a valid map to _MapToArray and _MapToCsv,
;       a Unicode CSV-style string to _CsvToArray and _CsvToMap.
; flags: 1 forces transposition
; require 3.3.10+
;
; these functions are built to preserve basic types (where possible).
; CSV syntax rules:
; - no header line
; - rows terminated by CR or LF or CRLF (optional on the last line)
; - values separated by commas, possibly preceeded and/or followed by whitespaces (ignored)
; - Unicode
; - every string value must be enclosed in double-quotes
; - double-quotes within a string need to be doubled
; - CR, LF & CRLF may be embedded in string fields
; - integers and floating-point may be signed (but 0 = +0 = -0 = 0.0 = +0.0 = -0.0 i.e. sign of zero is not preserved in round-trip)
; - binary values take the form 0x0123456789ABCDEF
; - pointers are encoded as @0x123456789
; - hWnd are encoded as *0x123456789
; - a Null is represented by an empty field or the value Null
; - {False, True} mapped to boolean
; - binary values enclosed in curly brakets represent structure contents
; - value Default represents keyword Default
; - a [user]function reference takes the form MYFUNCTION()
; - the value <-invalid-> represents an invalid value (generally created from conversion of an untranslatable type in source array)
; Array types (input of flat variables and 1D arrays are OK and converted to 2D):
; - string
; - integer
; - double
; - binary
; - boolean mapped to {False,True}
; - keyword Default mapped to value Default
; - keyword Null mapped to value Default
; - ptr and hWnd are converted to corresponding types (exporting these is probably useless)
; - structures: content mapped to structure of bytes enclosed in curly brakets
; - functions references e.g. reference to function xyz are converted to XYZ()
; - other untranslatable types (arrays, maps, objects) mapped to value <-invalid->
; Maps:
; - when converting to map, CSV or Array will need 1 or more column:
; - when only one column exists in the input, map entries will use keys numbered from 0
; - when two or more column exist in the input, the first column will be the keys and the second will be associated items (unless transposed)
; - when the key read from array or CSV is an integer, the item will be created with an integer key
;   else the key read off array or CSV will be translated to a string


Global Const $_MAC_INVALID = '<-invalid->'

Func _ArrayToCsv($aIn, $bFlags = 0)
    Switch UBound($aIn, 0)
        Case 0
            Local $aIn1[1] = [$aIn]
            $aIn = $aIn1
            ContinueCase
        Case 1
            Local $aIn2[UBound($aIn)][1]
            For $i = 0 To UBound($aIn) - 1
                $aIn2[$i][0] = $aIn[$i]
            Next
            $aIn = $aIn2
            ContinueCase
        Case 2
            Local $sline, $sOut
            If BitAND($bFlags, 1) Then  ; transpose ?
                For $i = 0 To UBound($aIn, 2) - 1
                    $sline = ''
                    For $j = 0 To UBound($aIn, 1) - 2
                        $sline &= __CsvValueEncode($aIn[$j][$i]) & ','
                    Next
                    $sOut &= $sline & __CsvValueEncode($aIn[UBound($aIn, 1) - 1][$i]) & @CRLF
                Next
            Else
                For $i = 0 To UBound($aIn, 1) - 1
                    $sline = ''
                    For $j = 0 To UBound($aIn, 2) - 2
                        $sline &= __CsvValueEncode($aIn[$i][$j]) & ','
                    Next
                    $sOut &= $sline & __CsvValueEncode($aIn[$i][UBound($aIn, 2) - 1]) & @CRLF
                Next
            EndIf
        Case Else
            Return SetError(1, 0, 0)
    EndSwitch
    Return $sOut
EndFunc


Func _CsvToArray(ByRef $sIn, $bFlags = 0)
    Local Const $kField = ' ( (?:".*?")+ | [@*{]?0x[[:xdigit:]]+\}? | [+-]?\d*\.?\d+(?:E[+-]?\d+)? | True | False | Null | Default | \w+\(\) | ' & $_MAC_INVALID & ' | (?<=,|^)\h*(?=,|$) ) '
    Local $aLine = StringRegExp($sIn, '(?imsx)((?:\h*' & $kField & '\h*,?)+)\R?', 1)
    Local $aFields = StringRegExp($aLine[0], '(?imsx)' & $kField, 3)
    Local $iCols = UBound($aFields)
    StringRegExpReplace($sIn, '(?imsx)((?:\h*' & $kField & '\h*)(?:,\h*' & $kField & '\h*){' & $iCols - 1 & '}\R?)', '')
    Local $iRows = @extended
    Local $iOfs = 1
    If BitAND($bFlags, 1) Then  ; transpose ?
        Local $aOut[$iCols][$iRows]
    Else
        Local $aOut[$iRows][$iCols]
    EndIf
    Local $vField
    For $i = 0 To $iRows - 1
        $aLine = StringRegExp($sIn, '(?imsx)((?:\h*' & $kField & '\h*,?)+)\R?', 1, $iOfs)
        $iOfs = @extended
        $aFields = StringRegExp($aLine[0], '(?imsx)' & $kField, 3)
        For $j = 0 To $iCols - 1
            $vField = $aFields[$j]
            Select
                Case StringLeft($vField, 1) = '"'
                    $vOut = StringReplace(StringMid($vField, 2, StringLen($vField) - 2), '""', '"')
                Case StringRegExp($vField, '^0x[[:xdigit:]]+$')
                    $vOut = Binary($vField)
                Case StringRegExp($vField, '(?i)^[+-]?\d*\.?\d+(?:e[+-]?\d+)?$')
                    $vOut = Number($vField)
                Case $vField = '' Or $vField = 'Null' Or StringRegExp($vField, '^\h+$')
                    $vOut = Null
                Case $vField = 'True'
                    $vOut = True
                Case $vField = 'False'
                    $vOut = False
                Case StringRegExp($vField, '^[@*]0x[[:xdigit:]]+$')
                    Local $ptr = Ptr(StringTrimLeft($vField, 1))
                    If StringMid($vField, 1, 1) = '@' Then
                        $vOut = IsHWnd(HWnd($ptr)) ? HWnd($ptr) : $ptr
                    Else
                        $vOut = $ptr
                    EndIf
                Case StringRegExp($vField, '^\{0x[[:xdigit:]]+\}$')
                    $vField = Binary(StringMid($vField, 2, StringLen($vField) - 2))
                    Local $tStruct = DllStructCreate('byte[' & BinaryLen($vField) & ']')
                    DllStructSetData($tStruct, 1, $vField)
                    $vOut = $tStruct
                Case $vField = 'Default'
                    $vOut = Default
                Case StringRegExp($vField, '^\w+\(\)$')
                    $vOut = Execute(StringTrimRight($vField, 2))
                Case Else
                    $vOut = $_MAC_INVALID
            EndSelect
            If BitAND($bFlags, 1) Then  ; transpose ?
                $aOut[$j][$i] = $vOut
            Else
                $aOut[$i][$j] = $vOut
            EndIf
        Next
    Next
    Return $aOut
EndFunc


Func __CsvValueEncode(ByRef $vVar)
    Select
        Case IsInt($vVar) Or IsBool($vVar) Or IsBinary($vVar) Or IsKeyword($vVar) Or $vVar = $_MAC_INVALID
            Return $vVar
        Case IsString($vVar)
            Return '"' & StringReplace($vVar, '"', '""') & '"'
        Case VarGetType($vVar) = "Double"
            Return $vVar & (IsInt($vVar) ? '.0' : '')
        Case IsFunc($vVar)
            Return FuncName($vVar) & '()'
        Case IsHWnd($vVar)
            Return '@' & $vVar
        Case IsPtr($vVar)
            Return '*' & $vVar
        Case IsDllStruct($vVar)
            Local $tStruct = DllStructCreate('byte[' & DllStructGetSize($vVar) & ']', DllStructGetPtr($vVar))
            Return '{' & DllStructGetData($tStruct, 1) & '}'
        Case Else
            Return $_MAC_INVALID
    EndSelect
EndFunc


Func _ArrayToMap(ByRef $aIn, $bFlags = 0)
    Local $mOut[]
    Switch UBound($aIn, 0)
        Case 0
            $mOut[0] = $aIn
        Case 1
            For $i = 0 To UBound($aIn) - 1
                $mOut[$i] = $aIn[$i]
            Next
        Case 2
            For $i = 0 To UBound($aIn, 1) - 1
                If BitAND($bFlags, 1) Then  ; transpose ?
                    Switch VarGetType($aIn[$i][1])
                        Case "Int32", "Int64"
                            $mOut[$aIn[$i][1]] = $aIn[$i][0]
                        Case Else
                            $mOut[String($aIn[$i][1])] = $aIn[$i][0]
                    EndSwitch
                Else
                    Switch VarGetType($aIn[$i][0])
                        Case "Int32", "Int64"
                            $mOut[$aIn[$i][0]] = $aIn[$i][1]
                        Case Else
                            $mOut[String($aIn[$i][0])] = $aIn[$i][1]
                    EndSwitch
                EndIf
            Next
        Case Else
            Return SetError(1, 0, 0)
    EndSwitch
    Return $mOut
EndFunc


;~ Func _MapToArray(ByRef $mIn, $bFlags = 0)
;~     If BitAND($bFlags, 1) Then  ; transpose ?
;~         Local $aOut[2][UBound($mIn)]
;~     Else
;~         Local $aOut[UBound($mIn)][2]
;~     EndIf
;~     Local $i = 0
;~     For $key In Mapkeys($mIn)
;~         If BitAND($bFlags, 1) Then  ; transpose ?
;~             $aOut[0][$i] = $key
;~             $aOut[1][$i] = $mIn[$key]
;~         Else
;~             $aOut[$i][0] = $key
;~             $aOut[$i][1] = $mIn[$key]
;~         EndIf
;~         $i += 1
;~     Next
;~     Return $aOut
;~ EndFunc


Func _CsvToMap(ByRef $sIn)
    Local $mOut[]
    Local Const $kField = ' ( (?:".*?")+ | [@*{]?0x[[:xdigit:]]+\}? | [+-]?\d*\.?\d+(?:E[+-]?\d+)? | True | False | Null | Default | \w+\(\) | ' & $_MAC_INVALID & ' | (?<=,|^)\h*(?=,|$) ) '
    Local $aLine = StringRegExp($sIn, '(?imsx)((?:\h*' & $kField & '\h*,?)+)\R?', 1)
    Local $aFields = StringRegExp($aLine[0], '(?imsx)' & $kField, 3)
    Local $iCols = UBound($aFields)
    StringRegExpReplace($sIn, '(?imsx)((?:\h*' & $kField & '\h*)(?:,\h*' & $kField & '\h*){' & $iCols - 1 & '}\R?)', '')
    Local $iRows = @extended
    Local $iOfs = 1
    Local $vField
    Local $vKey
    For $i = 0 To $iRows - 1
        $aLine = StringRegExp($sIn, '(?imsx)((?:\h*' & $kField & '\h*,?)+)\R?', 1, $iOfs)
        $iOfs = @extended
        $aFields = StringRegExp($aLine[0], '(?imsx)' & $kField, 3)
        If StringRegExp($aFields[0], "^[+-]?\d+$") Then
            $vKey = Int($aFields[0])
        Else
            $vKey = StringReplace(StringMid($aFields[0], 2, StringLen($aFields[0]) - 2), '""', '"')     ; whatever that gives!
        EndIf
        $vField = $aFields[1]
        Select
            Case StringLeft($vField, 1) = '"'
                $mOut[$vKey] = StringReplace(StringMid($vField, 2, StringLen($vField) - 2), '""', '"')
            Case StringRegExp($vField, '^0x[[:xdigit:]]+$')
                $mOut[$vKey] = Binary($vField)
            Case StringRegExp($vField, '(?i)^[+-]?\d*\.?\d+(?:e[+-]?\d+)?$')
                $mOut[$vKey] = Number($vField)
            Case $vField = '' Or $vField = 'Null' Or StringRegExp($vField, '^\h+$')
                $mOut[$vKey] = Null
            Case $vField = 'True'
                $mOut[$vKey] = True
            Case $vField = 'False'
                $mOut[$vKey] = False
            Case StringRegExp($vField, '^[@*]0x[[:xdigit:]]+$')
                Local $ptr = Ptr(StringTrimLeft($vField, 1))
                If StringMid($vField, 1, 1) = '@' Then
                    $mOut[$vKey] = IsHWnd(HWnd($ptr)) ? HWnd($ptr) : $ptr
                Else
                    $mOut[$vKey] = $ptr
                EndIf
            Case StringRegExp($vField, '^\{0x[[:xdigit:]]+\}$')
                $vField = Binary(StringMid($vField, 2, StringLen($vField) - 2))
                Local $tStruct = DllStructCreate('byte[' & BinaryLen($vField) & ']')
                DllStructSetData($tStruct, 1, $vField)
                $mOut[$vKey] = $tStruct
            Case $vField = 'Default'
                $mOut[$vKey] = Default
            Case StringRegExp($vField, '^\w+\(\)$')
                $mOut[$vKey] = Execute(StringTrimRight($vField, 2))
            Case Else
                $mOut[$vKey] = $_MAC_INVALID
        EndSelect
    Next
    Return $mOut
EndFunc


;~ Func _MapToCsv(ByRef $mIn, $bFlags = 0)
;~     If BitAND($bFlags, 1) Then  ; transpose ?
;~         Local $sOut, $sline
;~         For $key In Mapkeys($mIn)
;~             $sOut &= __CsvValueEncode($key) & ','
;~             $sline &= __CsvValueEncode($mIn[$key]) & ','
;~         Next
;~         Return StringTrimRight($sOut, 1) & @CRLF & StringTrimRight($sline, 1) & @CRLF
;~     Else
;~         Local $sOut
;~         For $key In Mapkeys($mIn)
;~             $sOut &= __CsvValueEncode($key) & ',' & __CsvValueEncode($mIn[$key]) & @CRLF
;~         Next
;~         Return $sOut
;~     EndIf
;~ EndFunc


; example use
#cs

#include "..\include\dump.au3"

Local $a[3][2] = [ _
    [3.1415926, Ptr(0x12345678)], _
    ["ab""c", -1], _
    [WinGetHandle(AutoItWinGetTitle()), Null] _
]

Local $out = _ArrayToMap($a)
_consolewrite(_vardump($out) & @LF)

Local $aa = _MapToArray($out)
_consolewrite(_vardump($aa) & @LF)

Local $csv = _MapToCsv($out)
_ConsoleWrite($csv & @LF)

Local $mm = _CsvToMap($csv)
_consolewrite(_vardump($mm) & @LF)

Func _ConsoleWrite($s)
    ConsoleWrite(BinaryToString(StringToBinary($s, 4), 1))
EndFunc

;~ Exit
#ce

;~ #include <Array.au3>

;~ Local $s = "@" & WinGetHandle(AutoItWinGetTitle()) & ", 55.456e-8, *" & Ptr(0x12345678) & ",,"""",StringLen()" & ',"abc ""123"" def"'
;~ ConsoleWrite($s & @LF)
;~ Local $a = _CsvToArray($s)
;~ _ArrayDisplay($a)
;~ For $i = 0 To UBound($a, 2) - 1
;~     ConsoleWrite(VarGetType($a[0][$i]) & " = " & ($a[0][$i] = Null ? "Null" : $a[0][$i]) & @LF)
;~ Next
;~ Local $t = _ArrayToCsv($a)
;~ ConsoleWrite($t & @LF)
