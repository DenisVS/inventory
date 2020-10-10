#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

Func _DeleteEmptyRows($aArray)
    Local $Rows = Ubound($aArray,1)
    Local $Cols = Ubound($aArray,2)
    Local $aTemp[$Rows][$Cols]
    Local $not_empty
    Local $Count = 0
    
    ;Loop through rows
    For $Y = 0 to $Rows - 1
        $not_empty = 0
        
        ;Loop through columns
        For $X = 0 to $Cols - 1
            
            ;Copy all columns to temp array even if they are all empty
            $aTemp[$Count][$X] = $aArray[$Y][$X]
            
            ;If even one column contains data, make sure it doesn't get deleted
            If $aArray[$Y][$X] <> "" Then $not_empty = BitOr($not_empty, 1)
        Next
        
        ;If the row has any data, increment, else keep overwriting last row until it contains something
        If $not_empty Then $Count += 1
    Next

    Redim $aTemp[$Count][$Cols]
    Return $aTemp
EndFunc