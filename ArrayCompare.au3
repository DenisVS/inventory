
Func _ArrayCompare (Const ByRef $array1, Const ByRef $array2)
   ; Check Subscripts
   $array1NumDimensions = UBound ($array1, 0)
   $array2NumDimensions = UBound ($array2, 0)

   ; Static Variables
   Static $arrayMatch
   Static $evaluationString = ""
   Static $dimension = 0

   If $dimension = 0 Then
      If $array1NumDimensions <> $array2NumDimensions Then
         Return SetError (1, 0, False)
      EndIf

      If $array1NumDimensions = 0 Then
         Return SetError (2, 0, False)
      EndIf
   EndIf

   Switch $dimension
      Case 0
         ; Start the iterations
         $arrayMatch = True
         $dimension = 1
         _ArrayCompare ($array1, $array2)
         $dimension = 0
      Case Else
         ; Save string to revert back
         $oldString = $evaluationString

         For $i = 0 To (UBound ($array1, $dimension) - 1)
            ; Add dimension to the string
            $evaluationString &= "[" & $i & "]"

            If $dimension = $array1NumDimensions Then
               ; Evaluate the string
               $arrayMatch = Execute ("$array1" & $evaluationString & " = $array2" & $evaluationString)

               ConsoleWrite ($evaluationString & " : " & $arrayMatch & @CRLF)
            Else
               ; Call the function for the next dimension
               $dimension += 1
               _ArrayCompare ($array1, $array2)
               $dimension -= 1
            EndIf

            ; Revert to old string
            $evaluationString = $oldString

            ; Dump out after the first mismatch
            If $arrayMatch = False Then
               ExitLoop
            EndIf
         Next
      EndSwitch
   Return $arrayMatch
EndFunc