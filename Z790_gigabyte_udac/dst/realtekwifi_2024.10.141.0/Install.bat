@echo off
CLS
setlocal enabledelayedexpansion

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    pushd "%CD%"
    CD /D "%~dp0"
    xcopy *.* %temp%\RtWlanDrv\*.* /e /y /c /i
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %temp%\RtWlanDrv\Install.bat %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    popd
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
:--------------------------------------

pushd "%CD%"
CD /D "%~dp0"
:--------------------------------------
echo **************************************************************
echo ***  Silent Install Realtek Package               
echo ***                                                            
echo ***  Please wait a moment	                  
echo=
Setup.exe /s /f2"c:\setup.log"
echo=     
echo ***  Package Install Finished        
echo **************************************************************                               
echo=
popd
if exist "%temp%\RtWlanDrv" ( rmdir /s /q %temp%\RtWlanDrv )