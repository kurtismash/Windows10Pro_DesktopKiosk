' A simple script to run a batch file without the cmd.exe window appearing.

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run chr(34) & "C:\autoRestart.bat" & Chr(34), 0
Set WshShell = Nothing