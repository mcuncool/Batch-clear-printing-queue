@echo off
::"%WINDIR%\System32\spool\PRINTERS\*"
>nul 2>nul dir "%WINDIR%\System32\spool\PRINTERS" /a-d && (goto :service) || (goto :end)

:service
echo Trying to stop printing service
net stop spooler
if errorLevel == 1 goto :crash

echo Deleting the jobs in the queue
del /F /Q "%WINDIR%\System32\spool\PRINTERS\*"
echo. 

echo Trying to start printing service
net start spooler
if errorLevel == 1 goto :crash
goto :end


:end
echo Done !
pause
exit

:crash
echo This is unfortunate...
echo Try rightclick and execute as administrator
pause
exit