#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <File.au3>

  Local $sFilePath = "..\GUI\logo_autoit_210x72.gif"

    ; Create a GUI with various controls.
    Local $hGUI = GUICreate("Инвентаризация", 800, 550)
    GUICtrlCreatePic("..\GUI\msoobe.jpg", 0, 0, 400, 100)


	GUICtrlCreateLabel("Отдел", 5, 30) ; first cell 70 width
	 Local $idFile = GUICtrlCreateInput("", 150, 30, 300, 20)

	GUICtrlCreateLabel("Ф.И.О. пользователя", 5, 60) ; next line

    ;GUICtrlSetState(-1, $GUI_DROPACCEPTED)
    GUICtrlCreateInput("", 150, 60, 300, 20) ; will not accept drag&drop files


	GUICtrlCreateLabel("Телефон пользователя", 5, 90) ; next line
    GUICtrlCreateInput("", 150, 90, 300, 20)

	GUICtrlCreateLabel("Логин администратора", 5, 120) ; next line
    GUICtrlCreateInput("", 150, 120, 300, 20)

	GUICtrlCreateLabel("Пароль администратора", 5, 150) ; next line
    GUICtrlCreateInput("", 150, 150, 300, 20)

	GUICtrlCreateLabel("Логин пользователя", 5, 180) ; next line
    GUICtrlCreateInput("", 150, 180, 300, 20)

	GUICtrlCreateLabel("Пароль пользователя", 5, 210) ; next line
    GUICtrlCreateInput("", 150, 210, 300, 20)

	GUICtrlCreateLabel("Куда подключен ПК", 5, 240) ; next line
    GUICtrlCreateInput("", 150, 240, 300, 20)

	GUICtrlCreateLabel("Примечания", 5, 270) ; next line
	GUICtrlCreateEdit("", 150, 270, 300, 97, $ES_AUTOVSCROLL + $WS_VSCROLL)

	;Local $idProgressbar2 = GUICtrlCreateProgress(300, 520, 200, 20, $PBS_SMOOTH)
	Local $idInformation = GUICtrlCreateLabel("СБОР ИНФОРМАЦИИ О ПК, ЖДИТЕ", 300, 420 )
 GUICtrlSetBkColor($idInformation, 0xFF0000)

    Local $idButton_Submit = GUICtrlCreateButton("Отправить на сервер", 180, 470, 150, 25)
    Local $idButton_Save = GUICtrlCreateButton("Сохранить на стол", 500, 470, 150, 25)

    ; Display the GUI.
    GUISetState(@SW_SHOW, $hGUI)

    Local $hChild = GUICreate("", 210, 72, 20, 15, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hGUI)

    ; Create a picture control with a transparent image.
    GUICtrlCreatePic($sFilePath, 0, 0, 210, 72)

    ; Display the child GUI.
    GUISetState(@SW_SHOW)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop

            Case $GUI_EVENT_CLOSE, $idButton_Submit
                ExitLoop

            Case $idButton_Save



; List all the files in the current script directory.
Local $aScriptDir = _FileListToArray(@ScriptDir)
; Create a file in the users %TEMP% directory.
Local $sFilePath = @DesktopDir & "\Report.csv"
; Write array to a file by passing the file name.
_FileWriteFromArray($sFilePath, $aScriptDir, 1)
; Display the file.
ShellExecute($sFilePath)

GUICtrlSetBkColor($idInformation, 0x00FF00)
GUICtrlSetData($idInformation, "Сбор информации завершён")

; Run Notepad with the window maximized.
                ;$iPID = Run("notepad.exe", "", @SW_SHOWMAXIMIZED)
				;Local $idButton = GUICtrlCreateButton("Start", 75, 70, 70, 20)
                   $iSavPos = 0
                    ;GUICtrlSetData($idProgressbar1, $i)
                    ;GUICtrlSetData($idProgressbar2, (50))

        EndSwitch
    WEnd

    ; Delete the previous GUIs and all controls.
    GUIDelete($hGUI)
    GUIDelete($hChild)