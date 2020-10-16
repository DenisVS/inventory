If Not FileExists(@TempDir & "\inventory\Aida6biz-lite\") Then
    Do
        DirCreate(@TempDir & "\inventory\Aida6biz-lite\")
    Until FileExists(@TempDir & "\inventory\Aida6biz-lite\")
EndIf
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\afaapi.dll", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida64.dat", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida64.exe", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida64.exe.manifest", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida64.mem", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida64.rpf", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida_rcc.dll", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida_rcs.dll", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida_uires.dll", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida_uireshd.dll", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\aida_vsb.vsb", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\kerneld.ia64", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\kerneld.v64", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\kerneld.w9x", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\kerneld.x32", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\kerneld.x64", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\pkey.txt", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\storelib.dll", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\storelibir-2.dll", @TempDir & "\inventory\Aida6biz-lite\", 0)
FileInstall("C:\data\projects\inventory\files\Aida6biz-lite\storelibir.dll", @TempDir & "\inventory\Aida6biz-lite\", 0)
If Not FileExists(@TempDir & "\inventory\conf\") Then
    Do
        DirCreate(@TempDir & "\inventory\conf\")
    Until FileExists(@TempDir & "\inventory\conf\")
EndIf
FileInstall("C:\data\projects\inventory\src\trunk\parameters.csv", @TempDir & "\inventory\conf\", 0)
