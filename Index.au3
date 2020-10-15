;------- Includes fn  -----------
;-- Common
;~ #include "Loga.au3"
#include <file.au3>
#RequireAdmin
#include "ParseData.au3"
#include "HttpPost.au3"


;-- from main.au3

#include "csvString2array.au3"
#include "fileRead.au3"
#include "StringFilter.au3"
#include "ArrayDeleteEmptyRows.au3"
#include "WideRedim.au3"
#include "DataProcessing.au3"
#include "CSVSplit.au3"
#include "ArrayCompare.au3"
#include "Encoding.au3"
#include "StringTrimmer.au3"

;-- from gui.au3

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>


; Predefined variables ---------------------
;~ AutoItSetOption ("TrayIconDebug", 1);0-off
;~ #AutoIt3Wrapper_Run_Debug_Mode=Y
$parametersFileName = "parameters.csv"
;~ $aidaReportFileName = "Report.csv"
$aidaReportFileName = @TempDir & "\Report.csv"
;$aidaReportFileName = "C:" & "\report.csv"
$aidaConfigFileName = 'C:\PF\Aida6biz\aida64.rpf'
$aidaExecute = 'C:\PF\Aida6biz\aida64.exe'
$aidaDir = 'C:\PF\Aida6biz\'


;------- Includes fn (Run) -----------
#include <StartGui.au3>
















